---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ll.
--- DateTime: 07/12/2021 21:28
---

fx_version 'cerulean'
game 'gta5'

author 'mfa concept'
description 'dev by mfa concept'
-- this_is_a_map 'yes'

ui_page {
    "notif/index.html"
}

files {
    "notif/index.html",
    "notif/style.css",
    "notif/index.js",

}





client_scripts {

    "client.lua",
}

exports {
	'registerNotifForPos',
    'enableNotif',
    'disableNotif',
    "mfanotif"
}