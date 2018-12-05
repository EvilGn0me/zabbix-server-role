#!/bin/bash

zabbix_baseurl="{{ zabbix_server_vars.nginx.hostname }}"

channel="$1"
icon="https://secure.gravatar.com/avatar/a6a67349e64aa05088207ab1e2ce3f85.jpg"
username="ZABBIX"
title="$2"
params="$3"
pretext="$4"

host="`echo \"${params}\" | grep 'HOST: ' | awk -F'HOST: ' '{print $2}' | tr -d '\r\n\'`"
trigger_name="`echo \"${params}\" | grep 'TRIGGER_NAME: ' | awk -F'TRIGGER_NAME: ' '{print $2}' | tr -d '\r\n\'`"
trigger_status="`echo \"${params}\" | grep 'TRIGGER_STATUS: ' | awk -F'TRIGGER_STATUS: ' '{print $2}' | tr -d '\r\n\'`"
severity="`echo \"${params}\" | grep 'TRIGGER_SEVERITY: ' | awk -F'TRIGGER_SEVERITY: ' '{print $2}' | tr -d '\r\n\'`"
trigger_url="`echo \"${params}\" | grep 'TRIGGER_URL: ' | awk -F'TRIGGER_URL: ' '{print $2}' | tr -d '\r\n\'`"
datetime="`echo \"${params}\" | grep 'DATETIME: ' | awk -F'DATETIME: ' '{print $2}' | tr -d '\r\n\'`"
item_value="`echo \"${params}\" | grep 'ITEM_VALUE: ' | awk -F'ITEM_VALUE: ' '{print $2}' | tr -d '\r\n\'`"
event_id="`echo \"${params}\" | grep 'EVENT_ID: ' | awk -F'EVENT_ID: ' '{print $2}' | tr -d '\r\n\'`"
item_id="`echo \"${params}\" | grep 'ITEM_ID: ' | awk -F'ITEM_ID: ' '{print $2}' | tr -d '\r\n\'`"
msg="`echo \"${params}\" | grep 'TRIGGER_DESCRIPTION: ' | awk -F'TRIGGER_DESCRIPTION: ' '{print $2}' | tr -d '\r\n\'`"

item_value='`'$item_value'`'
trigger_chart="${zabbix_baseurl}/history.php?action=showgraph&itemids=${item_id}"

if [[ "$severity" == 'Information' ]]; then
	color='#7499FF'
elif [ "$severity" == 'Warning' ]; then
	color='#FFC859'
elif [ "$severity" == 'Average' ]; then
        color='#FFA059'
elif [ "$severity" == 'High' ]; then
        color='#E97659'
elif [ "$severity" == 'Disaster' ]; then
        color='#E45959'
else
	color='#97AAB3'
fi

if [[ "$trigger_status" == 'OK' ]]; then
        color='good'
fi

ts=$(date +%s)

request_body=$(< <(cat <<EOF
{
	"channel": "#$channel",
	"username": "$username",
	"icon_emoji": "$icon",
	"mrkdwn": true,
	"attachments": [
		{
			"fallback": "$title",
			"color": "$color",
			"pretext": "$pretext",
			"author_name": "$host",
			"author_link": "$trigger_chart",
			"author_icon": "https://cdn0.iconfinder.com/data/icons/free-misc-icon-set-2/512/graph_up_arrow-16.png",
			"title": "$title",
			"title_link": "$trigger_url",
			"text": "$msg",
			"fields": [
				{
					"title": "Severity",
					"value": "$severity",
					"short": true
				},
				{
					"title": "Value",
					"value": "$item_value",
					"short": true
				}
			],
			/*"image_url": "http://www.zabbix.com/favicon.ico1",*/
			/*"thumb_url": "http://www.zabbix.com/favicon.ico1",*/
			"footer": "{{ zabbix_server_vars.nginx.hostname }}",
			"footer_icon": "http://www.zabbix.com/favicon.ico",
			"ts": "$ts",
			"mrkdwn_in": [
				"test",
				"pretext",
				"fields"
			]
		}
	]
}
EOF
))

curl -X POST \
-H 'Content-type: application/json' \
--data "$request_body"  \
{{ zabbix_server_vars.slack.webhook }}
