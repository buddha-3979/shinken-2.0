##Tại host monitor cài Shinken

```
su - shinken
shinken install linux-snmp
```

`vi /etc/shinken/hosts/target.cfg`

Thêm vào nội dung như sau:

```sh
define host{
        use                     linux-snmp
        contactgroups           admins
        host_name               target
        address                 10.145.34.131   ;IP cua may chu duoc monitor
        _SNMPCOMMUNITY          ducnc
        }
```

Restart dịch vụ:

`/etc/init.d/shinken restart`

##Tại Linux host được monitor

`apt-get install snmpd -y`

`vi /etc/snmp/snmpd.conf`

Sửa nội dung như sau:

```sh
agentAddress udp:161,udp6:[::1]:161
rocommunity ducnc 10.145.34.0/24
```
	
`/etc/init.d/snmpd restart`

##Kiểm tra kết nối tại host Shinken

`snmpwalk -v 2c -c public 10.145.37.230 10.145.34.131`

Nếu kết quả trả về là một loạt dãy số thì SNMP đã cài thành công.