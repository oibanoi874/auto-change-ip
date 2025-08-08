# IP Auto Changer with Tor & Privoxy

**ipchange.sh** là script Bash giúp tự động đổi địa chỉ IP định kỳ bằng **Tor** và **Privoxy**.  
Công cụ này hữu ích khi cần bảo mật, ẩn danh hoặc vượt giới hạn kết nối.

---

## 📌 Tính năng
- Tự động khởi tạo **nhiều Tor nodes** và chạy qua **Privoxy**.
- Đổi IP mới định kỳ, kèm thông tin:
  - ⏰ Thời gian đổi IP
  - 🌐 Địa chỉ IP mới
  - 🏳 Quốc gia
  - 🏙 Thành phố
  - 🔌 Proxy
  - 🔄 Số lần đổi IP
- Đếm ngược thời gian Delay trước khi đổi IP tiếp theo.
- Tự bỏ qua nếu không lấy được IP.

---

## 🛠 Lệnh để cài

- termux-setup-storage
- pkg update -y && pkg upgrade -y
- apt update -y && apt upgrade -y
- pkg install git -y
- git clone https://github.com/oibanoi874/auto-change-ip.git
- cd auto-change-ip
- bash install.sh
- bash ipchange.sh

---

## ⚒ Lệnh dùng cho lần sau
- cd auto-change-ip
- bash ipchange.sh

---

## ⚙ Cấu hình mặc định

- 5 Tor nodes chạy song song.
 - Proxy: 127.0.0.1:8118
 - Delay đổi IP: 30 giây
 - API IP info: https://ipinfo.io/json

 ---

 ## ⚠ Lưu ý
- Tor cần vài giây để cấp IP mới → nếu lỗi, script sẽ tự thử lại.
- Một số dịch vụ web vẫn có thể phát hiện Tor.
