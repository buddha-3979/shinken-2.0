#!/bin/bash
# Install shinken 2.0

Password='123456a@'

useradd -m shinken
echo shinken:$Password | chpasswd

apt-get update -y

apt-get install -y python-pycurl python-setuptools python-pip python-paramiko expect

pip install shinken

/etc/init.d/shinken start

ps -fu shinken

curl http://localhost:7770/

su - shinken << EOF

shinken --init

shinken install linux-ssh

ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -P ''

/usr/bin/expect - << EOF1
spawn ssh-copy-id -i /home/shinken/.ssh/id_rsa shinken@localhost
expect "connecting (yes/no)?"
send "yes\r"
expect "localhost's password:"
send "$Password\r"
expect eof
EOF1

cat << EOF2 > /etc/shinken/hosts/localhost.cfg
define host{
    use                     linux-ssh,generic-host
    contact_groups          admins
    host_name               localhost
    address                 localhost
    }
EOF2

exit
EOF

/etc/init.d/shinken restart

