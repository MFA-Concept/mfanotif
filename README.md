**MFA NOTIF est un system de notif personalisable**

# NE PAS RENOMMER LA RESSOURCE

# mfanotif

il existe 4 type de notif

* error 
* warning 
* succes 
* custom 

pour utiliser les notif il vous suffit de faire 

`exports.mfanotif:mfanotif("votre message","type de notif")`

si vous souhaitez utiliser le type custom il vous suffit de faire

`exports.mfanotif:mfanotif("message","custom",{value = "icon font awesome",color = "icon color"},"color",time)`



### registerNotifForPos x helpnotification

pour utiliser la helpnotification il vous suffit de faire 

`exports.mfanotif:registerNotifForPos("message",pos,mindist)`

### Exemple 
```
local pos = {
    vector3(21.7, -1106.7, 29.8),
    vector3(18.8, -1109.7, 29.8)
}

Citizen.CreateThread(function()
    for k,v in pairs(pos)do
        exports.mfanotif:registerNotifForPos("Appuyer sur <span class='key'>E</span> accéder a l'armurerie",v,1)
    end
end)
```
![SUCCES](https://media.discordapp.net/attachments/916446968497188905/943236084396073011/notif_succes.png)

![warning](https://media.discordapp.net/attachments/916446968497188905/943237214219952158/notifwarning.png)

![error](https://media.discordapp.net/attachments/916446968497188905/943236084639350844/notiferror.png)

![help](https://media.discordapp.net/attachments/916446968497188905/943236100560941126/notifhelp.png)

