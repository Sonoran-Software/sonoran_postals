--[[
    Sonaran CAD Plugins

    Plugin Name: postals
    Creator: SonoranCAD
    Description: Fetches nearest postal from client
]]

-- Toggles Postal Sender

local pluginConfig = Config.GetPluginConfig("postals")
local locationsConfig = Config.GetPluginConfig("locations")

if pluginConfig.enabled and locationsConfig ~= nil then

    local state = GetResourceState(pluginConfig.nearestPostalResourceName)
    if  state ~= "started" then
        pluginConfig.enabled = false
        if state == "missing" then
            errorLog(("[postals] The configured postals resource (%s) does not exist. Please check the name."):format(pluginConfig.nearestPostalResourceName))
        else
            errorLog(("[postals] ERROR: The postals resource (%s) is not started. Please ensure it's started. State: %s"):format(pluginConfig.nearestPostalResourceName, state))
        end
        errorLog("Force disabling plugin to prevent client errors.")
        return
    end

    PostalsCache = {}

    RegisterNetEvent("getShouldSendPostal")
    AddEventHandler("getShouldSendPostal", function()
        TriggerClientEvent("getShouldSendPostalResponse", source, locationsConfig.prefixPostal)
    end)

    RegisterNetEvent("cadClientPostal")
    AddEventHandler("cadClientPostal", function(postal)
        PostalsCache[source] = postal
    end)

    AddEventHandler("playerDropped", function(player)
        PostalsCache[player] = nil
    end)

    function getNearestPostal(player)
        return PostalsCache[player]
    end

    exports('cadGetNearestPostal', getNearestPostal)

elseif locationsConfig == nil then
    errorLog("ERROR: Postals plugin is loaded, but required locations plugin is not. This plugin will not function correctly!")
end