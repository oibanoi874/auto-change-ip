# -*- coding: utf-8 -*-
#!/bin/bash
clear
echo -e "\e[1;32m┌───────────────────────────────────────┐\e[0m"
echo -e "\e[1;32m│              \e[0m\e[1;36mOIBANOI874               \e[1;32m│\e[0m"
echo -e "\e[1;32m│            \e[0m\e[1;36mAUTO CHANGE IP             \e[1;32m│\e[0m"
echo -e "\e[1;32m└───────────────────────────────────────┘\e[0m"
echo -e "\e[1;34m==========================================\e[0m"

echo -e "\e[1;32m[+] Thiết lập cấu hình Tor và Privoxy...\e[0m"
pkill tor
pkill privoxy
rm -rf ~/.tor_multi ~/.privoxy
mkdir -p ~/.tor_multi ~/.privoxy

echo -e "\e[1;32m[+] Khởi chạy Tor Nodes & Proxy Server...\e[0m"
echo -e "\e[1;34m==========================================\e[0m"
PORTS=(9050 9060 9070 9080 9090)
CONTROL_PORTS=(9051 9061 9071 9081 9091)

for i in {0..4}; do
    TOR_DIR="$HOME/.tor_multi/tor$i"
    mkdir -p "$TOR_DIR"
    cat <<EOF > "$TOR_DIR/torrc"
SocksPort ${PORTS[$i]}
ControlPort ${CONTROL_PORTS[$i]}
DataDirectory $TOR_DIR
CookieAuthentication 0
EOF
    tor -f "$TOR_DIR/torrc" > /dev/null 2>&1 &
    sleep 2
done

# Privoxy Setup
cat <<EOF > "$HOME/.privoxy/config"
listen-address 127.0.0.1:8118
EOF
for port in "${PORTS[@]}"; do
    echo "forward-socks5 / 127.0.0.1:$port ." >> "$HOME/.privoxy/config"
done
privoxy "$HOME/.privoxy/config" > /dev/null 2>&1 &

COUNT=0
while true; do
    # Gửi lệnh đổi IP Tor
    for ctrl_port in "${CONTROL_PORTS[@]}"; do
        echo -e "AUTHENTICATE \"\"\r\nSIGNAL NEWNYM\r\nQUIT" | nc 127.0.0.1 $ctrl_port > /dev/null 2>&1
    done

    # Đợi Tor cấp IP mới
    sleep 3

    # Lấy IP + thông tin
    IP_INFO=$(curl --proxy http://127.0.0.1:8118 -s https://ipinfo.io/json)
    NEW_IP=$(echo "$IP_INFO" | grep '"ip":' | cut -d'"' -f4)
    COUNTRY=$(echo "$IP_INFO" | grep '"country":' | cut -d'"' -f4)
    CITY=$(echo "$IP_INFO" | grep '"city":' | cut -d'"' -f4)

    # Nếu không lấy được IP thì thử lại
    if [[ -z "$NEW_IP" ]]; then
        continue
    fi

    COUNT=$((COUNT + 1))
    TIME_NOW=$(date +"%H:%M:%S:")

    echo -e "\e[1;36m[Thời gian]: ${TIME_NOW}\e[0m"
    echo -e "\e[1;36m[IP mới]: $NEW_IP\e[0m"
    echo -e "\e[1;36m[Quốc gia]: $COUNTRY\e[0m"
    echo -e "\e[1;36m[Thành phố]: $CITY\e[0m"
    echo -e "\e[1;36m[Proxy]: 127.0.0.1:8118\e[0m"
    echo -e "\e[1;36m[Số lần đổi ip]: $COUNT\e[0m"
    echo -e "\e[1;34m==========================================\e[0m"
    DELAY_TIME=30
    for ((t=DELAY_TIME; t>0; t--)); do
        echo -ne "\r\033[K\033[1;36m[Delay]: ${t}s\033[0m"
        sleep 1
    done
    echo -ne "\r\033[K"

done