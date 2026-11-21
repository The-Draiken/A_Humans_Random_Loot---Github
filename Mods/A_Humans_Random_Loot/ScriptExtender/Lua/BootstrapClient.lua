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

bootstrapLog("BootstrapClient loaded")

local files = {
    "Client/ItemValueIndex_Client.lua",
    "Client/ItemValueRulesMenu.lua",
}

for _, file in ipairs(files) do
    local ok, err = pcall(function()
        Ext.Require(file)
    end)

    if ok then
        bootstrapLog(file .. " loaded")
    else
        bootstrapLog(file .. " failed: " .. tostring(err))
    end
end
