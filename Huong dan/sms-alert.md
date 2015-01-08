##Thực hiện trên Shinken host

Cài đặt và kiểm tra usb 3g để gửi SMS

[Hướng dẫn](https://github.com/ducnc/caidat-tools-sms-usb3g-ubuntu)

Cần đảm bảo USB 3g đã gửi SMS thành công bằng chương trình gsmsendsms qua cổng /dev/ttyUSB0

####cau hinh shinken

`vi /etc/shinken/hosts/test.cfg`

    define host{
    use                     generic-host
    host_name               test
    address                 10.145.34.131
    contacts                admin
    notification_interval          30
    notification_period            24x7
    notification_options           d,u,r
    notifications_enabled   1
    check_command       check_host_alive
    }


`vi /etc/shinken/contacts/admin.cfg`
    define contact{
    use             generic-contact
    contact_name    admin
    email           nguyencongduc3112@gmail.com
    password        admin
    host_notifications_enabled      1
    service_notifications_enabled   1
    can_submit_commands             1
    notificationways                email,sms
    is_admin        1
    }

`vi /etc/shinken/notificationways/sms.cfg`
    define notificationway{
    notificationway_name            sms
    service_notification_period     24x7
    host_notification_period        24x7
    service_notification_options    c,w,r
    host_notification_options       d,u,r,s
    service_notification_commands   send-sms-service-alert ; send service notifications via sms
    host_notification_commands      send-sms-host-alert    ; send host notifications via sms
    }

`vi /etc/shinken/commands/send-sms-host-alert.cfg`
    define command {
    command_name    send-sms-host-alert
    command_line    $PLUGINSDIR$/send-sms-host.sh $NOTIFICATIONTYPE$ $HOSTNAME$ $HOSTADDRESS$ $HOSTSTATE$ $DATE$ $TIME$ $CONTACTPAGER$
    }
	
`vi /var/lib/shinken/libexec/send-sms-host.sh`
    #!/bin/bash
    NOTIFICATIONTYPE=$1
    HOSTNAME=$2
    HOSTADDRESS=$3
    HOSTSTATE=$4
    DATE=$5
    TIME=$6
    NUMBER=$7
    textesms="Shinken Notification    Type:$NOTIFICATIONTYPE    Host: $HOSTNAME    Address: $HOSTADDRESS     State: $HOSTSTATE    Date/Time: $DATE $TIME"
    sleep $((RANDOM%30+1))
    python /var/lib/shinken/libexec/send-sms.py $NUMBER "$textesms"
    exit 0

`vi /var/lib/shinken/libexec/send-sms.py`

    '''
    Created on Mar 19, 2014
    @author: Python Viet Nam
    @Edited: congto
    '''
    import argparse
    import serial
    import time
    parser = argparse.ArgumentParser(description='Send SMS by python')
    parser.add_argument('info',nargs=2,help='Please use the following command: python python-sms.py phone_number "Message"')
    args = parser.parse_args()
    def Sending(message, sender):
        SerialPort = serial.Serial("/dev/ttyUSB0",19200)
        SerialPort.write('AT+CMGF=1\r')
        time.sleep(1)
        SerialPort.write('AT+CMGS="'+sender+'"\r\n')
        time.sleep(1)
        SerialPort.write(message+"\x1A")
        time.sleep(1)
        SerialPort.close()
    Sending(args.info[1],args.info[0])

`chmod +x /var/lib/shinken/libexec/send-sms-host.sh`
	
`adduser shinken  dialout`

`/etc/init.d/shinken restart`
