shinken-2.0
==================

## Hướng dẫn cài đặt công cụ Shinken 2.0 trên môi trường Ubuntu server 14.04 để giám sát hệ thống

Trong bài viết này sẽ chủ yếu sử dụng mô hình sau:

<img src=http://i.imgur.com/ET4Ze99.png>

Trong đó Shinken Server là máy chủ Ubuntu 14.04 cài Shinken.
Remote Server là các máy được giám sát: nó có thể là Linux, Windows, Switch,....

###1. Cài đặt

- Cài các thành phần chính của Shinken

```sh
wget https://raw.githubusercontent.com/ducnc/shinken-20-monitor/master/Scripts/shinken.sh
bash shinken.sh
```

- Cài thành phần Webui

```sh
wget https://github.com/ducnc/shinken-20-monitor/raw/master/Scripts/webui.sh
bash webui.sh
```

- Sau khi cài đặt xong truy cập vào địa chỉ IP của máy chủ Shinken cổng 7767 với username admin, password admin.

###2. Hướng dẫn sử dụng Shinken

####2.1. Giám sát một host Linux

Có 3 phương pháp để Shinken giám sát một host Linux là sử dụng linux-snmp, nrpe và linux-ssh

- [Sử dụng linux-snmp](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/linux-snmp.md)

- [Sử dụng nrpe](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/nrpe.md)

- Sử dụng linux-ssh (Bổ sung sau)

####2.2. Giám sát một host Windows

Bổ sung sau

####2.3. Giám sát một Switch Cisco

[Hướng dẫn](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/shinken-switch-snmp.txt)

###3. Cài đặt cảnh báo

####3.1. Sử dụng gmail

Đầu tiên bạn cần tạo một tài khoản Gmail. Sau đó tại máy chủ Shinken bạn cài thêm một SMTP client (Postfix hoặc SSMTP)

- [Cài đặt Postfix SMTP client trên Shinken Server để gửi mail](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/install-postfix.txt)

- [Hoặc cài đặt SSMTP trên Shinken Server](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/install%20ssmnp.txt)

Cuối cùng [cấu hình shinken để gửi mail] (https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/mail-config.txt)

***Lưu ý:*** 

- Nên sử dụng SSMTP cho nhẹ

- Bạn phải đảm bảo có thể gửi mail bằng lệnh sử dụng 1 trong 2 cách trên do tài khoản gmail của bạn có thể đang sử dụng cơ chế xác thực 2 bước hoặc đang bị google bắt nhập captcha mỗi khi gửi mail.
Có thể tham khảo tại [link 1](https://accounts.google.com/DisplayUnlockCaptcha) hoặc [link2] (https://support.google.com/accounts/answer/6010255)

####3.2. Sử dụng USB 3G gửi SMS

[Hướng dẫn cấu hình để gửi SMS cảnh báo bằng USB 3G](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/sms-alert.txt)


###4. Tích hợp Shinken với các công cụ khác để hiển thị dữ liệu

- [Tích hợp Shinken và Pnp4nagios](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/pnp4nagios.txt)

- Tích hợp Shinken và Grapite (bổ sung sau)