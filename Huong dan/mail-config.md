##Tại host shinken

Sửa file cấu hình host cần gửi email cảnh báo

`vi /etc/shinken/hosts/srv-webserver.cfg`
    define host{
    use                     linux-ssh
    host_name               webserver-local
    address                 10.145.34.131
    contacts                admin           ;người dùng được gửi mail đến, có thể thay bằng nhóm người dùng
    notification_interval          30
    notification_period            24x7
    notification_options           d,u,r
    notifications_enabled          1        ;cho phép cảnh báo
    }

Định nghĩa email của người dùng được khai báo ở bước trên
    
`vi /etc/shinken/contacts/admin.cfg`
    define contact{
    use             generic-contact
    contact_name    admin
    email           nguyencongduc3112@gmail.com         ;email này sẽ được gửi tin nhắn đến
    host_notifications_enabled      1
    service_notifications_enabled   1
    can_submit_commands             1
    notificationways                email               ;phương thức để gửi cảnh báo
    is_admin        1
    }

Định nghĩa một phương thức "email" để cảnh báo
    
`vi /etc/shinken/notificationways/email.cfg`

    define notificationway{
    notificationway_name            email
    service_notification_period     24x7
    host_notification_period        24x7
    service_notification_options    c,w,r
    host_notification_options       d,u,r,f,s
    host_notification_commands      notify-host-by-email        ;phương thức này sử dụng command notify-host-by-email
    }

Định nghĩa command gửi mail
    
`vi /etc/shinken/commands/notify-host-by-email.cfg`

    define command {
    command_name    notify-host-by-email
    command_line    /usr/bin/printf "%b" "Shinken Notification\n\nType:$NOTIFICATIONTYPE$\nHost: $HOSTNAME$\nState: $HOSTSTATE$\nAddress: $HOSTADDRESS$\nInfo: $HOSTOUTPUT$\nDate/Time: $DATE$ $TIME$\n" | /usr/bin/mail -s "Host $HOSTSTATE$ alert for $HOSTNAME$" $CONTACTEMAIL$
    }

Restart shinken:

`service shinken restart`