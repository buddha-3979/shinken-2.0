#!/bin/bash
# Install shinken web-ui

su - shinken << EOF

shinken install webui

shinken install auth-cfg-password

shinken install sqlitedb

sed -i 's\modules\modules    auth-cfg-password,sqlitedb\g' /etc/shinken/modules/webui.cfg

sed -i 's\modules\modules    webui\g' /etc/shinken/brokers/broker-master.cfg

sed -i 's\SQLitedb\sqlitedb\g' /etc/shinken/modules/sqlitedb.cfg

/etc/init.d/shinken restart

exit

EOF

echo "Cai dat hoan tat"
echo "Truy cap vao http://ipserver:7767 bang tai khoan admin password admin" 