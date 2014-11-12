shinken-20-monitor
==================

## Hướng dẫn cài đặt công cụ Shinken 2.0 trên môi trường Ubuntu server 14.04 để giám sát hệ thống

Trong bài viết này sẽ chủ yếu sử dụng mô hình sau:

<img src=http://i.imgur.com/ET4Ze99.png>

Trong đó Shinken Server là máy chủ Ubuntu 14.04 cài Shinken.
Remote Server là các máy được giám sát: Linux, Windows, Switch,....

### [Hướng dẫn cài đặt Shinken 2.0](https://github.com/ngothanhlong/SHINKEN)

### Hướng dẫn sử dụng Shinken để giám sát host Linux

##### [Sử dụng linux-snmp](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/linux-snmp.txt)

##### [Sử dụng nrpe](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/nrpe.txt)

##### [Sử dụng linux-ssh]()

### [Hướng dẫn sử dụng Shinken để giám sát một host Windows]()

### [Hướng dẫn sử dụng SNMP để giám sát một Switch Cisco](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/shinken-switch-snmp.txt)

### Hướng dẫn cấu hình để gửi mail cảnh báo

##### [Cài đặt Postfix SMTP client trên Shinken Server để gửi mail](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/install-postfix.txt)

##### [Hoặc cài đặt SSMTP trên Shinken Server](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/install%20ssmnp.txt)

##### [Cấu hình gửi mail cảnh báo] (https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/mail-config.txt)

### [Hướng dẫn cấu hình để gửi SMS cảnh báo bằng USB 3G](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/sms-alert.txt)

### Tích hợp Shinken với các công cụ khác để hiển thị dữ liệu

##### [Hướng dẫn tích hợp Shinken và Pnp4nagios](https://github.com/ducnc/shinken-20-monitor/blob/master/Huong%20dan/pnp4nagios.txt)

##### [Hướng dẫn tích hợp Shinken và Grapite]()