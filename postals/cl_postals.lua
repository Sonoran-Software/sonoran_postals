--[[
    Sonaran CAD Plugins

    Plugin Name: postals
    Creator: SonoranCAD
    Description: Fetches nearest postal from client
]]


CreateThread(function() Config.LoadPlugin("postals", function(pluginConfig)

local lastPostal = nil
local eventPostal = nil

if pluginConfig.enabled then

    -- Don't touch this!

    function getNearestPostal()
        if pluginConfig.mode and pluginConfig.mode == "event" then
            return eventPostal
        else
            if exports[pluginConfig.nearestPostalResourceName] ~= nil then
                local p = exports[pluginConfig.nearestPostalResourceName]:getPostal()
                return p
            else
                assert(false, "Required postal resource is not loaded. Cannot use postals plugin.")
            end
        end
    end
    if pluginConfig.mode and pluginConfig.nearestPostalEvent and pluginConfig.mode == "event" then
        AddEventHandler(pluginConfig.nearestPostalEvent, function(postal)
            eventPostal = postal
        end)
    end
    local function sendPostalData()
        local postal = getNearestPostal()
        if postal ~= nil and postal ~= lastPostal then
            TriggerServerEvent("cadClientPostal", postal)
            lastPostal = postal
        end
    end
    CreateThread(function()
        while not NetworkIsPlayerActive(PlayerId()) or pluginConfig.sendTimer == nil do
            Wait(10)
        end
        TriggerServerEvent("getShouldSendPostal")
        while true do
            if pluginConfig.shouldSendPostalData then
                sendPostalData()
            end
            Wait(pluginConfig.sendTimer)
        end
    end)

    RegisterNetEvent("getShouldSendPostalResponse")
    AddEventHandler("getShouldSendPostalResponse", function(toggle)
        print("got "..tostring(toggle))
        pluginConfig.shouldSendPostalData = toggle
    end)

end

end) end)