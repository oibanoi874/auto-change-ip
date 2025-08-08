#!/bin/bash

# Cài đặt các gói cơ bản: curl, wget, unzip
echo "😀\e[1;32mBắt đầu cài đặt các gói cơ bản: curl, wget, unzip...\e[0m"
pkg install curl wget unzip -y
if [ $? -eq 0 ]; then
    echo "😀\e[1;32mCài đặt curl, wget, unzip thành công!\e[0m"
else
    echo "😭\e[31mLỗi: Không thể cài đặt các gói cơ bản. Vui lòng kiểm tra lại kết nối mạng.\e[0m"
    exit 1
fi

# Thêm kho lưu trữ Tur-Repo
echo "😀\e[1;32mĐang thêm kho lưu trữ Tur-Repo...\e[0m"
pkg install tur-repo -y
if [ $? -eq 0 ]; then
    echo "😀\e[1;32mThêm Tur-Repo thành công!\e[0m"
else
    echo "😭\e[31mLỗi: Không thể thêm Tur-Repo. Vui lòng kiểm tra lại.\e[0m"
    exit 1
fi

# Cài đặt các gói bảo mật: tor, privoxy, netcat-openbsd
echo "😀\e[1;32mĐang cài đặt Tor, Privoxy và Netcat...\e[0m"
pkg install tor privoxy netcat-openbsd -y
if [ $? -eq 0 ]; then
    echo "😀\e[1;32mCài đặt Tor, Privoxy, Netcat thành công!\e[0m"
else
    echo "😭\e[31mLỗi: Không thể cài đặt Tor, Privoxy, Netcat. Vui lòng kiểm tra lại.\e[0m"
    exit 1
fi

echo "😀\e[1;32m---\e[0m"
echo "😀\e[1;32mTất cả các gói đã được cài đặt hoàn tất!\e[0m"
echo "😀\e[1;32mBạn có thể sử dụng các tool đã cài đặt.\e[0m"
echo "😀\e[1;32mDùng lệnh bash ipchange.sh để bắt đầu dùng tool.\e[0m"