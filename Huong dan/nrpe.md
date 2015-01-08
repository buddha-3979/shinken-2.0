##Tại Linux host được monitor

```sh
wget http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz
tar -xvf nrpe-2.15.tar.gz
cd nrpe-2.15/
useradd nagios
apt-get install libssl-dev xinetd nagios-plugins -y
./configure --with-ssl=/usr/lib/x86_64-linux-gnu
make all
make install-plugin
make install-daemon
make install-daemon-config
make install-xinetd
/etc/init.d/xinetd restart
```

Đẩy file check_nrpe sang hosst Monitor nếu cần

`scp /usr/local/nagios/libexec/check_nrpe root@10.145.34.130:/root/`

`vi /etc/xinetd.d/nrpe`

    only_from       = 10.145.34.130
    #Sửa lại IP 10.145.34.130 thành IP của shinken server

`vi /usr/local/nagios/etc/nrpe.cfg`

    command[check_users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10
    command[check_load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
    command[check_hda1]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /dev/hda1
    command[check_zombie_procs]=/usr/lib/nagios/plugins/check_procs -w 5 -c 10 -s Z
    command[check_total_procs]=/usr/lib/nagios/plugins/check_procs -w 150 -c 200

Kiêm tra kết nối `/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20`

Restart dịch vụ
```
/etc/init.d/xinetd restart

update-rc.d xinetd defaults
```

##Tại host monitor cài Shinken


#### Kiểm tra kết nối nrpe đến remote host

```sh
apt-get install nagios-plugins
mv /root/check_nrpe /usr/lib/nagios/plugins/
chmod +x /usr/lib/nagios/plugins/check_nrpe
/usr/lib/nagios/plugins/check_nrpe -H 10.145.34.131 -c check_users
```

Set uid cho commnad check_icmp nếu trên dashboard của Shinken hiện lỗi: "Warning: This plugin must be either run as root or setuid root." thì:

`chmod u+s /usr/lib/nagios/plugins/check_icmp`

Cài module booster-nrpe

```
su - shinken
shinken install booster-nrpe
```

`vi /etc/shinken/modules/booster_nrpe.cfg`

    define module {
    module_name     booster-nrpe
    module_type     nrpe_poller
    }

`vi /etc/shinken/pollers/poller-master.cfg`

    modules     booster-nrpe

Định nghĩa host "test" cần monitor

`vi /etc/shinken/hosts/test.cfg`

    define host{
    use                     generic-host
    host_name               test
    address                 10.145.34.131
    contacts                admin
    notification_interval          30
    notification_period            24x7
    notification_options           d,u,r
    notifications_enabled           1
    check_command       check_host_alive
    }

Định nghĩa các service cần test với host "test"

`vi /etc/shinken/services/test.cfg`

    define service{
    use             generic-service
    host_name       test    ;phải giống hostname đã định nghĩa bên trên
    service_description     Current Users
    check_command   check_nrpe!check_users
    }

`vi /etc/shinken/commands/check_nrpe.cfg`

    define command {
    command_name    check_nrpe
    command_line    $NAGIOSPLUGINSDIR$/check_nrpe -H $HOSTADDRESS$ -t 9 -u -c $ARG1$
    }
	
`vi /etc/shinken/commands/check_nrpe_args.cfg`

    define command {
    command_name    check_nrpe_args
    command_line    $NAGIOSPLUGINSDIR$/check_nrpe -H $HOSTADDRESS$ -t 9 -u -c $ARG1$ -a $ARG2$ $ARG3$ $ARG4$ $ARG5$
    }

Restart shinken

`service shinken restart`
