##Tại Shinken host

```sh
sudo apt-get install ssmtp mailutils -y
```

Sửa file cấu hình

`vi /etc/ssmtp/ssmtp.conf`

    # The person who gets all mail for userids < 1000
    # Make this empty to disable rewriting.
    root=shinkenvdc@gmail.com

    # The place where the mail goes. The actual machine name is required no
    # MX records are consulted. Commonly mailhosts are named mail.domain.com
    #mailhub=mail
    mailhub=smtp.gmail.com:587
    AuthUser=shinkenvdc@gmail.com
    AuthPass=passworddaivakhonho
    UseTLS=YES
    UseSTARTTLS=YES

    # Where will the mail seem to come from?
    #rewriteDomain=
    rewriteDomain=gmail.com
    # The full hostname
    hostname=shinkenvdc@gmail.com

    # Are users allowed to set their own From: address?
    # YES - Allow the user to specify their own From: address
    # NO - Use the system generated From: address
    FromLineOverride=YES

`vi /etc/ssmtp/revaliases`

    root:shinkenvdc@gmail.com:smtp.gmail.com:587

Test xem đã có thể gửi mail được chưa sử dụng lệnh sau, kiểm tra hộp thư đến để biết kết quả.

`echo "Test email" | mail -s "Shinken" ducnc92@hotmail.com`
