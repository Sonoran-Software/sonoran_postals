--[[
    Sonaran CAD Plugins

    Plugin Name: postals
    Creator: SonoranCAD
    Description: Fetches nearest postal from client
]]

-- Toggles Postal Sender

local pluginConfig = Config.GetPluginConfig("postals")

if pluginConfig.enabled then

    PostalsCache = {}

    RegisterNetEvent("getShouldSendPostal")
    AddEventHandler("getShouldSendPostal", function()
        TriggerClientEvent("getShouldSendPostalResponse", source, prefixPostal)
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

end