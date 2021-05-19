--[[
    Sonoran Plugins

    Plugin Configuration

    Put all needed configuration in this file.
]]
local config = {
    enabled = false,
    pluginName = "postals", -- name your plugin here
    pluginAuthor = "SonoranCAD", -- author
    configVersion = "1.2.0",
    -- put your configuration options below
    sendTimer = 950, -- how often to send postal to client
    shouldSendPostalData = true, -- toggles this plugin on/off
    
    nearestPostalResourceName = "nearest-postal" -- if using nearestpostal, specify the name of the resource here if you changed it
}


if config.enabled then
    Config.RegisterPluginConfig(config.pluginName, config)
end