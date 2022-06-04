local helpsNotif = {};
local forceHideHelpNotif = false;
local notifIsHide = false;
local isSend = false



RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob",function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent("esx:setJob2")
AddEventHandler("esx:setJob2",function(job2)
    ESX.PlayerData.job2 = job2
end)

---@param msg string define message od notification
---@param type string define type of notification
---@param icon table define Key value = icon key color = color
---@param color string define color for progress bar
---@param time number define time for notification
function mfanotif(msg,type,icon,color,time)
    SendNUIMessage({
        type = "notify",
        info = {
            type = type,
            message = msg,
            icons = icon,
            color = color,
            time = time
        }
    })
end


RegisterNetEvent("mfa:showNotif")
AddEventHandler("mfa:showNotif", function(msg,type,icon,color,time)
    mfanotif(msg,type,icon,color,time)
end)

---@param msg string define message for notification
function mfaHelpNotif(msg)
    if not isSend then
        SendNUIMessage({
            type = "helpNotif",
            info = {
                message = msg
            }
        })
        isSend = true
    end
end

function enableNotif()
    forceHideHelpNotif = false;
end

function disableNotif()
    forceHideHelpNotif = true;
    hideNotif();
end

function hideNotif()
    if isSend then
        SendNUIMessage({
            type = "hideHelpNotif"
        })
        isSend = false
    end
    notifIsHide = true;
end



---@param message string define message for notif
---@param pos number define pos for notif
---@param radius number define min dist for notif
function registerNotifForPos(data)
    table.insert(helpsNotif,{
        message = data.message,
        pos = data.pos,
        radius = data.radius,
        job = data.job or nil,
        grade = data.grade or nil
    });
end

Citizen.CreateThread(function()
    local pos = nil;
    while true do
        pos = GetEntityCoords(PlayerPedId());
        notifFind = false;
        for k,notif in pairs(helpsNotif) do
            if (notif.job ~= nil) then
                if ESX.PlayerData and ESX.PlayerData.job.name == notif.job or ESX.PlayerData.job2.name == notif.job then
                    if (notif.grade ~= nil) then
                        if (notif.grade == ESX.PlayerData.job.grade_name or notif.grade == ESX.PlayerData.job2.grade_name) then
                            if #(notif.pos - pos) < notif.radius and not forceHideHelpNotif then
                                mfaHelpNotif(notif.message);
                                notifFind = true;
                                notifIsHide = false;
                            end
                        end
                    else
                        if #(notif.pos - pos) < notif.radius and not forceHideHelpNotif then
                            mfaHelpNotif(notif.message);
                            notifFind = true;
                            notifIsHide = false;
                        end
                    end
                end
            else
                if #(notif.pos - pos) < notif.radius and not forceHideHelpNotif then
                    mfaHelpNotif(notif.message);
                    notifFind = true;
                    notifIsHide = false;
                end
            end
        end
        if not notifFind then
            hideNotif();
        end
        Wait(333);
    end
end)

RegisterCommand("test", function(source,args,rawCommand)
    mfanotif("ceci est un test","warning")
    -- showHelpNotif("ceci est un test <span class ='key'>E</span>")
end)

