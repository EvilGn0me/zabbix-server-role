#!/bin/bash

cat <<EOF | /usr/sbin/ssmtp $1
To: $1
From: Zabbix Faunus <zabbix@faunus.io>
Subject: $2

$3
EOF

