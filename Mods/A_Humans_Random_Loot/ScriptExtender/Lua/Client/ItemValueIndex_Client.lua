local MOD_UUID = "0c84af14-9732-c150-2347-9396ff617ccd"
local ITEM_VALUE_INDEX_CHANNEL = MOD_UUID .. "_ItemValueIndex"

local SETTINGS = {
    ModdedValueCorrection = "modded_value_correction",
    ModdedValueThreshold = "modded_value_threshold",
    ModdedCommonValue = "modded_common_value",
    ModdedUncommonValue = "modded_uncommon_value",
    ModdedRareValue = "modded_rare_value",
    ModdedVeryRareValue = "modded_very_rare_value",
    ModdedLegendaryValue = "modded_legendary_value",
    ModdedValueIncludeOnly = "modded_value_include_only",
    ModdedValueModList = "modded_value_mod_list",
    ItemValueOverrides = "item_value_overrides",
}

local DEFAULTS = {
    modded_value_correction = false,
    modded_value_threshold = 50,
    modded_common_value = 500,
    modded_uncommon_value = 650,
    modded_rare_value = 800,
    modded_very_rare_value = 1000,
    modded_legendary_value = 1500,
    modded_value_include_only = false,
    modded_value_mod_list = "",
    item_value_overrides = "",
}

local RARITY_VALUE_SETTINGS = {
    Common = SETTINGS.ModdedCommonValue,
    Uncommon = SETTINGS.ModdedUncommonValue,
    Rare = SETTINGS.ModdedRareValue,
    VeryRare = SETTINGS.ModdedVeryRareValue,
    Legendary = SETTINGS.ModdedLegendaryValue,
}

local ITEM_VALUE_STAT_TYPES = { "Armor", "Weapon", "Object" }
local ALLOWED_MODIFIERS = {
    Armor = true,
    Weapon = true,
    Object = true,
}

Mods.AHRL = Mods.AHRL or {}
Mods.AHRL.ItemValueIndexRequested = Mods.AHRL.ItemValueIndexRequested or false
Mods.AHRL.ClientOriginalItemValues = Mods.AHRL.ClientOriginalItemValues or {}

local VANILLA_MOD_IDS = {
    ["ed539163-bb70-431b-96a7-f5b2eda5376b"] = true,
    ["1d5e38b2-7cc7-4b72-89d1-63d9aa2f6a5e"] = true,
    ["b176a0ac-d79f-ed9d-5a87-5c2c80874e10"] = true,
    ["e842840a-2449-588c-b0c4-22122cfce31b"] = true,
    ["e0a4d990-7b9b-8fa9-d7c6-04017c6cf5b1"] = true,
    ["ee4989eb-aab8-968f-8674-812ea2f4bfd7"] = true,
    ["630daa32-70f8-3da5-41b9-154fe8410236"] = true,
    ["ee5a55ff-eb38-0b27-c5b0-f358dc306d34"] = true,
    ["3d0c5ff8-c95d-c907-ff3e-34b204f1c630"] = true,
    ["991c9c7a-fb80-40cb-8f0d-b92d4e80e9b1"] = true,
    ["28ac9ce2-2aba-8cda-b3b5-6e922f71b6b8"] = true,
}

local function log(fmt, ...)
    local message = tostring(fmt)
    if select("#", ...) > 0 then
        local ok, formatted = pcall(string.format, message, ...)
        if ok then
            message = formatted
        end
    end

    local text = "[A Human's Random Loot] " .. message
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

local function trimText(value)
    return tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function normalizeRuleKey(value)
    local text = trimText(value)
    if text == "" then
        return nil
    end
    return string.lower(text)
end

local function safeField(object, field)
    if object == nil then
        return nil
    end

    local value = nil
    pcall(function()
        value = object[field]
    end)
    return value
end

local function safeCallMethod(object, method)
    if object == nil then
        return nil
    end

    local fn = nil
    pcall(function()
        fn = object[method]
    end)

    if type(fn) ~= "function" then
        return nil
    end

    local ok, value = pcall(function()
        return object[method](object)
    end)
    if ok then
        return value
    end
    return nil
end

local function getSetting(settingId)
    local fallback = DEFAULTS[settingId]

    if MCM ~= nil and type(MCM.Get) == "function" then
        local ok, value = pcall(function()
            return MCM.Get(settingId, MOD_UUID)
        end)
        if ok and value ~= nil then
            return value
        end

        ok, value = pcall(function()
            return MCM.Get(settingId)
        end)
        if ok and value ~= nil then
            return value
        end
    end

    if Mods ~= nil and Mods.BG3MCM ~= nil and Mods.BG3MCM.MCMAPI ~= nil then
        local api = Mods.BG3MCM.MCMAPI
        if type(api.GetSettingValue) == "function" then
            local ok, value = pcall(function()
                return api:GetSettingValue(settingId, MOD_UUID)
            end)
            if ok and value ~= nil then
                return value
            end
        end
    end

    return fallback
end

local function settingBool(settingId)
    return getSetting(settingId) == true
end

local function settingInt(settingId, minimum, maximum)
    local value = tonumber(getSetting(settingId)) or tonumber(DEFAULTS[settingId]) or minimum
    value = math.floor(value)
    if value < minimum then
        value = minimum
    elseif value > maximum then
        value = maximum
    end
    return value
end

local function getMcmRuleText()
    if Mods.AHRL.ItemValueOverrideTextOverride ~= nil then
        return tostring(Mods.AHRL.ItemValueOverrideTextOverride)
    end

    return tostring(getSetting(SETTINGS.ItemValueOverrides) or "")
end

local function parseItemValueOverrideText(text)
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
                    rules[key] = { Mode = "lock" }
                else
                    local number = tonumber(rawValue)
                    if number ~= nil then
                        rules[key] = {
                            Mode = "value",
                            Value = math.max(0, math.floor(number)),
                        }
                    end
                end
            end
        end
    end
    return rules
end

local function getItemValueOverrideRules()
    local text = getMcmRuleText()
    if Mods.AHRL.ItemValueOverrideRules ~= nil and Mods.AHRL.ItemValueOverrideRulesText == text then
        return Mods.AHRL.ItemValueOverrideRules
    end

    Mods.AHRL.ItemValueOverrideRulesText = text
    Mods.AHRL.ItemValueOverrideRules = parseItemValueOverrideText(text)
    return Mods.AHRL.ItemValueOverrideRules
end

local function normalizeRarity(value)
    if value == nil or value == "" then
        return "Common"
    end

    local number = tonumber(value)
    if number ~= nil then
        number = math.floor(number)
        if number <= 0 then
            return "Common"
        elseif number == 1 then
            return "Uncommon"
        elseif number == 2 then
            return "Rare"
        elseif number == 3 then
            return "VeryRare"
        end
        return "Legendary"
    end

    local text = string.lower(tostring(value or "")):gsub("%s+", ""):gsub("_", "")
    if text == "legendary" or text == "divine" then
        return "Legendary"
    elseif text == "veryrare" or text == "superrare" or text == "epic" then
        return "VeryRare"
    elseif text == "rare" then
        return "Rare"
    elseif text == "uncommon" then
        return "Uncommon"
    end
    return "Common"
end

local function getModdedRarityValue(rarity)
    local key = normalizeRarity(rarity)
    local setting = RARITY_VALUE_SETTINGS[key] or SETTINGS.ModdedCommonValue
    return settingInt(setting, 0, 1000000)
end

local function isVanillaModId(modId)
    local text = string.lower(tostring(modId or ""))
    return text == "" or VANILLA_MOD_IDS[text] == true
end

local function getStatsData(statName)
    if statName == nil or tostring(statName) == "" then
        return nil
    end

    if Ext == nil or Ext.Stats == nil or type(Ext.Stats.Get) ~= "function" then
        return nil
    end

    local ok, stat = pcall(Ext.Stats.Get, tostring(statName))
    if ok then
        return stat
    end
    return nil
end

local function getStatsNumber(stat, fields)
    for _, field in ipairs(fields) do
        local value = safeField(stat, field)
        if value ~= nil and tostring(value) ~= "" then
            local number = tonumber(value)
            if number ~= nil then
                return number
            end
        end
    end
    return nil
end

local function translatedTemplateName(template, fallback)
    local direct = safeCallMethod(safeField(template, "DisplayName"), "Get")
    if type(direct) == "string" and direct ~= "" then
        return direct
    end

    local handle = nil
    pcall(function()
        if template.DisplayName ~= nil and template.DisplayName.Handle ~= nil then
            handle = template.DisplayName.Handle
        else
            handle = template.DisplayName
        end
    end)

    if type(handle) == "table" and handle.Handle ~= nil then
        handle = handle.Handle
    end

    if handle ~= nil and Ext ~= nil and Ext.Loca ~= nil and type(Ext.Loca.GetTranslatedString) == "function" then
        local ok, value = pcall(Ext.Loca.GetTranslatedString, tostring(handle))
        if ok and type(value) == "string" and value ~= "" then
            return value
        end
    end

    return fallback
end

local function getModName(modId)
    if modId == nil or tostring(modId) == "" or isVanillaModId(modId) then
        return "Base Game"
    end

    if Ext ~= nil and Ext.Mod ~= nil and type(Ext.Mod.GetMod) == "function" then
        local ok, modInfo = pcall(Ext.Mod.GetMod, tostring(modId))
        if ok and modInfo ~= nil and modInfo.Info ~= nil and modInfo.Info.Name ~= nil then
            return tostring(modInfo.Info.Name)
        end
    end

    return "Unknown Mod"
end

local function getAllRootTemplates()
    if Ext ~= nil and Ext.ClientTemplate ~= nil and type(Ext.ClientTemplate.GetAllRootTemplates) == "function" then
        local ok, templates = pcall(Ext.ClientTemplate.GetAllRootTemplates)
        if ok and type(templates) == "table" then
            return templates
        end
    end

    if Ext ~= nil and Ext.Template ~= nil and type(Ext.Template.GetAllRootTemplates) == "function" then
        local ok, templates = pcall(Ext.Template.GetAllRootTemplates)
        if ok and type(templates) == "table" then
            return templates
        end
    end

    return nil
end

local function getRootTemplate(templateId)
    if templateId == nil or tostring(templateId) == "" then
        return nil
    end

    local id = tostring(templateId)
    if Ext ~= nil and Ext.ClientTemplate ~= nil and type(Ext.ClientTemplate.GetRootTemplate) == "function" then
        local ok, template = pcall(Ext.ClientTemplate.GetRootTemplate, id)
        if ok and template ~= nil then
            return template
        end
    end

    if Ext ~= nil and Ext.Template ~= nil and type(Ext.Template.GetRootTemplate) == "function" then
        local ok, template = pcall(Ext.Template.GetRootTemplate, id)
        if ok and template ~= nil then
            return template
        end
    end

    return nil
end

local function templateIsAllowed(template)
    local templateType = tostring(safeField(template, "TemplateType") or "")
    if templateType ~= "" and string.lower(templateType) ~= "item" then
        return false
    end

    -- Some BG3SE versions do not expose CanBePickedUp on the client template object.
    -- Only reject explicit false; nil is allowed so the search table does not become empty.
    if safeField(template, "CanBePickedUp") == false then
        return false
    end

    return true
end

local function makeEntryFromTemplate(template)
    if template == nil or not templateIsAllowed(template) then
        return nil
    end

    local statName = safeField(template, "Stats")
    if statName == nil or tostring(statName) == "" then
        return nil
    end
    statName = tostring(statName)

    local stat = getStatsData(statName)
    if stat == nil then
        return nil
    end

    local modifierList = tostring(safeField(stat, "ModifierList") or "")
    if not ALLOWED_MODIFIERS[modifierList] then
        return nil
    end

    local templateId = safeField(template, "Id")
    if templateId == nil or tostring(templateId) == "" then
        templateId = safeField(stat, "RootTemplate")
    end
    if templateId == nil or tostring(templateId) == "" then
        return nil
    end

    local statValue = getStatsNumber(stat, { "ValueOverride", "Value" })
    local modId = safeField(stat, "ModId") or safeField(stat, "OriginalModId")
    local name = safeField(template, "Name") or safeField(template, "TemplateName") or safeField(stat, "Name") or statName
    local displayName = translatedTemplateName(template, tostring(name or statName))

    return {
        StatName = statName,
        Stats = statName,
        Template = tostring(templateId),
        Name = tostring(name or statName),
        DisplayName = tostring(displayName or name or statName),
        Icon = safeField(template, "Icon") or "Item_Unknown",
        Rarity = normalizeRarity(safeField(stat, "Rarity")),
        Value = tonumber(statValue) or 0,
        BaseValue = tonumber(statValue) or 0,
        GoldValue = tonumber(statValue) or 0,
        ValueKnown = statValue ~= nil,
        IsModded = not isVanillaModId(modId),
        ModId = modId,
        FileName = safeField(template, "FileName"),
        ModName = getModName(modId),
    }
end

local function makeEntryFromStat(statName)
    local stat = getStatsData(statName)
    if stat == nil then
        return nil
    end

    local modifierList = tostring(safeField(stat, "ModifierList") or "")
    if not ALLOWED_MODIFIERS[modifierList] then
        return nil
    end

    local template = getRootTemplate(safeField(stat, "RootTemplate"))
    if template == nil then
        return nil
    end

    return makeEntryFromTemplate(template)
end

local function forEachItemStat(callback, options)
    options = options or {}
    local count = 0
    local seenTemplates = {}
    local seenStats = {}

    local templates = getAllRootTemplates()
    if type(templates) == "table" then
        for _, template in pairs(templates) do
            local entry = makeEntryFromTemplate(template)
            if entry ~= nil then
                local templateKey = tostring(entry.Template or "")
                local statKey = tostring(entry.StatName or entry.Stats or "")
                local duplicateTemplate = templateKey ~= "" and seenTemplates[templateKey] == true
                local duplicateStat = options.DedupeStats == true and statKey ~= "" and seenStats[statKey] == true
                if not duplicateTemplate and not duplicateStat then
                    if templateKey ~= "" then
                        seenTemplates[templateKey] = true
                    end
                    if statKey ~= "" then
                        seenStats[statKey] = true
                    end
                    count = count + 1
                    callback(entry)
                end
            end
        end
    end

    if count > 0 then
        return count
    end

    if Ext == nil or Ext.Stats == nil or type(Ext.Stats.GetStats) ~= "function" then
        return 0
    end

    for _, statType in ipairs(ITEM_VALUE_STAT_TYPES) do
        local ok, stats = pcall(Ext.Stats.GetStats, statType)
        if ok and type(stats) == "table" then
            for _, statName in pairs(stats) do
                local statKey = tostring(statName or "")
                if statKey ~= "" and seenStats[statKey] ~= true then
                    seenStats[statKey] = true
                    local entry = makeEntryFromStat(statKey)
                    if entry ~= nil then
                        count = count + 1
                        callback(entry)
                    end
                end
            end
        end
    end

    return count
end

local function parseModIdList(text)
    local entries = {}
    local source = tostring(text or "")

    for rawLine in source:gmatch("[^\r\n;]+") do
        local line = trimText(rawLine)
        if line ~= "" and line:sub(1, 1) ~= "#" then
            local key = normalizeRuleKey(line)
            if key ~= nil then
                entries[#entries + 1] = key
            end
        end
    end

    return entries
end

local function getModValueFilterConfig()
    return {
        IncludeOnly = settingBool(SETTINGS.ModdedValueIncludeOnly),
        Entries = parseModIdList(getSetting(SETTINGS.ModdedValueModList)),
    }
end

local function modListEntryMatches(modId, fileName, entry)
    if entry == nil or entry == "" then
        return false
    end

    local modText = normalizeRuleKey(modId) or ""
    local fileText = normalizeRuleKey(fileName) or ""

    if modText ~= "" and (modText == entry or modText:find(entry, 1, true) ~= nil or entry:find(modText, 1, true) ~= nil) then
        return true
    end

    if fileText ~= "" and (fileText:find(entry, 1, true) ~= nil or entry:find(fileText, 1, true) ~= nil) then
        return true
    end

    return false
end

local function modMatchesValueFilterList(modId, fileName, entries)
    for _, entry in ipairs(entries or {}) do
        if modListEntryMatches(modId, fileName, entry) then
            return true
        end
    end

    return false
end

local function moddedValueCorrectionAppliesTo(entry)
    if entry == nil or entry.IsModded ~= true or not settingBool(SETTINGS.ModdedValueCorrection) then
        return false
    end

    local filter = getModValueFilterConfig()
    local entries = filter.Entries or {}
    local matches = modMatchesValueFilterList(entry.ModId, entry.FileName, entries)

    if filter.IncludeOnly == true then
        if #entries == 0 then
            return false
        end
        return matches
    end

    if #entries == 0 then
        return true
    end

    return not matches
end

local function findItemValueOverrideRule(entry)
    if entry == nil then
        return nil
    end

    local rules = getItemValueOverrideRules()
    local keys = {
        entry.StatName,
        entry.Stats,
        entry.Template,
        entry.Name,
        entry.DisplayName,
        entry.Guid,
    }

    for _, key in ipairs(keys) do
        local normalized = normalizeRuleKey(key)
        if normalized ~= nil and rules[normalized] ~= nil then
            return rules[normalized]
        end
    end

    return nil
end

local function getTargetStatValue(entry)
    local override = findItemValueOverrideRule(entry)
    if override ~= nil then
        if override.Mode == "lock" then
            return nil, "locked"
        elseif override.Mode == "value" then
            return math.max(0, math.floor(tonumber(override.Value) or 0)), "custom"
        end
    end

    if moddedValueCorrectionAppliesTo(entry) then
        local value = tonumber(entry.GoldValue or entry.Value or entry.BaseValue) or 0
        local threshold = settingInt(SETTINGS.ModdedValueThreshold, 0, 1000000)
        if entry.ValueKnown ~= true or value < threshold then
            return getModdedRarityValue(entry.Rarity), "rarity"
        end
    end

    return nil, "unchanged"
end

local function hasAnyValueRule()
    local rules = getItemValueOverrideRules()
    for _, _ in pairs(rules or {}) do
        return true
    end
    return false
end

local function itemValueCorrectionEnabled()
    if settingBool(SETTINGS.ModdedValueCorrection) or hasAnyValueRule() then
        return true
    end

    for _, _ in pairs(Mods.AHRL.ClientOriginalItemValues or {}) do
        return true
    end

    return false
end

local function syncStat(stat, statName)
    pcall(function()
        if stat ~= nil and type(stat.Sync) == "function" then
            stat:Sync()
        end
    end)
    pcall(function()
        if Ext ~= nil and Ext.Stats ~= nil and type(Ext.Stats.Sync) == "function" then
            Ext.Stats.Sync(statName)
        end
    end)
end

local function setStatGoldValue(statName, value)
    local stat = getStatsData(statName)
    if stat == nil then
        return false, "stat not found"
    end

    local number = math.max(0, math.floor(tonumber(value) or 0))
    local fields = { "ValueOverride", "Value" }
    local lastError = nil

    for _, field in ipairs(fields) do
        local ok, err = pcall(function()
            stat[field] = number
        end)
        if ok then
            local actual = tonumber(safeField(stat, field))
            if actual == number then
                syncStat(stat, statName)
                return true, nil
            end
            lastError = string.format("%s readback was %s after setting %d", tostring(field), tostring(actual), number)
        else
            lastError = tostring(err)
        end
    end

    return false, lastError
end

function Mods.AHRL.ApplyItemValueStatCorrections(reason)
    if not itemValueCorrectionEnabled() then
        return
    end

    local changed = 0
    local restored = 0
    local failed = 0
    local checked = 0
    local firstError = nil
    local originals = Mods.AHRL.ClientOriginalItemValues

    forEachItemStat(function(entry)
        checked = checked + 1
        local target, mode = getTargetStatValue(entry)
        local statName = tostring(entry.StatName or entry.Stats or "")
        if statName == "" then
            return
        end

        local current = tonumber(entry.GoldValue or entry.Value or entry.BaseValue) or 0
        if target == nil then
            local original = originals[statName]
            if original ~= nil and original ~= false and current ~= original then
                local ok, err = setStatGoldValue(statName, original)
                if ok then
                    restored = restored + 1
                    originals[statName] = nil
                else
                    failed = failed + 1
                    firstError = firstError or tostring(err or "unknown error")
                end
            elseif mode ~= "locked" then
                originals[statName] = nil
            end
            return
        end

        if originals[statName] == nil then
            originals[statName] = entry.ValueKnown == true and current or false
        end

        if entry.ValueKnown == true and current == target then
            return
        end

        local ok, err = setStatGoldValue(statName, target)
        if ok then
            changed = changed + 1
        else
            failed = failed + 1
            firstError = firstError or tostring(err or "unknown error")
        end
    end, { DedupeStats = true })

    Mods.AHRL.ItemValueIndex = nil
    if Mods.AHRL.SuppressItemValueIndexChanged ~= true and type(Mods.AHRL.OnItemValueIndexChanged) == "function" then
        pcall(Mods.AHRL.OnItemValueIndexChanged)
    end

    if changed > 0 or restored > 0 or failed > 0 then
        log("Client item value correction from %s checked=%d changed=%d restored=%d failed=%d%s",
            tostring(reason or "settings"), checked, changed, restored, failed,
            firstError ~= nil and (" firstError=" .. firstError) or "")
    end
end

-- StatsLoaded, SessionLoaded and the index build each used to trigger their own full pass over
-- every item stat (~11k). One pass per session is enough; MCM/rule changes still force a new one.
local clientCorrectionDone = false
local clientCorrectionPending = false

local function scheduleApplyItemValueStatCorrections(reason, delay)
    local forced = (reason == "mcm-client" or reason == "client-rule-text")
    if forced then
        clientCorrectionDone = false
    elseif clientCorrectionDone or clientCorrectionPending then
        return
    end

    clientCorrectionPending = true
    local function run()
        clientCorrectionPending = false
        clientCorrectionDone = true
        Mods.AHRL.ApplyItemValueStatCorrections(reason)
    end

    if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
        Ext.Timer.WaitFor(delay or 250, run)
    else
        run()
    end
end

function Mods.AHRL.SetLocalItemValueOverrideText(text)
    Mods.AHRL.ItemValueOverrideTextOverride = tostring(text or "")
    Mods.AHRL.ItemValueOverrideRules = nil
    Mods.AHRL.ItemValueOverrideRulesText = nil
    Mods.AHRL.ItemValueIndex = nil
    scheduleApplyItemValueStatCorrections("client-rule-text", 50)
end

function Mods.AHRL.BuildLocalItemValueIndex()
    -- Entries are read from the live stat values, so a pass is only needed here if the normal
    -- per-session pass has not run yet.
    if not clientCorrectionDone then
        Mods.AHRL.SuppressItemValueIndexChanged = true
        Mods.AHRL.ApplyItemValueStatCorrections("build-index")
        Mods.AHRL.SuppressItemValueIndexChanged = false
        clientCorrectionDone = true
    end

    local index = {}
    forEachItemStat(function(entry)
        index[#index + 1] = {
            StatName = entry.StatName or entry.Stats,
            Template = entry.Template,
            DisplayName = entry.DisplayName or entry.Name or entry.StatName or entry.Stats,
            Icon = entry.Icon,
            Rarity = entry.Rarity,
            Value = tonumber(entry.Value or entry.GoldValue or entry.BaseValue) or 0,
            BaseValue = tonumber(entry.BaseValue or entry.GoldValue or entry.Value) or 0,
            ValueKnown = entry.ValueKnown == true,
            IsModded = entry.IsModded == true,
            ModId = entry.ModId,
            ModName = entry.ModName or getModName(entry.ModId),
        }
    end)

    table.sort(index, function(a, b)
        return tostring(a.DisplayName or a.StatName or "") < tostring(b.DisplayName or b.StatName or "")
    end)

    Mods.AHRL.ItemValueIndex = index
    if type(Mods.AHRL.OnItemValueIndexChanged) == "function" then
        pcall(Mods.AHRL.OnItemValueIndexChanged)
    end
    log("Client item value index built with %d searchable items", #index)
    return index
end

local function ensureLocalFallback()
    if type(Mods.AHRL.ItemValueIndex) ~= "table" or #Mods.AHRL.ItemValueIndex == 0 then
        Mods.AHRL.BuildLocalItemValueIndex()
    end
end

local function onItemValueIndexReceived(payload)
    if payload == nil then
        return
    end

    local ok, data = pcall(function()
        if type(payload) == "string" then
            return Ext.Json.Parse(payload)
        end
        return payload
    end)

    if ok and type(data) == "table" then
        Mods.AHRL.ItemValueIndex = data
        if type(Mods.AHRL.OnItemValueIndexChanged) == "function" then
            pcall(Mods.AHRL.OnItemValueIndexChanged)
        end
    end
end

local function registerItemValueIndexListeners()
    if Mods.AHRL.ItemValueIndexListenersRegistered then
        return
    end

    Mods.AHRL.ItemValueIndexListenersRegistered = true
    if ChunkedNet ~= nil and ChunkedNet.Client ~= nil and type(ChunkedNet.Client.RegisterNetListeners) == "function" then
        pcall(ChunkedNet.Client.RegisterNetListeners)
        if type(ChunkedNet.Client.RegisterHandler) == "function" then
            ChunkedNet.Client.RegisterHandler(ITEM_VALUE_INDEX_CHANNEL, function(jsonText)
                onItemValueIndexReceived(jsonText)
            end)
        end
    end

    if Ext ~= nil and type(Ext.RegisterNetListener) == "function" then
        Ext.RegisterNetListener(ITEM_VALUE_INDEX_CHANNEL, function(_, payload, _)
            onItemValueIndexReceived(payload)
        end)
    end
end

function Mods.AHRL.RequestItemValueIndex()
    registerItemValueIndexListeners()
    if Mods.AHRL.ItemValueIndexRequested then
        ensureLocalFallback()
        return
    end

    Mods.AHRL.ItemValueIndexRequested = true
    if Ext ~= nil and Ext.Net ~= nil and type(Ext.Net.PostMessageToServer) == "function" then
        Ext.Net.PostMessageToServer(ITEM_VALUE_INDEX_CHANNEL .. "_REQ", "")
    end

    -- The full index can be too large for an unchunked net message, and some setups do not have ChunkedNet.
    -- The local client index mirrors Attunement's approach and keeps the search UI usable even if the server reply is dropped.
    if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
        Ext.Timer.WaitFor(500, ensureLocalFallback)
        Ext.Timer.WaitFor(2000, ensureLocalFallback)
    else
        ensureLocalFallback()
    end
end

local function subscribeMCMClient()
    if Mods.AHRL.ClientMCMSubscribed then
        return
    end

    local subscribed = false
    if Ext ~= nil and Ext.ModEvents ~= nil and Ext.ModEvents.BG3MCM ~= nil then
        local events = Ext.ModEvents.BG3MCM
        local function onChanged(payload)
            if type(payload) == "table" then
                local modId = payload.modUUID or payload.modGUID or payload.modUuid or payload.modGuid or payload.ModUUID or payload.ModGUID
                if modId ~= nil and modId ~= MOD_UUID then
                    return
                end
            end
            Mods.AHRL.ItemValueOverrideTextOverride = nil
            Mods.AHRL.ItemValueOverrideRules = nil
            Mods.AHRL.ItemValueOverrideRulesText = nil
            Mods.AHRL.ItemValueIndex = nil
            scheduleApplyItemValueStatCorrections("mcm-client", 100)
        end

        if events["MCM_Setting_Saved"] ~= nil then
            events["MCM_Setting_Saved"]:Subscribe(onChanged)
            subscribed = true
        end
        if events["MCM_Setting_Reset"] ~= nil then
            events["MCM_Setting_Reset"]:Subscribe(onChanged)
            subscribed = true
        end
    end

    if subscribed then
        Mods.AHRL.ClientMCMSubscribed = true
    elseif Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
        Ext.Timer.WaitFor(1000, subscribeMCMClient)
    end
end

registerItemValueIndexListeners()
subscribeMCMClient()

if Ext ~= nil and Ext.Events ~= nil and Ext.Events.StatsLoaded ~= nil then
    Ext.Events.StatsLoaded:Subscribe(function()
        scheduleApplyItemValueStatCorrections("stats-loaded-client", 250)
    end)
end

if Ext ~= nil and Ext.Events ~= nil and Ext.Events.SessionLoaded ~= nil then
    Ext.Events.SessionLoaded:Subscribe(function()
        Mods.AHRL.ItemValueIndexRequested = false
        Mods.AHRL.ItemValueIndex = nil
        registerItemValueIndexListeners()
        subscribeMCMClient()
        scheduleApplyItemValueStatCorrections("session-loaded-client", 1000)
        -- The searchable index is only needed once the "Item Value Rules" MCM tab is opened, and
        -- that tab already builds it on demand (RequestItemValueIndex / getIndex), so it is no
        -- longer built eagerly at every load.
    end)
else
    ensureLocalFallback()
end
