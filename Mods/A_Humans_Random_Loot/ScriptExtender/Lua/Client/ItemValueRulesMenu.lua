local MOD_UUID = "0c84af14-9732-c150-2347-9396ff617ccd"
local ITEM_VALUE_RULES_CHANNEL = MOD_UUID .. "_ItemValueRules"
local ITEM_VALUE_RULES_SETTING = "item_value_overrides"
local EXCLUDED_ITEMS_SETTING = "excluded_items"
local MAX_RESULTS = 250

Mods.AHRL = Mods.AHRL or {}

local function trimText(value)
    return tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function normalizeSearchText(value)
    return string.lower(tostring(value or "")):gsub("%s+", "")
end

local function fuzzySearch(haystack, search)
    local normalizedHaystack = normalizeSearchText(haystack)
    for word in tostring(search or ""):gmatch("%S+") do
        if string.find(normalizedHaystack, normalizeSearchText(word), 1, true) == nil then
            return false
        end
    end
    return true
end

local function normalizeRuleKey(value)
    local text = trimText(value)
    if text == "" then
        return nil
    end
    return string.lower(text)
end

local function parseRules(text)
    local rules = {}
    for rawLine in tostring(text or ""):gmatch("[^\r\n;]+") do
        local line = trimText(rawLine)
        if line ~= "" and line:sub(1, 1) ~= "#" then
            local key, rawValue = line:match("^([^=:]+)%s*[=:]%s*(.-)%s*$")
            if key == nil then
                key, rawValue = line:match("^(%S+)%s+(%S+)%s*$")
            end

            key = normalizeRuleKey(key)
            rawValue = trimText(rawValue)
            if key ~= nil and rawValue ~= "" then
                local lowerValue = string.lower(rawValue)
                if lowerValue == "lock" or lowerValue == "keep" or lowerValue == "original" or lowerValue == "current" then
                    rules[key] = "lock"
                else
                    local number = tonumber(rawValue)
                    if number ~= nil then
                        rules[key] = math.max(0, math.floor(number))
                    end
                end
            end
        end
    end
    return rules
end

local function serializeRules(rules)
    local lines = {}
    for key, value in pairs(rules or {}) do
        if type(value) == "number" then
            lines[#lines + 1] = tostring(key) .. "=" .. tostring(math.max(0, math.floor(value)))
        elseif value == "lock" then
            lines[#lines + 1] = tostring(key) .. "=lock"
        end
    end

    table.sort(lines)
    return table.concat(lines, "\n")
end

local function parseExclusions(text)
    local entries = {}
    for rawLine in tostring(text or ""):gmatch("[^\r\n;]+") do
        local line = trimText(rawLine)
        if line ~= "" and line:sub(1, 1) ~= "#" then
            local key, rawValue = line:match("^([^=:]+)%s*[=:]%s*(.-)%s*$")
            if key == nil then
                key, rawValue = line:match("^(%S+)%s+(%S+)%s*$")
            end

            if key ~= nil then
                local normalKey = normalizeRuleKey(key)
                local mode = string.lower(trimText(rawValue or "both"))
                if mode == "1" or mode == "true" then
                    mode = "both"
                end
                if normalKey ~= nil and (mode == "vendor" or mode == "enemy" or mode == "both") then
                    entries[normalKey] = mode
                end
            end
        end
    end
    return entries
end

local function serializeExclusions(entries)
    local lines = {}
    for key, mode in pairs(entries or {}) do
        if mode ~= nil and mode ~= "" then
            lines[#lines + 1] = tostring(key) .. "=" .. tostring(mode)
        end
    end

    table.sort(lines)
    return table.concat(lines, "\n")
end

local function getMcmExclusionText()
    if MCM ~= nil and type(MCM.Get) == "function" then
        local ok, value = pcall(function()
            return MCM.Get(EXCLUDED_ITEMS_SETTING, MOD_UUID)
        end)
        if ok and value ~= nil then
            return tostring(value)
        end

        ok, value = pcall(function()
            return MCM.Get(EXCLUDED_ITEMS_SETTING)
        end)
        if ok and value ~= nil then
            return tostring(value)
        end
    end
    return ""
end

local function setMcmExclusionText(text)
    text = tostring(text or "")

    if MCM ~= nil and type(MCM.Set) == "function" then
        pcall(function()
            MCM.Set(EXCLUDED_ITEMS_SETTING, text, MOD_UUID)
        end)
    end

    if Ext ~= nil and Ext.Net ~= nil and type(Ext.Net.PostMessageToServer) == "function" then
        Ext.Net.PostMessageToServer(MOD_UUID .. "_ExcludedItems", text)
    end
end

local function getEntryExclusion(exclusions, entry)
    local key = normalizeRuleKey(entry and entry.StatName)
    if key == nil then
        return nil, nil
    end
    local mode = exclusions[key]
    if mode == nil then
        return false, false
    end
    return mode == "vendor" or mode == "both", mode == "enemy" or mode == "both"
end

local function setEntryExclusion(exclusions, entry, vendor, enemy)
    local key = normalizeRuleKey(entry and entry.StatName)
    if key == nil then
        return
    end

    if vendor and enemy then
        exclusions[key] = "both"
    elseif vendor then
        exclusions[key] = "vendor"
    elseif enemy then
        exclusions[key] = "enemy"
    else
        exclusions[key] = nil
    end

    setMcmExclusionText(serializeExclusions(exclusions))
end

local function getMcmRuleText()
    if MCM ~= nil and type(MCM.Get) == "function" then
        local ok, value = pcall(function()
            return MCM.Get(ITEM_VALUE_RULES_SETTING, MOD_UUID)
        end)
        if ok and value ~= nil then
            return tostring(value)
        end

        ok, value = pcall(function()
            return MCM.Get(ITEM_VALUE_RULES_SETTING)
        end)
        if ok and value ~= nil then
            return tostring(value)
        end
    end
    return ""
end

local function setMcmRuleText(text)
    text = tostring(text or "")

    if Mods ~= nil and Mods.AHRL ~= nil and type(Mods.AHRL.SetLocalItemValueOverrideText) == "function" then
        Mods.AHRL.SetLocalItemValueOverrideText(text)
    end

    if MCM ~= nil and type(MCM.Set) == "function" then
        pcall(function()
            MCM.Set(ITEM_VALUE_RULES_SETTING, text, MOD_UUID)
        end)
    end

    if Ext ~= nil and Ext.Net ~= nil and type(Ext.Net.PostMessageToServer) == "function" then
        Ext.Net.PostMessageToServer(ITEM_VALUE_RULES_CHANNEL, text)
    end
end

local function getEntryRuleKey(entry)
    return normalizeRuleKey(entry and entry.StatName)
end

local function getEntryRule(rules, entry)
    local key = getEntryRuleKey(entry)
    if key == nil then
        return nil
    end
    return rules[key]
end

local function setEntryRule(rules, entry, value)
    local key = getEntryRuleKey(entry)
    if key == nil then
        return
    end

    if value == nil then
        rules[key] = nil
    else
        rules[key] = value
    end

    setMcmRuleText(serializeRules(rules))
end

local function valueLabel(entry)
    if entry == nil then
        return ""
    end

    local known = entry.ValueKnown == true
    local value = tonumber(entry.Value or entry.BaseValue) or 0
    local base = tonumber(entry.BaseValue) or value
    local rarity = tostring(entry.Rarity or "Common")
    if known then
        if value ~= base then
            return string.format("%s, %d effective, %d base", rarity, value, base)
        end
        return string.format("%s, %d", rarity, value)
    end
    return rarity .. ", unknown"
end

local function getControlInt(control, fallback)
    if control == nil then
        return fallback
    end

    if type(control.Value) == "table" then
        return tonumber(control.Value[1]) or fallback
    end

    if control.Value ~= nil then
        return tonumber(control.Value) or fallback
    end

    if control.Text ~= nil then
        return tonumber(control.Text) or fallback
    end

    return fallback
end

local function setControlInt(control, value)
    if control == nil then
        return
    end

    if type(control.Value) == "table" then
        control.Value = { value, control.Value[2], control.Value[3], control.Value[4] }
    elseif control.Value ~= nil then
        control.Value = value
    elseif control.Text ~= nil then
        control.Text = tostring(value)
    end
end

local function addValueInput(parent, value)
    if type(parent.AddDragInt) == "function" then
        local input = parent:AddDragInt("", value, 0, 1000000)
        input.AlwaysClamp = true
        return input
    end

    local input = parent:AddInputText("")
    input.Text = tostring(value)
    return input
end

local function getModName(modId)
    if modId == nil or modId == "" then
        return "Base Game"
    end

    if Ext ~= nil and Ext.Mod ~= nil and type(Ext.Mod.GetMod) == "function" then
        local ok, modInfo = pcall(Ext.Mod.GetMod, modId)
        if ok and modInfo ~= nil and modInfo.Info ~= nil and modInfo.Info.Name ~= nil then
            return tostring(modInfo.Info.Name)
        end
    end

    return "Unknown Mod"
end

local function isSafeIcon(icon)
    return type(icon) == "string" and icon ~= "" and icon ~= "Item_Unknown" and not string.match(icon, "^%d+_Head_")
end

local function destroyChild(child)
    if child == nil then
        return false
    end

    if type(child.Destroy) == "function" then
        local ok = pcall(function() child:Destroy() end)
        if ok then return true end
    end
    return false
end

local function entryMatchesSearch(entry, search)
    local text = trimText(search)
    if text == "" then
        return true
    end

    local haystack = table.concat({
        tostring(entry.DisplayName or ""),
        tostring(entry.StatName or ""),
        tostring(entry.Template or ""),
        tostring(entry.Rarity or ""),
        tostring(entry.ModName or getModName(entry.ModId)),
    }, " ")
    return fuzzySearch(haystack, text)
end

local menuRegistered = false

local function registerItemValueRulesMenu()
    if menuRegistered then
        return
    end

    if Mods == nil or Mods.BG3MCM == nil or Mods.BG3MCM.IMGUIAPI == nil then
        if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
            Ext.Timer.WaitFor(1000, registerItemValueRulesMenu)
        end
        return
    end

    menuRegistered = true
    Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(MOD_UUID, "Item Value Rules", function(tabHeader)
        Mods.AHRL.RequestItemValueIndex()

        local rules = parseRules(getMcmRuleText())
        local exclusions = parseExclusions(getMcmExclusionText())
        local searchInput = tabHeader:AddInputText("")
        searchInput.Hint = "Search item name or StatName"
        searchInput.AutoSelectAll = true
        searchInput.EscapeClearsAll = true

        local modCombo = tabHeader:AddCombo("")
        modCombo.WidthFitPreview = true

        local refreshButton = tabHeader:AddButton("Refresh Item List")

        local resultsTable = tabHeader:AddTable("AHRL_ItemValueRules", 6)
        resultsTable.Hideable = true
        resultsTable.Visible = false
        resultsTable.ScrollY = true
        resultsTable.RowBg = true
        resultsTable:AddColumn("Item", "WidthStretch")
        resultsTable:AddColumn("Value")
        resultsTable:AddColumn("Keep")
        resultsTable:AddColumn("Custom")
        resultsTable:AddColumn("No Vendor")
        resultsTable:AddColumn("No Enemy")

        local header = resultsTable:AddRow()
        header.Headers = true
        header:AddCell():AddText("Item")
        header:AddCell():AddText("Value")
        header:AddCell():AddText("Keep")
        header:AddCell():AddText("Custom")
        header:AddCell():AddText("No Vendor")
        header:AddCell():AddText("No Enemy")

        local function clearResults()
            if resultsTable.Children == nil then
                return
            end

            for i = #resultsTable.Children, 2, -1 do
                local child = resultsTable.Children[i]
                local removed = false
                if type(resultsTable.RemoveChild) == "function" then
                    removed = pcall(function()
                        resultsTable:RemoveChild(child)
                    end)
                end
                if not removed then
                    destroyChild(child)
                end
            end
        end

        local function getIndex()
            if Mods.AHRL.ItemValueIndex == nil or #Mods.AHRL.ItemValueIndex == 0 then
                if type(Mods.AHRL.RequestItemValueIndex) == "function" then
                    Mods.AHRL.RequestItemValueIndex()
                end
                if (Mods.AHRL.ItemValueIndex == nil or #Mods.AHRL.ItemValueIndex == 0)
                    and type(Mods.AHRL.BuildLocalItemValueIndex) == "function"
                then
                    Mods.AHRL.BuildLocalItemValueIndex()
                end
            end
            return Mods.AHRL.ItemValueIndex or {}
        end

        local function rebuildModOptions()
            local seen = {}
            local options = {}
            for _, entry in ipairs(getIndex()) do
                local modName = entry.ModName or getModName(entry.ModId)
                if not seen[modName] then
                    seen[modName] = true
                    options[#options + 1] = modName
                end
            end

            table.sort(options)
            modCombo.Options = options
        end

        local function displayEntries(entries)
            clearResults()
            if entries == nil or #entries == 0 then
                resultsTable.Visible = false
                return
            end

            resultsTable.Visible = true
            local count = math.min(#entries, MAX_RESULTS)
            for i = 1, count do
                local entry = entries[i]
                local row = resultsTable:AddRow()
                local itemCell = row:AddCell()
                if isSafeIcon(entry.Icon) then
                    pcall(function()
                        local icon = itemCell:AddImage(entry.Icon, { 28, 28 })
                        icon.SameLine = true
                    end)
                end

                itemCell:AddText(string.format("%s (%s)", tostring(entry.DisplayName or entry.StatName or ""), tostring(entry.StatName or "")))
                row:AddCell():AddText(valueLabel(entry))

                local rule = getEntryRule(rules, entry)
                local keepCell = row:AddCell()
                local keep = keepCell:AddCheckbox("##Keep_" .. tostring(entry.StatName or ""), rule == "lock")
                keep.OnChange = function()
                    if keep.Checked then
                        setEntryRule(rules, entry, "lock")
                    elseif getEntryRule(rules, entry) == "lock" then
                        setEntryRule(rules, entry, nil)
                    end
                end

                local customCell = row:AddCell()
                local currentValue = type(rule) == "number" and rule or tonumber(entry.Value or entry.BaseValue) or 0
                local valueInput = addValueInput(customCell, currentValue)
                valueInput.SameLine = true

                local setButton = customCell:AddButton("Set")
                setButton.SameLine = true
                setButton.OnClick = function()
                    local customValue = math.max(0, math.floor(getControlInt(valueInput, currentValue)))
                    setEntryRule(rules, entry, customValue)
                    keep.Checked = false
                    setControlInt(valueInput, customValue)
                end

                local clearButton = customCell:AddButton("Clear")
                clearButton.SameLine = true
                clearButton.OnClick = function()
                    setEntryRule(rules, entry, nil)
                    keep.Checked = false
                    setControlInt(valueInput, tonumber(entry.Value or entry.BaseValue) or 0)
                end

                local vendorExcluded, enemyExcluded = getEntryExclusion(exclusions, entry)

                local noVendorCell = row:AddCell()
                local noVendor = noVendorCell:AddCheckbox("##NoVendor_" .. tostring(entry.StatName or ""), vendorExcluded)
                noVendor.OnChange = function()
                    local _, enemyNow = getEntryExclusion(exclusions, entry)
                    setEntryExclusion(exclusions, entry, noVendor.Checked, enemyNow)
                end

                local noEnemyCell = row:AddCell()
                local noEnemy = noEnemyCell:AddCheckbox("##NoEnemy_" .. tostring(entry.StatName or ""), enemyExcluded)
                noEnemy.OnChange = function()
                    local vendorNow, _ = getEntryExclusion(exclusions, entry)
                    setEntryExclusion(exclusions, entry, vendorNow, noEnemy.Checked)
                end
            end
        end

        local function refreshResults()
            rebuildModOptions()
            local entries = {}
            local search = trimText(searchInput.Text or "")
            local selectedMod = nil
            if modCombo.SelectedIndex ~= nil and modCombo.SelectedIndex >= 0 then
                selectedMod = modCombo.Options[modCombo.SelectedIndex + 1]
            end

            for _, entry in ipairs(getIndex()) do
                local include = true
                if search ~= "" then
                    include = entryMatchesSearch(entry, search)
                elseif selectedMod ~= nil then
                    include = (entry.ModName or getModName(entry.ModId)) == selectedMod
                else
                    include = false
                end

                if include then
                    entries[#entries + 1] = entry
                    if #entries >= MAX_RESULTS then
                        break
                    end
                end
            end

            displayEntries(entries)
        end

        searchInput.OnChange = function()
            if searchInput.Text ~= nil and searchInput.Text ~= "" then
                modCombo.SelectedIndex = -1
            end
            refreshResults()
        end

        modCombo.OnChange = function()
            searchInput.Text = ""
            refreshResults()
        end

        refreshButton.OnClick = function()
            Mods.AHRL.ItemValueIndexRequested = false
            Mods.AHRL.RequestItemValueIndex()
            if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
                Ext.Timer.WaitFor(1000, refreshResults)
            else
                refreshResults()
            end
        end

        Mods.AHRL.OnItemValueIndexChanged = refreshResults
        refreshResults()
        if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
            Ext.Timer.WaitFor(1000, refreshResults)
            Ext.Timer.WaitFor(3000, refreshResults)
        end
    end)
end

registerItemValueRulesMenu()
