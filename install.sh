#!/bin/bash

YELLOW='\033[33m'
RED='\033[31m'
GREEN='\033[32m'
NC='\033[0m'

echo -e "⏰ ${YELLOW}Bắt đầu cài đặt các gói cơ bản: curl, wget, unzip...${NC}"
pkg install curl wget unzip -y > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo -e "😀 ${GREEN}Cài đặt curl, wget, unzip thành công!${NC}"
else
    echo -e "😭 ${RED}Lỗi: Không thể cài đặt các gói cơ bản.${NC}"
    exit 1
fi

echo -e "⏰ ${YELLOW}Bắt đầu thêm kho lưu trữ Tur-Repo...${NC}"
pkg install tur-repo -y > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo -e "😀 ${GREEN}Thêm Tur-Repo thành công!${NC}"
else
    echo -e "😭 ${RED}Lỗi: Không thể thêm Tur-Repo.${NC}"
    exit 1
fi

echo -e "⏰ ${YELLOW}Bắt đầu cài đặt Tor, Privoxy và Netcat...${NC}"
pkg install tor privoxy netcat-openbsd -y > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo -e "😀 ${GREEN}Cài đặt Tor, Privoxy, Netcat thành công!${NC}"
else
    echo -e "😭 ${RED}Lỗi: Không thể cài đặt Tor, Privoxy, Netcat.${NC}"
    exit 1
fi

echo "---"
echo -e "😀 ${GREEN}Tất cả các gói đã được cài đặt hoàn tất!${NC}"
echo -e "😀 ${GREEN}Dùng lệnh bash ipchange.sh để bắt đầu dùng tool.${NC}"
