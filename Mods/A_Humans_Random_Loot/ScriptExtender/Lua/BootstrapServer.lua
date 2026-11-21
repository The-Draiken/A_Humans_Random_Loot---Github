local function bootstrapLog(message)
    local text = "[A Human's Random Loot] " .. tostring(message)
    if type(_P) == "function" then
        _P(text)
    elseif Ext ~= nil and Ext.Utils ~= nil and type(Ext.Utils.Print) == "function" then
        Ext.Utils.Print(text)
    elseif Ext ~= nil and type(Ext.Print) == "function" then
        Ext.Print(text)
    elseif type(print) == "function" then
        print(text)
    end
end

bootstrapLog("BootstrapServer loaded")

local ok, err = pcall(function()
    Ext.Require("Server/RandomLoot.lua")
end)

if ok then
    bootstrapLog("Server/RandomLoot.lua loaded")
else
    bootstrapLog("Server/RandomLoot.lua failed: " .. tostring(err))
end
