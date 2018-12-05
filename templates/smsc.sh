#!/bin/bash
to=$1
subject=$2

curl  -k "https://smsc.ru/sys/send.php?login={{ zabbix_server_vars.smsc.user}}&psw={{ zabbix_server_vars.smsc.pass}}&phones=$to&mes=$subject"
