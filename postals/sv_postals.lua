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

    if pluginConfig.getPostalMethod == "custom" then
        getPostalCustom()
    end

elseif locationsConfig == nil then
    errorLog("ERROR: Postals plugin is loaded, but required locations plugin is not. This plugin will not function correctly!")
end