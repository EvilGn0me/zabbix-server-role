# -*- coding: utf-8 -*-

tg_key = "{{ zabbix_server_vars.telegram.apikey }}"  # telegram bot api key

zbx_tg_prefix = "zbxtg"  # variable for separating text from script info
zbx_tg_tmp_dir = "/var/tmp/" + zbx_tg_prefix  # directory for saving caches, uids, cookies, etc.
zbx_tg_signature = False

zbx_tg_update_messages = True
zbx_tg_matches = {
    "problem": "PROBLEM: ",
    "ok": "OK: "
}

zbx_server = "{{ zabbix_url }}"  # zabbix server full url
zbx_api_user = "{{ zabbix_user }}"
zbx_api_pass = "{{ zabbix_pass }}"
zbx_api_verify = True  # True - do not ignore self signed certificates, False - ignore

zbx_basic_auth = False
zbx_basic_auth_user = "zabbix"
zbx_basic_auth_pass = "zabbix"

proxy_to_zbx = None
proxy_to_tg = None

#proxy_to_zbx = "proxy.local:3128"
#proxy_to_tg = "proxy.local:3128"

google_maps_api_key = None  # get your key, see https://developers.google.com/maps/documentation/geocoding/intro

zbx_tg_daemon_enabled = False
zbx_tg_daemon_wl_ids = [6931850, ]
zbx_tg_daemon_wl_u = ["ableev", ]

zbx_db_host = "localhost"
zbx_db_database = "{{ zabbix_server_vars.mysql.database }}"
zbx_db_user = "{{ zabbix_server_vars.mysql.user}}"
zbx_db_password = "{{ zabbix_server_vars.mysql.password }}"


emoji_map = {
    "OK": "✅",
    "PROBLEM": "❗",
    "info": "ℹ️",
    "WARNING": "⚠️",
    "DISASTER": "❌",
    "bomb": "💣",
    "fire": "🔥",
    "hankey": "💩",
}
