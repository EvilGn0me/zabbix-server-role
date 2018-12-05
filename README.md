Zabbix-server
=========

This role installs zabbix-server

Dependencies
----------------

This role depends on nginx,php-fpm,mariadb and zabbix-agent roles:

~~~
---
- hosts: zabbix_servers
  user: root
  roles:
    - nginx-role
    - php-fpm-role
    - mariadb-role
    - zabbix-agent-role
    - zabbix-server-role
    - ssmtp-role
~~~

Slack notify
----------------

We are using custom script for slack notification that requires custom alert message.
Your alert message should be like this if you want slack notify to work:

~~~
Default subject  [{TRIGGER.STATUS}] {TRIGGER.NAME}
Default message  HOST: {HOST.NAME}
                 TRIGGER_NAME: {TRIGGER.NAME}
                 TRIGGER_STATUS: {TRIGGER.STATUS}
                 TRIGGER_SEVERITY: {TRIGGER.SEVERITY}
                 DATETIME: {DATE} / {TIME}
                 ITEM_ID: {ITEM.ID1}
                 ITEM_NAME: {ITEM.NAME1}
                 ITEM_KEY: {ITEM.KEY1}
                 ITEM_VALUE: {ITEM.VALUE1}
                 EVENT_ID: {EVENT.ID}
                 TRIGGER_URL: {TRIGGER.URL}
                 TRIGGER_DESCRIPTION: {TRIGGER.DESCRIPTION}
~~~
