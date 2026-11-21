local MOD = "A Human's Random Loot"
local MOD_UUID = "0c84af14-9732-c150-2347-9396ff617ccd"

local SETTINGS = {
    Enabled = "mod_enabled",
    HeavyGlobalScans = "enable_heavy_global_scans",
    ApplyOnLoad = "apply_on_load",
    FreezeRandomization = "freeze_randomization",
    ApplyNewWhileFrozen = "apply_new_actors_while_frozen",
    PeriodicScan = "periodic_scan",
    Debug = "debug_logging",
    VendorRandom = "vendor_random_stock",
    VendorFiltered = "vendor_filtered_stock",
    VendorPlus = "vendor_plus",
    VendorRemoveExisting = "vendor_remove_existing_stock",
    VendorDuplicateRemoval = "vendor_duplicate_removal",
    VendorGeneratedItems = "vendor_generated_items",
    VendorEssentialStock = "vendor_essential_stock",
    VendorEssentialChance = "vendor_essential_chance",
    VendorEssentialCount = "vendor_essential_count",
    VendorPreserveEssential = "vendor_preserve_essential_stock",
    EnemyRandom = "enemy_random_loot",
    EnemyRemoveExisting = "enemy_remove_existing_loot",
    EnemyIncludeNeutral = "enemy_include_neutral_npcs",
    EnemyDropScaling = "enemy_max_extra_drops",
    ProtectStory = "protect_story_items",
    SkipBrokenItems = "skip_broken_items",
    ProtectBosses = "protect_bosses",
    BlockCombined = "block_combined_items",
    MaxValuePerLevel = "max_value_per_level",
    AllowUnknownValue = "allow_unknown_value_templates",
    IncludeJunk = "include_junk",
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
    LootModFilterEnabled = "loot_mod_filter_enabled",
    LootModFilterMode = "loot_mod_filter_mode",
    LootModFilterList = "loot_mod_filter_list",
    ExcludedItems = "excluded_items",
    RarityWeightsEnabled = "rarity_weights_enabled",
    RarityWeightCommonAct1 = "rarity_weight_common_act1",
    RarityWeightCommonAct2 = "rarity_weight_common_act2",
    RarityWeightCommonAct3 = "rarity_weight_common_act3",
    RarityWeightUncommonAct1 = "rarity_weight_uncommon_act1",
    RarityWeightUncommonAct2 = "rarity_weight_uncommon_act2",
    RarityWeightUncommonAct3 = "rarity_weight_uncommon_act3",
    RarityWeightRareAct1 = "rarity_weight_rare_act1",
    RarityWeightRareAct2 = "rarity_weight_rare_act2",
    RarityWeightRareAct3 = "rarity_weight_rare_act3",
    RarityWeightVeryRareAct1 = "rarity_weight_veryrare_act1",
    RarityWeightVeryRareAct2 = "rarity_weight_veryrare_act2",
    RarityWeightVeryRareAct3 = "rarity_weight_veryrare_act3",
    RarityWeightLegendaryAct1 = "rarity_weight_legendary_act1",
    RarityWeightLegendaryAct2 = "rarity_weight_legendary_act2",
    RarityWeightLegendaryAct3 = "rarity_weight_legendary_act3",
}

local DEFAULTS = {
    mod_enabled = true,
    enable_heavy_global_scans = false,
    apply_on_load = false,
    freeze_randomization = false,
    apply_new_actors_while_frozen = false,
    periodic_scan = false,
    debug_logging = false,
    vendor_random_stock = false,
    vendor_filtered_stock = false,
    vendor_plus = false,
    vendor_remove_existing_stock = true,
    vendor_duplicate_removal = false,
    vendor_generated_items = 40,
    vendor_essential_stock = true,
    vendor_essential_chance = 50,
    vendor_essential_count = 3,
    vendor_preserve_essential_stock = true,
    enemy_random_loot = false,
    enemy_remove_existing_loot = true,
    enemy_include_neutral_npcs = false,
    enemy_max_extra_drops = 4,
    protect_story_items = true,
    skip_broken_items = true,
    protect_bosses = true,
    block_combined_items = true,
    max_value_per_level = true,
    allow_unknown_value_templates = true,
    include_junk = true,
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
    loot_mod_filter_enabled = false,
    loot_mod_filter_mode = "Exclude",
    loot_mod_filter_list = "",
    excluded_items = "",
    rarity_weights_enabled = false,
    rarity_weight_common_act1 = 50,
    rarity_weight_common_act2 = 30,
    rarity_weight_common_act3 = 20,
    rarity_weight_uncommon_act1 = 30,
    rarity_weight_uncommon_act2 = 30,
    rarity_weight_uncommon_act3 = 25,
    rarity_weight_rare_act1 = 15,
    rarity_weight_rare_act2 = 25,
    rarity_weight_rare_act3 = 30,
    rarity_weight_veryrare_act1 = 4,
    rarity_weight_veryrare_act2 = 10,
    rarity_weight_veryrare_act3 = 15,
    rarity_weight_legendary_act1 = 1,
    rarity_weight_legendary_act2 = 5,
    rarity_weight_legendary_act3 = 10,
}

local GOLD_TEMPLATE_GUID = "1c3c9c74-34a1-4685-989e-410dc080be6f"

local UNSAFE_TEMPLATE_PATTERNS = {
    "quest",
    "story",
    "plot",
    "debug",
    "test",
    "dummy",
    "placeholder",
    "cinematic",
    "cutscene",
    "dialog",
    "dialogue",
    "tutorial",
    "container",
    "chest",
    "crate",
    "barrel",
    "bag_",
    "key",
    "letter",
    "note",
    "book",
    "blood_of_lathander",
    "bloodoflathander",
    "lathander",
    "netherstone",
    "orphic",
    "astral_prism",
    "prism",
    "tadpole",
    "parasite",
    "infernal_iron",
    "sussur",
    "runepowder",
    "rune_powder",
    "idol",
    "nightsong",
    "spear_of_night",
    "moonlantern",
    "moon_lantern",
    "pixie",
    "necromancy_of_thay",
    "thay",
    "umbral",
}

local function makeSet(values)
    local set = {}
    for _, value in ipairs(values) do
        set[string.lower(tostring(value))] = true
    end
    return set
end

local VANILLA_MOD_IDS = makeSet({
    "ed539163-bb70-431b-96a7-f5b2eda5376b", -- Shared
    "3d0c5ff8-c95d-c907-ff3e-34b204f1c630", -- SharedDev
    "991c9c7a-fb80-40cb-8f0d-b92d4e80e9b1", -- Gustav
    "28ac9ce2-2aba-8cda-b3b5-6e922f71b6b8", -- GustavDev
    "cb555efe-2d9e-131f-8195-a89329d218ea", -- GustavX
    "630daa32-70f8-3da5-41b9-154fe8410236", -- MainUI
    "ee5a55ff-eb38-0b27-c5b0-f358dc306d34", -- ModBrowser
    "b176a0ac-d79f-ed9d-5a87-5c2c80874e10", -- DiceSet_02
    "e842840a-2449-588c-b0c4-22122cfce31b", -- DiceSet_01
    "e0a4d990-7b9b-8fa9-d7c6-04017c6cf5b1", -- DiceSet_03
    "ee4989eb-aab8-968f-8674-812ea2f4bfd7", -- DiceSet_06
})

local VANILLA_FILE_SEGMENTS = {
    "Public/Gustav",
    "Public/GustavDev",
    "Public/GustavX",
    "Public/Shared",
    "Public/SharedDev",
    "Public/Honour",
    "Public/HonourX",
    "Mods/Gustav",
    "Mods/GustavDev",
    "Mods/GustavX",
    "Mods/Shared",
    "Mods/SharedDev",
    "Mods/Honour",
    "Mods/HonourX",
    "Mods/MainUI",
    "Mods/ModBrowser",
}

local RARITY_VALUE_SETTINGS = {
    Common = SETTINGS.ModdedCommonValue,
    Uncommon = SETTINGS.ModdedUncommonValue,
    Rare = SETTINGS.ModdedRareValue,
    VeryRare = SETTINGS.ModdedVeryRareValue,
    Legendary = SETTINGS.ModdedLegendaryValue,
}

local RARITY_WEIGHT_SETTINGS = {
    Common = {
        SETTINGS.RarityWeightCommonAct1,
        SETTINGS.RarityWeightCommonAct2,
        SETTINGS.RarityWeightCommonAct3,
    },
    Uncommon = {
        SETTINGS.RarityWeightUncommonAct1,
        SETTINGS.RarityWeightUncommonAct2,
        SETTINGS.RarityWeightUncommonAct3,
    },
    Rare = {
        SETTINGS.RarityWeightRareAct1,
        SETTINGS.RarityWeightRareAct2,
        SETTINGS.RarityWeightRareAct3,
    },
    VeryRare = {
        SETTINGS.RarityWeightVeryRareAct1,
        SETTINGS.RarityWeightVeryRareAct2,
        SETTINGS.RarityWeightVeryRareAct3,
    },
    Legendary = {
        SETTINGS.RarityWeightLegendaryAct1,
        SETTINGS.RarityWeightLegendaryAct2,
        SETTINGS.RarityWeightLegendaryAct3,
    },
}

local ESSENTIAL_VENDOR_IDS = makeSet({
    -- Vanilla and Rest System supply packs.
    "OBJ_Camp_Pack",
    "LOOT_Camp_Pack",
    "OBJ_Camp_Pack_Greater",
    "LOOT_Camp_Pack_Greater",
    "FED_Rations_Pack",
    "OBJ_FoodAndWater",
    "OBJ_Camp_Pack_2e_CreateFood",
    "398e7328-ce90-4c02-94a2-93341fac499a",
    "a24a2ca2-a213-424c-833d-47c79934c0ce",
    "7ca3588a-4270-4044-ace7-b633a55aecf2",
    "c5cd6220-425e-4808-892a-f45555555555",

    -- Vanilla and Damage Destruction revive/raise-dead scrolls.
    "OBJ_Scroll_Revivify",
    "I_OBJ_Scroll_Revivify",
    "LOOT_SCROLL_Revivify",
    "OBJ_Scroll_Revivify_TrueResurrection",
    "I_OBJ_Scroll_Revivify_TrueResurrection",
    "01d1b2b2-9e6b-4ad2-8d63-59f9caf1d389",
    "UTAM_Scroll_OBJ_7ef78dd5-feff-4a70-9af2-43d03570d291",
    "UTAM_Scroll_OBJ_bf0f79fc-eb04-4e4f-9f0b-842c0c676c09",
    "UTAM_Scroll_OBJ_e59a2f43-3152-4b23-9288-b4dcb1ca8582",
    "UTAM_Scroll_OBJ_cbe31b42-22a8-4e26-a56f-0645d081503a",
    "UTAM_Scroll_OBJ_0be66f48-4920-4d7e-ab1d-ce8dce417d01",
    "I_UTAM_Scroll_OBJ_7ef78dd5-feff-4a70-9af2-43d03570d291",
    "I_UTAM_Scroll_OBJ_bf0f79fc-eb04-4e4f-9f0b-842c0c676c09",
    "I_UTAM_Scroll_OBJ_e59a2f43-3152-4b23-9288-b4dcb1ca8582",
    "I_UTAM_Scroll_OBJ_cbe31b42-22a8-4e26-a56f-0645d081503a",
    "I_UTAM_Scroll_OBJ_0be66f48-4920-4d7e-ab1d-ce8dce417d01",
    "7ef78dd5-feff-4a70-9af2-43d03570d291",
    "bf0f79fc-eb04-4e4f-9f0b-842c0c676c09",
    "e59a2f43-3152-4b23-9288-b4dcb1ca8582",
    "cbe31b42-22a8-4e26-a56f-0645d081503a",
    "0be66f48-4920-4d7e-ab1d-ce8dce417d01",

    -- Grit and Glory injury kits.
    "Goon_OBJ_Injury_Kit_A",
    "Goon_OBJ_Injury_Kit_B",
    "I_Goon_OBJ_Injury_Kit_A",
    "I_Goon_OBJ_Injury_Kit_B",
    "70b86e8f-06b1-4eb2-8211-17f1d850086d",
    "55fb2f34-00d7-4149-8b52-e189e05ba0ca",

    -- APC's Rest System crafting/rest utility items.
    "apcsWoodenPices01",
    "apcs_Barricade_F",
    "apcsTool_Saw",
    "apcsTool_Kit",
    "apcsNails_A",
    "apsc_Flint_A",
    "apcs_Bench_A",
    "apcs_Stool_A",
    "apcs_ScrollCraft_A",
    "I_apcsTool_Saw",
    "I_apcsTool_Kit",
    "I_apcsNails_A",
    "I_apsc_Flint_A",
    "I_apcs_ScrollCraft_A",
    "cef0f6ec-6662-408c-9701-ab0d6b7697de",
    "f1ef4714-b31c-405f-aa8f-cffa8e77152a",
    "643a6a8e-4486-4b0f-ac2b-c0353409d13d",
    "3d8ad091-b216-4ca2-9902-4e93c1331f73",
    "2f55eba5-bb38-4f8a-8c84-bc70280378d6",
    "0962426e-3656-474c-ab20-6f9b9e3ec985",
    "a18fa996-1ab2-417f-aad4-8a1ea87a59ab",
    "ea0a9f43-5965-4ca5-af85-f7fd95aff884",
    "63fbb05f-30c1-41c1-b70c-455c7a993b83",
})

-- Essential vendor items are drawn by category (injury kits / revive scrolls / camp supplies)
-- so that a rare category such as injury kits is not drowned out by the many scroll and
-- crafting variants in the flat ESSENTIAL_VENDOR_IDS list.
local ESSENTIAL_INJURY_IDS = makeSet({
    "Goon_OBJ_Injury_Kit_A",
    "Goon_OBJ_Injury_Kit_B",
    "I_Goon_OBJ_Injury_Kit_A",
    "I_Goon_OBJ_Injury_Kit_B",
    "70b86e8f-06b1-4eb2-8211-17f1d850086d",
    "55fb2f34-00d7-4149-8b52-e189e05ba0ca",
})

local ESSENTIAL_REVIVE_IDS = makeSet({
    "OBJ_Scroll_Revivify",
    "I_OBJ_Scroll_Revivify",
    "LOOT_SCROLL_Revivify",
    "OBJ_Scroll_Revivify_TrueResurrection",
    "I_OBJ_Scroll_Revivify_TrueResurrection",
    "01d1b2b2-9e6b-4ad2-8d63-59f9caf1d389",
    "UTAM_Scroll_OBJ_7ef78dd5-feff-4a70-9af2-43d03570d291",
    "UTAM_Scroll_OBJ_bf0f79fc-eb04-4e4f-9f0b-842c0c676c09",
    "UTAM_Scroll_OBJ_e59a2f43-3152-4b23-9288-b4dcb1ca8582",
    "UTAM_Scroll_OBJ_cbe31b42-22a8-4e26-a56f-0645d081503a",
    "UTAM_Scroll_OBJ_0be66f48-4920-4d7e-ab1d-ce8dce417d01",
    "I_UTAM_Scroll_OBJ_7ef78dd5-feff-4a70-9af2-43d03570d291",
    "I_UTAM_Scroll_OBJ_bf0f79fc-eb04-4e4f-9f0b-842c0c676c09",
    "I_UTAM_Scroll_OBJ_e59a2f43-3152-4b23-9288-b4dcb1ca8582",
    "I_UTAM_Scroll_OBJ_cbe31b42-22a8-4e26-a56f-0645d081503a",
    "I_UTAM_Scroll_OBJ_0be66f48-4920-4d7e-ab1d-ce8dce417d01",
    "7ef78dd5-feff-4a70-9af2-43d03570d291",
    "bf0f79fc-eb04-4e4f-9f0b-842c0c676c09",
    "e59a2f43-3152-4b23-9288-b4dcb1ca8582",
    "cbe31b42-22a8-4e26-a56f-0645d081503a",
    "0be66f48-4920-4d7e-ab1d-ce8dce417d01",
})

local ESSENTIAL_CATEGORY_ORDER = { "injury", "revive", "supply" }

PersistentVars = PersistentVars or {}
PersistentVars.AHRL = PersistentVars.AHRL or {}

local Session = {
    Applying = false,
    ApplyPending = false,
    PeriodicStarted = false,
    MCMSubscribed = false,
    FrozenState = nil,
    PendingTrades = {},
    TemplatePool = nil,
    ItemValueIndex = nil,
    ItemValueOverrideRules = nil,
    ItemValueOverrideRulesText = nil,
    ItemValueOverrideTextOverride = nil,
    LoadedPool = {},
    BlockedItems = {},
    MissingApi = {},
    MutationApiLogged = false,
    CurrentAct = 1,
    LoadedList = nil,
    EssentialCache = nil,
    StatTargets = nil,
    StatTargetsVersion = 0,
    VendorValueSynced = {},
}

-- MCM.Get is comparatively expensive (two pcall closures per read) and settings are read
-- tens of thousands of times per loot roll, so reads are cached and invalidated whenever
-- MCM reports a change (and on every session/level start as a safety net).
local SettingCache = {}

local function clearSettingCache(settingId)
    if settingId == nil then
        for key in pairs(SettingCache) do
            SettingCache[key] = nil
        end
    else
        SettingCache[settingId] = nil
    end
end

local function ensureVars()
    PersistentVars.AHRL = PersistentVars.AHRL or {}
    local vars = PersistentVars.AHRL
    vars.Generation = tonumber(vars.Generation) or 0
    vars.ProcessedVendors = vars.ProcessedVendors or {}
    vars.ProcessedEnemies = vars.ProcessedEnemies or {}
    vars.VendorPlusLocks = vars.VendorPlusLocks or {}
    vars.OriginalItemValues = vars.OriginalItemValues or {}
    return vars
end

local function log(fmt, ...)
    local message = tostring(fmt)
    if select("#", ...) > 0 then
        local ok, formatted = pcall(string.format, message, ...)
        if ok then
            message = formatted
        end
    end

    local text = "[" .. MOD .. "] " .. message
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

local function debugLog(fmt, ...)
    if DEFAULTS.debug_logging == true then
        log(fmt, ...)
        return
    end

    local enabled = SettingCache[SETTINGS.Debug]
    if enabled == nil and MCM ~= nil and type(MCM.Get) == "function" then
        local ok, value = pcall(function()
            return MCM.Get(SETTINGS.Debug, MOD_UUID)
        end)
        if ok and value ~= nil then
            SettingCache[SETTINGS.Debug] = value
        end
        enabled = ok and value
    end

    if enabled == true then
        log(fmt, ...)
    end
end

local function warnOnce(key, fmt, ...)
    if Session.MissingApi[key] == true then
        return
    end
    Session.MissingApi[key] = true
    log(fmt, ...)
end

local OSI_CALLS = {
    CanTrade = function(...) return Osi.CanTrade(...) end,
    CreateAtObject = function(...) return Osi.CreateAtObject(...) end,
    GenerateTreasure = function(...) return Osi.GenerateTreasure(...) end,
    GetHostCharacter = function(...) return Osi.GetHostCharacter(...) end,
    GetLevel = function(...) return Osi.GetLevel(...) end,
    GetMaxStackAmount = function(...) return Osi.GetMaxStackAmount(...) end,
    GetStatString = function(...) return Osi.GetStatString(...) end,
    GetTemplate = function(...) return Osi.GetTemplate(...) end,
    IsBoss = function(...) return Osi.IsBoss(...) end,
    IsContainer = function(...) return Osi.IsContainer(...) end,
    IsEnemy = function(...) return Osi.IsEnemy(...) end,
    IsItem = function(...) return Osi.IsItem(...) end,
    IsJunk = function(...) return Osi.IsJunk(...) end,
    IsPartyMember = function(...) return Osi.IsPartyMember(...) end,
    IsPlayer = function(...) return Osi.IsPlayer(...) end,
    IsStoryItem = function(...) return Osi.IsStoryItem(...) end,
    ItemGetGoldValue = function(...) return Osi.ItemGetGoldValue(...) end,
    Drop = function(...) return Osi.Drop(...) end,
    Equip = function(...) return Osi.Equip(...) end,
    Unequip = function(...) return Osi.Unequip(...) end,
    IsEquipped = function(...) return Osi.IsEquipped(...) end,
    GetStackAmount = function(...) return Osi.GetStackAmount(...) end,
    GetInventoryOwner = function(...) return Osi.GetInventoryOwner(...) end,
    GetFirstInventoryOwnerCharacter = function(...) return Osi.GetFirstInventoryOwnerCharacter(...) end,
    GetEquippedItem = function(...) return Osi.GetEquippedItem(...) end,
    Random = function(...) return Osi.Random(...) end,
    RequestDelete = function(...) return Osi.RequestDelete(...) end,
    SetCustomTradeTreasure = function(...) return Osi.SetCustomTradeTreasure(...) end,
    TemplateAddTo = function(...) return Osi.TemplateAddTo(...) end,
    ToInventory = function(...) return Osi.ToInventory(...) end,
}

local function getOsiCallable(name)
    if Osi == nil then
        return nil, "Osi." .. tostring(name)
    end

    local fn = OSI_CALLS[name]
    if fn ~= nil then
        return fn, "Osi." .. tostring(name)
    end

    return nil, "Osi." .. tostring(name)
end

local function logMutationApiAvailability()
    if Session.MutationApiLogged then
        return
    end

    Session.MutationApiLogged = true
    log("Mutation APIs: using direct Osi wrappers for TemplateAddTo, RequestDelete, CreateAtObject, ToInventory")
end

local function safeOsi(name, ...)
    local fn, label = getOsiCallable(name)
    if fn == nil then
        warnOnce("Osi." .. tostring(name), "%s is unavailable", label)
        return false
    end

    local ok, err = pcall(fn, ...)
    if not ok then
        debugLog("%s failed: %s", label, tostring(err))
        return false
    end

    return true
end

local function safeOsiValue(name, ...)
    local fn, label = getOsiCallable(name)
    if fn == nil then
        return nil
    end

    local ok, value = pcall(fn, ...)
    if ok then
        return value
    end

    debugLog("%s failed: %s", label, tostring(value))
    return nil
end

local function getSetting(settingId)
    local cached = SettingCache[settingId]
    if cached ~= nil then
        return cached
    end

    local fallback = DEFAULTS[settingId]

    if MCM ~= nil and type(MCM.Get) == "function" then
        local ok, value = pcall(function()
            return MCM.Get(settingId, MOD_UUID)
        end)
        if ok and value ~= nil then
            SettingCache[settingId] = value
            return value
        end

        ok, value = pcall(function()
            return MCM.Get(settingId)
        end)
        if ok and value ~= nil then
            SettingCache[settingId] = value
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
                SettingCache[settingId] = value
                return value
            end
        end
    end

    -- Fallback defaults are deliberately not cached: MCM may simply not be ready yet.
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

local function rawIndex(object, field)
    return object[field]
end

local function safeStatField(stat, field)
    if stat == nil then
        return nil
    end

    local ok, value = pcall(rawIndex, stat, field)
    if ok then
        return value
    end
    return nil
end

local function getStatsData(stats)
    if stats == nil or tostring(stats) == "" then
        return nil
    end

    if Ext == nil or Ext.Stats == nil or type(Ext.Stats.Get) ~= "function" then
        return nil
    end

    local ok, stat = pcall(Ext.Stats.Get, tostring(stats))
    if ok then
        return stat
    end
    return nil
end

local function getStatsNumber(stat, fields)
    for _, field in ipairs(fields) do
        local value = tonumber(safeStatField(stat, field))
        if value ~= nil then
            return value
        end
    end
    return nil
end

local function getTranslatedTemplateName(template, fallback)
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
        local ok, translated = pcall(Ext.Loca.GetTranslatedString, tostring(handle))
        if ok and type(translated) == "string" and translated ~= "" then
            return translated
        end
    end

    return fallback
end

local function normalizePath(value)
    return tostring(value or ""):gsub("\\", "/")
end

local function isVanillaFile(fileName)
    local path = normalizePath(fileName)
    if path == "" then
        return false
    end

    for _, segment in ipairs(VANILLA_FILE_SEGMENTS) do
        if path:find(segment, 1, true) ~= nil then
            return true
        end
    end
    return false
end

local function isModdedFromMetadata(modId, fileName)
    local modText = string.lower(tostring(modId or ""))
    if modText ~= "" and VANILLA_MOD_IDS[modText] == true then
        return false
    end

    if isVanillaFile(fileName) then
        return false
    end

    if modText ~= "" then
        return true
    end

    local fileText = tostring(fileName or "")
    return fileText ~= ""
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
        else
            return "Legendary"
        end
    end

    local text = string.lower(tostring(value)):gsub("%s+", ""):gsub("_", "")
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

local function getRarityWeight(rarity)
    if not settingBool(SETTINGS.RarityWeightsEnabled) then
        return 100
    end

    local act = Session.CurrentAct or 1
    local settingsForRarity = RARITY_WEIGHT_SETTINGS[normalizeRarity(rarity)]
    if settingsForRarity == nil then
        return 100
    end

    local settingId = settingsForRarity[act]
    if settingId == nil then
        return 100
    end

    return settingInt(settingId, 0, 100)
end

local function getModdedRarityValue(rarity)
    local key = normalizeRarity(rarity)
    local setting = RARITY_VALUE_SETTINGS[key] or SETTINGS.ModdedCommonValue
    return settingInt(setting, 0, 1000000)
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

local function parseItemValueOverrideText(text)
    local rules = {}
    local source = tostring(text or "")

    for rawLine in source:gmatch("[^\r\n;]+") do
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
                    rules[key] = {
                        Mode = "lock",
                    }
                else
                    local value = tonumber(rawValue)
                    if value ~= nil then
                        rules[key] = {
                            Mode = "value",
                            Value = math.max(0, math.floor(value)),
                        }
                    end
                end
            end
        end
    end

    return rules
end

local function getItemValueOverrideRules()
    local text = Session.ItemValueOverrideTextOverride
    if text == nil then
        text = tostring(getSetting(SETTINGS.ItemValueOverrides) or "")
    end

    if Session.ItemValueOverrideRules ~= nil and Session.ItemValueOverrideRulesText == text then
        return Session.ItemValueOverrideRules
    end

    Session.ItemValueOverrideRulesText = text
    Session.ItemValueOverrideRules = parseItemValueOverrideText(text)
    return Session.ItemValueOverrideRules
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
    if Session.ModValueFilterCache ~= nil then
        return Session.ModValueFilterCache
    end

    Session.ModValueFilterCache = {
        IncludeOnly = settingBool(SETTINGS.ModdedValueIncludeOnly),
        Entries = parseModIdList(getSetting(SETTINGS.ModdedValueModList)),
    }
    return Session.ModValueFilterCache
end

local function getLootModFilterConfig()
    if Session.LootModFilterCache ~= nil then
        return Session.LootModFilterCache
    end

    local mode = tostring(getSetting(SETTINGS.LootModFilterMode) or "Exclude")
    Session.LootModFilterCache = {
        Enabled = settingBool(SETTINGS.LootModFilterEnabled),
        Mode = mode,
        Entries = parseModIdList(getSetting(SETTINGS.LootModFilterList)),
    }
    return Session.LootModFilterCache
end

-- Forward declaration: the real definition lives further down, and without this the call
-- below resolved to a nil global and threw whenever the loot mod filter had entries.
local modMatchesValueFilterList

local function entryPassesLootModFilter(entry)
    if entry == nil then
        return true
    end

    local filter = getLootModFilterConfig()
    if not filter.Enabled then
        return true
    end

    local mode = filter.Mode

    if mode == "Vanilla Only" then
        return entry.IsModded ~= true
    end

    local entries = filter.Entries
    if #entries == 0 then
        if mode == "Exclude" then
            return true
        end
        if mode == "Include Only" then
            return false
        end
    end

    local matches = modMatchesValueFilterList(entry.ModId, entry.FileName, entries)

    if mode == "Exclude" then
        return not matches
    end

    if mode == "Include Only" then
        return matches
    end

    return true
end

local function getExcludedItemsConfig()
    if Session.ExcludedItemsCache ~= nil then
        return Session.ExcludedItemsCache
    end

    local entries = {}
    local text = tostring(getSetting(SETTINGS.ExcludedItems) or "")
    for rawLine in text:gmatch("[^\r\n;]+") do
        local line = trimText(rawLine)
        if line ~= "" and line:sub(1, 1) ~= "#" then
            local key, rawValue = line:match("^([^=:]+)%s*[=:]%s*(.-)%s*$")
            if key == nil then
                key, rawValue = line:match("^(%S+)%s+(%S+)%s*$")
            end

            if key ~= nil then
                local normalKey = string.lower(trimText(key))
                local mode = string.lower(trimText(rawValue or "both"))
                if mode == "vendor" or mode == "enemy" or mode == "both" or mode == "1" or mode == "true" then
                    if mode == "1" or mode == "true" then
                        mode = "both"
                    end
                    entries[normalKey] = mode
                end
            end
        end
    end

    Session.ExcludedItemsCache = entries
    return entries
end

local function entryExcludedByUser(entry, options)
    if entry == nil then
        return false
    end

    local excluded = getExcludedItemsConfig()
    local statKey = normalizeRuleKey(entry.StatName)
    local templateKey = normalizeRuleKey(entry.Template)
    local mode = excluded[statKey] or excluded[templateKey]

    if mode == nil then
        return false
    end

    if mode == "both" then
        return true
    end

    if mode == "vendor" and options ~= nil and options.IsVendor == true then
        return true
    end

    if mode == "enemy" and options ~= nil and options.IsEnemy == true then
        return true
    end

    return false
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

function modMatchesValueFilterList(modId, fileName, entries)
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

local function effectiveGoldValue(entry)
    local value = tonumber(entry.GoldValue) or 0
    local known = entry.ValueKnown == true

    local override = findItemValueOverrideRule(entry)
    if override ~= nil then
        if override.Mode == "lock" then
            return value, known
        elseif override.Mode == "value" then
            return tonumber(override.Value) or 0, true
        end
    end

    if moddedValueCorrectionAppliesTo(entry) then
        local threshold = settingInt(SETTINGS.ModdedValueThreshold, 0, 1000000)
        if not known or value < threshold then
            local corrected = getModdedRarityValue(entry.Rarity)
            if corrected > value then
                return corrected, true
            end
            return corrected, corrected > 0
        end
    end

    return value, known
end

local function settingsEnabled()
    return settingBool(SETTINGS.Enabled)
end

local function heavyGlobalScansEnabled()
    return settingBool(SETTINGS.HeavyGlobalScans)
end

local function randomizationFrozen()
    return settingBool(SETTINGS.FreezeRandomization)
end

local function applyNewWhileFrozen()
    return settingBool(SETTINGS.ApplyNewWhileFrozen)
end

local function settingChangeAffectsLoot(settingId)
    if settingId == nil then
        return true
    end

    return settingId ~= SETTINGS.ApplyOnLoad
        and settingId ~= SETTINGS.HeavyGlobalScans
        and settingId ~= SETTINGS.FreezeRandomization
        and settingId ~= SETTINGS.ApplyNewWhileFrozen
        and settingId ~= SETTINGS.PeriodicScan
        and settingId ~= SETTINGS.Debug
end

local function normalizeApplyForce(force)
    if not randomizationFrozen() then
        return force == true
    end

    if applyNewWhileFrozen() then
        return false
    end

    return nil
end

local function normalizeGuid(value)
    if value == nil then
        return nil
    end

    local text = tostring(value):lower()
    return text:match("(%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x)") or text
end

local function getEntity(object)
    if object == nil then
        return nil
    end

    if type(object) == "table" or type(object) == "userdata" then
        local isEntity = false
        pcall(function()
            isEntity = object.Uuid ~= nil or object.ServerCharacter ~= nil or object.ServerItem ~= nil
        end)
        if isEntity then
            return object
        end
    end

    if Ext == nil or Ext.Entity == nil or type(Ext.Entity.Get) ~= "function" then
        return nil
    end

    local ok, entity = pcall(Ext.Entity.Get, object)
    if ok then
        return entity
    end

    return nil
end

local function getEntityUuid(entityOrGuid)
    if entityOrGuid == nil then
        return nil
    end

    if type(entityOrGuid) == "string" then
        return normalizeGuid(entityOrGuid)
    end

    local uuid = nil
    pcall(function()
        uuid = entityOrGuid.Uuid.EntityUuid
    end)

    return normalizeGuid(uuid)
end

local function getObjectUuid(object)
    return getEntityUuid(getEntity(object)) or normalizeGuid(object)
end

local function getHost()
    return safeOsiValue("GetHostCharacter")
end

local function getLevel(object)
    local level = tonumber(safeOsiValue("GetLevel", object)) or 1
    if level < 1 then
        level = 1
    end
    return math.floor(level)
end

local function isPartyMember(character)
    return safeOsiValue("IsPartyMember", character, 1) == 1
        or safeOsiValue("IsPlayer", character) == 1
end

local function isBoss(character)
    if safeOsiValue("IsBoss", character) == 1 then
        return true
    end

    local entity = getEntity(character)
    local value = false
    pcall(function()
        value = entity.ServerCharacter.Template.IsBoss == true
    end)
    return value
end

local function canTrade(character)
    if safeOsiValue("CanTrade", character) == 1 then
        return true
    end

    local entity = getEntity(character)
    local value = false
    pcall(function()
        value = entity.Trader ~= nil or entity.CanTrade ~= nil
    end)
    return value
end

local function isEnemy(character)
    if isPartyMember(character) or canTrade(character) then
        return false
    end

    if settingBool(SETTINGS.ProtectBosses) and isBoss(character) then
        return false
    end

    local host = getHost()
    if host ~= nil and tostring(host) ~= "" then
        if safeOsiValue("IsEnemy", character, host) == 1 or safeOsiValue("IsEnemy", host, character) == 1 then
            return true
        end
    end

    return settingBool(SETTINGS.EnemyIncludeNeutral)
end

local function isItem(object)
    if safeOsiValue("IsItem", object) == 1 then
        return true
    end

    local entity = getEntity(object)
    return entity ~= nil and entity.ServerItem ~= nil
end

local function isContainer(object)
    local value = safeOsiValue("IsContainer", object)
    if value ~= nil then
        return value == 1
    end

    local entity = getEntity(object)
    return entity ~= nil and entity.InventoryOwner ~= nil and entity.ServerItem ~= nil
end

local function isStoryItem(item)
    if not settingBool(SETTINGS.ProtectStory) then
        return false
    end

    local value = safeOsiValue("IsStoryItem", item)
    if value ~= nil then
        return value == 1
    end

    local entity = getEntity(item)
    local story = false
    pcall(function()
        story = entity.IsStoryItem == true
            or entity.ServerItem.StoryItem == true
            or entity.ServerItem.Template.StoryItem == true
    end)
    return story
end

local function isJunk(item)
    return safeOsiValue("IsJunk", item) == 1
end

local function getGoldValue(item)
    return tonumber(safeOsiValue("ItemGetGoldValue", item)) or 0
end

local function getMaxStack(item)
    local value = tonumber(safeOsiValue("GetMaxStackAmount", item)) or 1
    if value < 1 then
        value = 1
    end
    return value
end

local function getStatString(item)
    local stat = safeOsiValue("GetStatString", item)
    if stat ~= nil and tostring(stat) ~= "" then
        return tostring(stat)
    end

    local entity = getEntity(item)
    local value = nil
    pcall(function()
        value = entity.ServerItem.Template.Stats
    end)
    if value == nil or tostring(value) == "" then
        pcall(function()
            value = entity.Stats.Name
        end)
    end

    if value ~= nil and tostring(value) ~= "" then
        return tostring(value)
    end
    return nil
end

local function getTemplate(item)
    local template = safeOsiValue("GetTemplate", item)
    if template ~= nil and tostring(template) ~= "" then
        return tostring(template)
    end

    local entity = getEntity(item)
    local id = nil
    pcall(function()
        id = entity.ServerItem.Template.Id
    end)
    if id ~= nil and tostring(id) ~= "" then
        return tostring(id)
    end

    return nil
end

local function containsUnsafePattern(template, stats, name)
    if not settingBool(SETTINGS.ProtectStory) then
        return false
    end

    local haystack = string.lower(tostring(template or "") .. " " .. tostring(stats or "") .. " " .. tostring(name or ""))
    for _, pattern in ipairs(UNSAFE_TEMPLATE_PATTERNS) do
        if haystack:find(pattern, 1, true) ~= nil then
            return true
        end
    end

    return false
end

local function truthy(value)
    if value == true or value == 1 then
        return true
    end

    local text = string.lower(tostring(value or ""))
    return text == "true" or text == "1" or text == "yes"
end

local function containsUnsafeMetadata(value)
    local text = string.lower(tostring(value or ""))
    return text:find("story", 1, true) ~= nil
        or text:find("quest", 1, true) ~= nil
        or text:find("plot", 1, true) ~= nil
end

local function templateIsStoryProtected(template)
    if not settingBool(SETTINGS.ProtectStory) or template == nil then
        return false
    end

    local protected = false
    pcall(function()
        protected = truthy(template.StoryItem)
            or truthy(template.IsStoryItem)
            or truthy(template.QuestItem)
            or truthy(template.IsQuestItem)
            or truthy(template.PlotItem)
            or truthy(template.IsPlotItem)
            or containsUnsafeMetadata(template.Flags)
            or containsUnsafeMetadata(template.TemplateFlags)
            or containsUnsafeMetadata(template.Tags)
    end)

    return protected
end

local function isEssentialVendorItem(template, stats, name)
    return ESSENTIAL_VENDOR_IDS[string.lower(tostring(template or ""))] == true
        or ESSENTIAL_VENDOR_IDS[string.lower(tostring(stats or ""))] == true
        or ESSENTIAL_VENDOR_IDS[string.lower(tostring(name or ""))] == true
end

local function isGoldEntry(entry)
    local template = string.lower(tostring(entry.Template or ""))
    local stats = tostring(entry.Stats or "")
    return stats == "OBJ_GoldPile"
        or template:find("loot_gold", 1, true) ~= nil
        or template:find(GOLD_TEMPLATE_GUID, 1, true) ~= nil
end

-- ==================== BROKEN ITEM FILTER ====================
-- Keeps items out of the loot pool only when they are confirmed broken in-game:
--   * the name does not resolve (shows "Not Found" or nothing),
--   * the visual it uses does not exist (the game draws a placeholder mesh, e.g. a sword that looks like shackles),
--   * using it casts or teaches a spell that does not exist (VBT's "Scroll of Dying Star's Breath" casts
--     VBT_Spell_3_BreathOfHadar, which no pak defines - carrying it crashed the game on every dice-roll screen).
-- A missing stat entry on its own is NOT a reason: such items (e.g. an elixir whose stat entry was renamed) can work.
-- Each check first runs on a sample of base-game items; a check that flags more than a quarter of them is not
-- working in this game/SE version and is switched off for the session, so it can never empty the loot pool.
-- Everything skipped is listed in Script Extender/A_Humans_Random_Loot/skipped_broken_items.txt with the reason.
local BROKEN_REPORT_FILE = "A_Humans_Random_Loot/skipped_broken_items.txt"
local BROKEN_SAMPLE_SIZE = 400
local BROKEN_MAX_SHARE = 0.25
local NULL_GUID = "00000000-0000-0000-0000-000000000000"
local Broken = { Cache = {}, Disabled = {}, SelfTested = false, Report = {}, Header = nil }

local function guidPart(value)
    local text = tostring(value or "")
    return text:match("(%x+%-%x+%-%x+%-%x+%-%x+)$") or text
end

local function lookupTemplate(id)
    local guid = guidPart(id)
    if guid == "" or guid == NULL_GUID or Ext == nil or Ext.Template == nil then
        return nil
    end
    for _, fn in ipairs({ "GetRootTemplate", "GetTemplate" }) do
        if type(Ext.Template[fn]) == "function" then
            local ok, template = pcall(Ext.Template[fn], guid)
            if ok and template ~= nil then
                return template
            end
        end
    end
    return nil
end

-- calls fn on the template, then its parents, until fn returns something
local function fromTemplateChain(template, fn)
    local seen = {}
    for _ = 1, 8 do
        if template == nil then
            return nil
        end
        local result = fn(template)
        if result ~= nil then
            return result
        end
        local id = guidPart(safeStatField(template, "Id"))
        if id ~= "" then
            seen[id] = true
        end
        local parent = guidPart(safeStatField(template, "ParentTemplateId"))
        if parent == "" or parent == NULL_GUID or seen[parent] then
            return nil
        end
        template = lookupTemplate(parent)
    end
    return nil
end

local function emptyHandle(handle)
    local text = tostring(handle or "")
    return text == "" or text == "nil" or text:find("HandleUnknown", 1, true) ~= nil
end

local function nameProblem(template)
    if Ext == nil or Ext.Loca == nil or type(Ext.Loca.GetTranslatedString) ~= "function" then
        return nil
    end
    local verdict = fromTemplateChain(template, function(t)
        local handle = nil
        pcall(function() handle = t.DisplayName.Handle.Handle end)
        if type(handle) ~= "string" then
            pcall(function() handle = t.DisplayName.Handle end)
        end
        if type(handle) ~= "string" then
            pcall(function() handle = t.DisplayName end)
        end
        if type(handle) ~= "string" or emptyHandle(handle) then
            return nil   -- no name here: the parent template supplies it
        end
        local ok, text = pcall(Ext.Loca.GetTranslatedString, handle)
        if not ok or type(text) ~= "string" or text == "" or text == handle then
            return "its name (" .. handle .. ") has no text, so it shows as Not Found"
        end
        if string.lower(text):find("not found", 1, true) ~= nil then
            return "its name shows \"" .. text .. "\""
        end
        return false
    end)
    -- no name handle anywhere in the chain is not treated as broken: only a name that points at missing text is
    return verdict or nil
end

local function visualProblem(template)
    if Ext == nil or Ext.Resource == nil or type(Ext.Resource.Get) ~= "function" then
        return nil
    end
    local verdict = fromTemplateChain(template, function(t)
        local visual = guidPart(safeStatField(t, "VisualTemplate"))
        if visual == "" or visual == "nil" or visual == NULL_GUID then
            return nil   -- the parent template supplies the visual
        end
        local ok, resource = pcall(Ext.Resource.Get, visual, "Visual")
        if ok and resource ~= nil then
            return false
        end
        return "its visual " .. visual .. " does not exist, so the game draws a placeholder model"
    end)
    -- no visual anywhere in the chain is not treated as broken: only a visual that points at nothing is
    return verdict or nil
end

local SPELL_ACTION_LISTS = { "OnUsePeaceActions", "OnUseActions" }
local SPELL_ACTION_FIELDS = { "SpellId", "SkillID", "Spell" }
local function spellProblem(template)
    local missing = fromTemplateChain(template, function(t)
        local spells = {}
        for _, listName in ipairs(SPELL_ACTION_LISTS) do
            local actions = safeStatField(t, listName)
            if type(actions) == "table" or type(actions) == "userdata" then
                pcall(function()
                    for _, action in pairs(actions) do
                        for _, field in ipairs(SPELL_ACTION_FIELDS) do
                            local value = safeStatField(action, field)
                            if type(value) == "string" and value ~= "" then
                                spells[#spells + 1] = value
                            end
                        end
                    end
                end)
            end
        end
        if #spells == 0 then
            return nil   -- no use actions here: the parent template's apply
        end
        local gone, seen = {}, {}
        for _, spell in ipairs(spells) do
            if not seen[spell] then
                seen[spell] = true
                if getStatsData(spell) == nil then
                    gone[#gone + 1] = spell
                end
            end
        end
        return gone
    end)
    if missing == nil or #missing == 0 then
        return nil
    end
    return "using it casts " .. table.concat(missing, ", ") .. ", which does not exist (this crashed the dice-roll screen)"
end

local BROKEN_CHECKS = {
    { Key = "name", Fn = nameProblem },
    { Key = "visual", Fn = visualProblem },
    { Key = "spell", Fn = spellProblem },
}

local function runBrokenChecks(template)
    local reasons = {}
    for _, check in ipairs(BROKEN_CHECKS) do
        if not Broken.Disabled[check.Key] then
            local ok, problem = pcall(check.Fn, template)
            if ok and type(problem) == "string" then
                reasons[#reasons + 1] = problem
            end
        end
    end
    return reasons
end

local function brokenSelfTest()
    if Broken.SelfTested then
        return
    end
    Broken.SelfTested = true
    if Ext == nil or Ext.Template == nil or type(Ext.Template.GetAllRootTemplates) ~= "function" then
        return
    end
    local ok, templates = pcall(Ext.Template.GetAllRootTemplates)
    if not ok or templates == nil then
        return
    end
    local sampled, flagged = 0, {}
    for _, template in pairs(templates) do
        if sampled >= BROKEN_SAMPLE_SIZE then
            break
        end
        local isItemTemplate = string.lower(tostring(safeStatField(template, "TemplateType") or "")) == "item"
        local stats = tostring(safeStatField(template, "Stats") or "")
        if isItemTemplate and stats ~= "" and isVanillaFile(safeStatField(template, "FileName")) then
            sampled = sampled + 1
            for _, check in ipairs(BROKEN_CHECKS) do
                local okCheck, problem = pcall(check.Fn, template)
                if okCheck and type(problem) == "string" then
                    flagged[check.Key] = (flagged[check.Key] or 0) + 1
                end
            end
        end
    end
    local notes = {}
    for _, check in ipairs(BROKEN_CHECKS) do
        local count = flagged[check.Key] or 0
        if sampled >= 20 and count > sampled * BROKEN_MAX_SHARE then
            Broken.Disabled[check.Key] = true
            notes[#notes + 1] = string.format("The %s check flagged %d of %d base-game items, so it does not work in this game version and is switched off.", check.Key, count, sampled)
            log("Broken item filter: %s check switched off (flagged %d of %d base-game items)", check.Key, count, sampled)
        else
            notes[#notes + 1] = string.format("The %s check is on (flagged %d of %d base-game items).", check.Key, count, sampled)
        end
    end
    if sampled < 20 then
        notes[#notes + 1] = "Only " .. sampled .. " base-game items could be sampled, so the checks could not be verified; they stay on."
    end
    Broken.Header = notes
end

local function writeBrokenReport()
    local lines = {
        "A HUMAN'S RANDOM LOOT - ITEMS KEPT OUT OF THE LOOT POOL BECAUSE THEY ARE BROKEN (this session)",
        "Turn this off in MCM: \"Skip Broken Items\". A missing stat entry alone never puts an item here.",
        "",
    }
    for _, note in ipairs(Broken.Header or {}) do
        lines[#lines + 1] = note
    end
    lines[#lines + 1] = ""
    for index, item in ipairs(Broken.Report) do
        lines[#lines + 1] = string.format("%3d. %s   (stats: %s, template: %s, from: %s)", index, item.Name, item.Stats, item.Template, item.Source)
        for _, reason in ipairs(item.Reasons) do
            lines[#lines + 1] = "       - " .. reason
        end
    end
    if Ext ~= nil and Ext.IO ~= nil and type(Ext.IO.SaveFile) == "function" then
        pcall(Ext.IO.SaveFile, BROKEN_REPORT_FILE, table.concat(lines, "\n"))
    end
end

local function entryIsBroken(entry)
    if not settingBool(SETTINGS.SkipBrokenItems) then
        return false
    end
    local key = guidPart(entry.Template)
    if key == "" then
        return false
    end
    local cached = Broken.Cache[key]
    if cached ~= nil then
        return cached
    end
    brokenSelfTest()
    local template = lookupTemplate(entry.Template)
    if template == nil then
        Broken.Cache[key] = false   -- cannot be checked, so it is not confirmed broken
        return false
    end
    local reasons = runBrokenChecks(template)
    local broken = #reasons > 0
    Broken.Cache[key] = broken
    if broken then
        Broken.Report[#Broken.Report + 1] = {
            Name = tostring(entry.DisplayName or entry.Name or entry.Stats or key),
            Stats = tostring(entry.Stats or "?"),
            Template = key,
            Source = tostring(entry.FileName or entry.ModId or "?"),
            Reasons = reasons,
        }
        debugLog("Broken item kept out of the loot pool: %s (%s)", tostring(entry.Stats), table.concat(reasons, "; "))
        writeBrokenReport()
    end
    return broken
end

local function entryAllowed(entry, options)
    if entry == nil or entry.Template == nil or entry.Template == "" then
        return false
    end

    if Session.BlockedItems[entry.Template] == true or Session.BlockedItems[entry.Guid] == true then
        return false
    end

    if entryExcludedByUser(entry, options) then
        return false
    end

    -- PoolSafe entries already passed these settings-gated checks when the template
    -- pool was last (re)built, and that rebuild is triggered whenever a setting they
    -- depend on (ProtectStory, loot mod filter, etc.) changes. Skipping the recheck
    -- here avoids redoing an ~44-pattern string scan per entry on every single loot
    -- event (enemy death / vendor visit). LoadedPool entries never get this flag, so
    -- they keep the fully live check every call.
    if entry.PoolSafe ~= true then
        if isGoldEntry(entry) then
            return false
        end

        if not entryPassesLootModFilter(entry) then
            return false
        end

        if settingBool(SETTINGS.ProtectStory) and entry.IsStory == true then
            return false
        end

        if containsUnsafePattern(entry.Template, entry.Stats, entry.Name) then
            return false
        end
    end

    -- cached per template, so only the first draw of each item pays for the check
    if entryIsBroken(entry) then
        return false
    end

    if not settingBool(SETTINGS.IncludeJunk) and entry.IsJunk == true then
        return false
    end

    if options ~= nil and options.FilterJunk == true and entry.IsJunk == true then
        return false
    end

    if options ~= nil and options.MaxValue ~= nil and settingBool(SETTINGS.MaxValuePerLevel) then
        local value, known = effectiveGoldValue(entry)
        if known == true and value > options.MaxValue then
            return false
        end

        if known ~= true and not settingBool(SETTINGS.AllowUnknownValue) then
            return false
        end
    end

    return true
end

local function randomInt(minimum, maximum)
    minimum = math.floor(tonumber(minimum) or 0)
    maximum = math.floor(tonumber(maximum) or minimum)
    if maximum < minimum then
        maximum = minimum
    end

    if Ext ~= nil and Ext.Math ~= nil and type(Ext.Math.Random) == "function" then
        local ok, value = pcall(Ext.Math.Random, minimum, maximum)
        if ok and tonumber(value) ~= nil then
            return math.floor(tonumber(value))
        end
    end

    local span = maximum - minimum + 1
    local value = tonumber(safeOsiValue("Random", span))
    if value ~= nil then
        return minimum + math.floor(value)
    end

    return math.random(minimum, maximum)
end

local function getInventoryContainers(owner, primaryOnly)
    local ownerEntity = getEntity(owner)
    if ownerEntity == nil or ownerEntity.InventoryOwner == nil then
        return {}
    end

    local containers = {}
    local seen = {}

    local function add(container)
        local entity = getEntity(container)
        if entity == nil or entity.InventoryContainer == nil then
            return
        end

        local key = getEntityUuid(entity) or tostring(entity)
        if seen[key] then
            return
        end

        seen[key] = true
        containers[#containers + 1] = entity
    end

    pcall(function()
        add(ownerEntity.InventoryOwner.PrimaryInventory)
    end)

    if not primaryOnly then
        pcall(function()
            for _, inventory in pairs(ownerEntity.InventoryOwner.Inventories or {}) do
                add(inventory)
            end
        end)
    end

    return containers
end

local function collectInventoryItems(owner, options, items, visited)
    options = options or {}
    items = items or {}
    visited = visited or {}

    local ownerKey = getObjectUuid(owner)
    if ownerKey ~= nil and visited[ownerKey] then
        return items
    end
    if ownerKey ~= nil then
        visited[ownerKey] = true
    end

    for _, container in ipairs(getInventoryContainers(owner, options.PrimaryOnly == true)) do
        local entries = container.InventoryContainer.Items
        if entries ~= nil then
            for _, slot in pairs(entries) do
                local itemEntity = getEntity(slot.Item) or slot.Item
                local itemGuid = getEntityUuid(itemEntity)
                if itemGuid ~= nil then
                    items[#items + 1] = {
                        Guid = itemGuid,
                        Entity = itemEntity,
                    }

                    if options.Recursive ~= false and isContainer(itemGuid) then
                        collectInventoryItems(itemGuid, options, items, visited)
                    end
                end
            end
        end
    end

    return items
end

local EQUIPMENT_SLOT_NAMES = {
    "Helmet",
    "Breast",
    "Cloak",
    "MeleeMainHand",
    "MeleeOffHand",
    "RangedMainHand",
    "RangedOffHand",
    "Ring",
    "Underwear",
    "Boots",
    "Gloves",
    "Amulet",
    "Ring2",
    "Wings",
    "Horns",
    "Overhead",
    "MusicalInstrument",
    "VanityBody",
    "VanityBoots",
}

local function collectEquippedItems(owner, items, seen)
    items = items or {}
    seen = seen or {}

    for _, slotName in ipairs(EQUIPMENT_SLOT_NAMES) do
        local item = safeOsiValue("GetEquippedItem", owner, slotName)
        local itemGuid = getObjectUuid(item)
        if itemGuid ~= nil and not seen[itemGuid] then
            seen[itemGuid] = true
            items[#items + 1] = {
                Guid = itemGuid,
                Entity = getEntity(item) or item,
            }
        end
    end

    return items
end

local function trackItem(item, source)
    if item == nil or not isItem(item) or isStoryItem(item) then
        return nil
    end

    local key = getObjectUuid(item)
    local template = getTemplate(item)
    local stats = getStatString(item)
    if key == nil or template == nil or template == "" then
        return nil
    end

    if containsUnsafePattern(template, stats, nil) then
        return nil
    end

    local entity = getEntity(item)
    local fileName = nil
    pcall(function()
        fileName = entity.ServerItem.Template.FileName
    end)

    local stat = getStatsData(stats)
    if stat ~= nil then
        -- Spell-like stats have no Value/ValueOverride/Rarity; reading them only spams the
        -- engine log ("Stat object 'X' has no attribute named 'Value'") and they are not loot.
        local modifierList = tostring(safeStatField(stat, "ModifierList") or "")
        if modifierList ~= "Armor" and modifierList ~= "Weapon" and modifierList ~= "Object" then
            return nil
        end
    end
    local statValue = getStatsNumber(stat, { "ValueOverride", "Value" })
    local modId = safeStatField(stat, "ModId") or safeStatField(stat, "OriginalModId")
    local goldValue = getGoldValue(item)
    if (goldValue == nil or goldValue <= 0) and statValue ~= nil then
        goldValue = statValue
    end

    local entry = {
        Guid = key,
        Template = template,
        Stats = stats,
        Name = stats,
        DisplayName = stats,
        Icon = nil,
        GoldValue = tonumber(goldValue) or 0,
        ValueKnown = true,
        Rarity = normalizeRarity(safeStatField(stat, "Rarity")),
        ModId = modId,
        FileName = fileName,
        IsModded = isModdedFromMetadata(modId, fileName),
        MaxStack = getMaxStack(item),
        IsJunk = isJunk(item),
        IsStory = false,
        Source = source or "loaded",
    }

    if entryAllowed(entry, nil) then
        Session.LoadedPool[key] = entry
        Session.LoadedList = nil
        return entry
    end

    return nil
end

local function trackInventory(owner, options)
    for _, item in ipairs(collectInventoryItems(owner, options or { Recursive = true })) do
        trackItem(item.Guid, "inventory")
    end
end

local function buildTemplatePool()
    if Session.TemplatePool ~= nil then
        return Session.TemplatePool
    end

    Session.TemplatePool = {}
    if Ext == nil or Ext.Template == nil or type(Ext.Template.GetAllRootTemplates) ~= "function" then
        return Session.TemplatePool
    end

    local ok, templates = pcall(Ext.Template.GetAllRootTemplates)
    if not ok or templates == nil then
        return Session.TemplatePool
    end

    for _, template in pairs(templates) do
        local templateType = nil
        local id = nil
        local stats = nil
        local name = nil
        local displayName = nil
        local icon = nil
        local fileName = nil
        local isStory = false
        pcall(function()
            templateType = template.TemplateType
            id = template.Id
            stats = template.Stats
            name = template.Name or template.TemplateName
            displayName = getTranslatedTemplateName(template, name or stats)
            icon = template.Icon
            fileName = template.FileName
            isStory = templateIsStoryProtected(template)
        end)

        local idText = id ~= nil and tostring(id) or nil
        local statsText = stats ~= nil and tostring(stats) or nil
        local typeText = templateType ~= nil and string.lower(tostring(templateType)) or ""
        if idText ~= nil and idText ~= "" and statsText ~= nil and statsText ~= ""
            and (typeText == "" or typeText == "item")
        then
            local stat = getStatsData(statsText)
            local statValue = getStatsNumber(stat, { "ValueOverride", "Value" })
            local modId = safeStatField(stat, "ModId") or safeStatField(stat, "OriginalModId")
            local entry = {
                Guid = nil,
                Template = idText,
                Stats = statsText,
                Name = name ~= nil and tostring(name) or statsText,
                DisplayName = displayName ~= nil and tostring(displayName) or statsText,
                Icon = icon ~= nil and tostring(icon) or nil,
                GoldValue = tonumber(statValue) or 0,
                ValueKnown = statValue ~= nil,
                Rarity = normalizeRarity(safeStatField(stat, "Rarity")),
                ModId = modId,
                FileName = fileName,
                IsModded = isModdedFromMetadata(modId, fileName),
                MaxStack = 1,
                IsJunk = false,
                IsStory = isStory,
                Source = "template",
            }

            if entryAllowed(entry, nil) then
                entry.PoolSafe = true
                Session.TemplatePool[#Session.TemplatePool + 1] = entry
            end
        end
    end

    debugLog("Template pool contains %d entries", #Session.TemplatePool)
    return Session.TemplatePool
end

local function getAllEntitiesWith(component)
    if Ext == nil or Ext.Entity == nil or type(Ext.Entity.GetAllEntitiesWithComponent) ~= "function" then
        return {}
    end

    local ok, entities = pcall(Ext.Entity.GetAllEntitiesWithComponent, component)
    if ok and entities ~= nil then
        return entities
    end

    return {}
end

local function collectPartyMemberGuids()
    local members = {}
    local seen = {}

    local function add(character)
        local uuid = getObjectUuid(character)
        if uuid ~= nil and seen[uuid] ~= true then
            seen[uuid] = true
            members[#members + 1] = uuid
        end
    end

    add(getHost())

    for _, character in ipairs(getAllEntitiesWith("ServerCharacter")) do
        local uuid = getEntityUuid(character)
        if uuid ~= nil and isPartyMember(uuid) then
            add(uuid)
        end
    end

    return members
end

local function collectPartyInventoryItems()
    local items = {}
    local seen = {}

    for _, member in ipairs(collectPartyMemberGuids()) do
        collectInventoryItems(member, { PrimaryOnly = false, Recursive = true }, items, seen)
        collectEquippedItems(member, items, seen)
    end

    return items
end

local function refreshLoadedPool()
    Session.LoadedPool = {}
    Session.LoadedList = nil

    for _, character in ipairs(getAllEntitiesWith("ServerCharacter")) do
        local uuid = getEntityUuid(character)
        if uuid ~= nil then
            trackInventory(uuid, { PrimaryOnly = false, Recursive = true })
        end
    end

    for _, item in ipairs(getAllEntitiesWith("ServerItem")) do
        trackItem(item, "loaded-item")
    end
end

local function getLoadedList()
    if Session.LoadedList == nil then
        local list = {}
        for _, entry in pairs(Session.LoadedPool) do
            list[#list + 1] = entry
        end
        Session.LoadedList = list
    end
    return Session.LoadedList
end

local SAMPLE_TRIES = 80

-- Picks one allowed entry by random sampling instead of filtering the whole ~11k pool first.
-- The old approach ran entryAllowed over every template on every enemy death / vendor visit
-- (0.6-4.8 s hitches in the log). Sampling only checks the handful of entries it draws.
-- Returns nil when sampling finds nothing, so callers can fall back to the exhaustive scan.
local function sampleLootEntry(options)
    local templates = buildTemplatePool()
    local loaded = getLoadedList()
    local loadedCount = #loaded
    local total = loadedCount + #templates
    if total == 0 then
        return nil
    end

    local weighted = settingBool(SETTINGS.RarityWeightsEnabled)
    local fallback = nil
    for _ = 1, SAMPLE_TRIES do
        local index = randomInt(1, total)
        local entry
        if index <= loadedCount then
            entry = loaded[index]
        else
            entry = templates[index - loadedCount]
        end

        if entry ~= nil and entryAllowed(entry, options) then
            if not weighted then
                return entry
            end

            fallback = fallback or entry
            local weight = getRarityWeight(entry.Rarity)
            if weight >= 100 or (weight > 0 and randomInt(1, 100) <= weight) then
                return entry
            end
        end
    end

    return fallback
end

local function buildPool(options)
    local pool = {}

    for _, entry in pairs(Session.LoadedPool) do
        if entryAllowed(entry, options) then
            pool[#pool + 1] = entry
        end
    end

    for _, entry in ipairs(buildTemplatePool()) do
        if entryAllowed(entry, options) then
            pool[#pool + 1] = entry
        end
    end

    return pool
end

local ITEM_VALUE_INDEX_CHANNEL = MOD_UUID .. "_ItemValueIndex"
local ITEM_VALUE_RULES_CHANNEL = MOD_UUID .. "_ItemValueRules"
local ITEM_VALUE_STAT_TYPES = { "Armor", "Weapon", "Object" }
local ITEM_VALUE_ALLOWED_MODIFIERS = {
    Armor = true,
    Weapon = true,
    Object = true,
}

local function getRootTemplateForStat(stat)
    local rootTemplate = safeStatField(stat, "RootTemplate")
    if rootTemplate == nil or tostring(rootTemplate) == ""
        or tostring(rootTemplate) == "00000000-0000-0000-0000-000000000000"
    then
        return nil
    end

    if Ext == nil or Ext.Template == nil or type(Ext.Template.GetRootTemplate) ~= "function" then
        return nil
    end

    local ok, template = pcall(Ext.Template.GetRootTemplate, tostring(rootTemplate))
    if ok then
        return template
    end
    return nil
end

local function safeTemplateField(template, field)
    if template == nil then
        return nil
    end

    local ok, value = pcall(rawIndex, template, field)
    if ok then
        return value
    end
    return nil
end

local function makeItemStatEntry(statName)
    if statName == nil or tostring(statName) == "" then
        return nil
    end

    local stat = getStatsData(statName)
    if stat == nil then
        return nil
    end

    local modifierList = tostring(safeStatField(stat, "ModifierList") or "")
    if not ITEM_VALUE_ALLOWED_MODIFIERS[modifierList] then
        return nil
    end

    local template = getRootTemplateForStat(stat)
    if template == nil then
        return nil
    end

    local templateType = tostring(safeTemplateField(template, "TemplateType") or "")
    if templateType ~= "" and string.lower(templateType) ~= "item" then
        return nil
    end

    -- Some BG3SE builds/templates do not expose CanBePickedUp here. Reject only explicit false.
    if safeTemplateField(template, "CanBePickedUp") == false then
        return nil
    end

    local templateId = safeTemplateField(template, "Id")
    if templateId == nil or tostring(templateId) == "" then
        templateId = safeStatField(stat, "RootTemplate")
    end
    if templateId == nil or tostring(templateId) == "" then
        return nil
    end

    local name = safeTemplateField(template, "Name") or safeTemplateField(template, "TemplateName") or statName
    local displayName = getTranslatedTemplateName(template, tostring(name or statName))
    local fileName = safeTemplateField(template, "FileName")
    local statValue = getStatsNumber(stat, { "ValueOverride", "Value" })
    local modId = safeStatField(stat, "ModId") or safeStatField(stat, "OriginalModId")

    local entry = {
        Guid = nil,
        Template = tostring(templateId),
        Stats = tostring(statName),
        Name = tostring(name or statName),
        DisplayName = tostring(displayName or name or statName),
        Icon = safeTemplateField(template, "Icon"),
        GoldValue = tonumber(statValue) or 0,
        ValueKnown = statValue ~= nil,
        Rarity = normalizeRarity(safeStatField(stat, "Rarity")),
        ModId = modId,
        FileName = fileName,
        IsModded = isModdedFromMetadata(modId, fileName),
        MaxStack = 1,
        IsJunk = false,
        IsStory = templateIsStoryProtected(template),
        Source = "stat",
    }

    if isGoldEntry(entry) then
        return nil
    end

    if settingBool(SETTINGS.ProtectStory) and entry.IsStory == true then
        return nil
    end

    if containsUnsafePattern(entry.Template, entry.Stats, entry.Name) then
        return nil
    end

    return entry
end

local function makeItemTemplateEntry(template)
    if template == nil then
        return nil
    end

    local templateType = tostring(safeTemplateField(template, "TemplateType") or "")
    if string.lower(templateType) ~= "item" then
        return nil
    end

    -- Some BG3SE builds/templates do not expose CanBePickedUp here. Reject only explicit false.
    if safeTemplateField(template, "CanBePickedUp") == false then
        return nil
    end

    local statName = safeTemplateField(template, "Stats")
    if statName == nil or tostring(statName) == "" then
        return nil
    end
    statName = tostring(statName)

    local stat = getStatsData(statName)
    if stat == nil then
        return nil
    end

    local modifierList = tostring(safeStatField(stat, "ModifierList") or "")
    if not ITEM_VALUE_ALLOWED_MODIFIERS[modifierList] then
        return nil
    end

    local templateId = safeTemplateField(template, "Id")
    if templateId == nil or tostring(templateId) == "" then
        return nil
    end

    local name = safeTemplateField(template, "Name") or safeTemplateField(template, "TemplateName") or statName
    local displayName = getTranslatedTemplateName(template, tostring(name or statName))
    local fileName = safeTemplateField(template, "FileName")
    local statValue = getStatsNumber(stat, { "ValueOverride", "Value" })
    local modId = safeStatField(stat, "ModId") or safeStatField(stat, "OriginalModId")

    local entry = {
        Guid = nil,
        Template = tostring(templateId),
        Stats = statName,
        Name = tostring(name or statName),
        DisplayName = tostring(displayName or name or statName),
        Icon = safeTemplateField(template, "Icon"),
        GoldValue = tonumber(statValue) or 0,
        ValueKnown = statValue ~= nil,
        Rarity = normalizeRarity(safeStatField(stat, "Rarity")),
        ModId = modId,
        FileName = fileName,
        IsModded = isModdedFromMetadata(modId, fileName),
        MaxStack = 1,
        IsJunk = false,
        IsStory = templateIsStoryProtected(template),
        Source = "template",
    }

    if isGoldEntry(entry) then
        return nil
    end

    if settingBool(SETTINGS.ProtectStory) and entry.IsStory == true then
        return nil
    end

    if containsUnsafePattern(entry.Template, entry.Stats, entry.Name) then
        return nil
    end

    return entry
end

local function forEachItemStat(callback, options)
    options = options or {}
    local count = 0
    local seenStats = {}
    local seenTemplates = {}

    if Ext ~= nil and Ext.Template ~= nil and type(Ext.Template.GetAllRootTemplates) == "function" then
        local ok, templates = pcall(Ext.Template.GetAllRootTemplates)
        if ok and type(templates) == "table" then
            for _, template in pairs(templates) do
                local entry = makeItemTemplateEntry(template)
                if entry ~= nil then
                    local templateKey = tostring(entry.Template or "")
                    local statKey = tostring(entry.Stats or "")
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
    end

    if Ext == nil or Ext.Stats == nil or type(Ext.Stats.GetStats) ~= "function" then
        return 0
    end

    for _, statType in ipairs(ITEM_VALUE_STAT_TYPES) do
        local ok, stats = pcall(Ext.Stats.GetStats, statType)
        if ok and stats ~= nil then
            for _, statName in pairs(stats) do
                local key = tostring(statName or "")
                if key ~= "" and seenStats[key] ~= true then
                    seenStats[key] = true
                    local entry = makeItemStatEntry(key)
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

local function valueCorrectionSettingChanged(settingId)
    if settingId == nil then
        return true
    end

    return settingId == SETTINGS.ModdedValueCorrection
        or settingId == SETTINGS.ModdedValueThreshold
        or settingId == SETTINGS.ModdedCommonValue
        or settingId == SETTINGS.ModdedUncommonValue
        or settingId == SETTINGS.ModdedRareValue
        or settingId == SETTINGS.ModdedVeryRareValue
        or settingId == SETTINGS.ModdedLegendaryValue
        or settingId == SETTINGS.ModdedValueIncludeOnly
        or settingId == SETTINGS.ModdedValueModList
        or settingId == SETTINGS.ItemValueOverrides
end

local function itemValueCorrectionEnabled()
    if settingBool(SETTINGS.ModdedValueCorrection) then
        return true
    end

    local rules = getItemValueOverrideRules()
    for _, _ in pairs(rules or {}) do
        return true
    end

    local vars = ensureVars()
    for _, _ in pairs(vars.OriginalItemValues or {}) do
        return true
    end

    return false
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
        local value = tonumber(entry.GoldValue) or 0
        local threshold = settingInt(SETTINGS.ModdedValueThreshold, 0, 1000000)
        if entry.ValueKnown ~= true or value < threshold then
            return getModdedRarityValue(entry.Rarity), "rarity"
        end
    end

    return nil, "unchanged"
end

local function syncStat(stat, statName)
    if stat == nil then
        return
    end

    pcall(function()
        if type(stat.Sync) == "function" then
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
    local lastError = nil
    for _, field in ipairs({ "ValueOverride", "Value" }) do
        local ok, err = pcall(function()
            stat[field] = number
        end)
        if ok then
            local actual = tonumber(safeStatField(stat, field))
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

local function setEntityGoldValue(item, value)
    local entity = getEntity(item)
    if entity == nil then
        return false
    end

    local number = math.max(0, math.floor(tonumber(value) or 0))
    local updated = false

    pcall(function()
        if entity.Value == nil and type(entity.AddComponent) == "function" then
            entity:AddComponent("Value")
        end
    end)

    pcall(function()
        if entity.Value ~= nil then
            entity.Value.Value = number
            updated = true
        end
    end)

    pcall(function()
        if entity.ServerItem ~= nil then
            entity.ServerItem.ForceSync = true
        end
    end)

    return updated
end

local function getItemInventoryHolder(item)
    local holder = safeOsiValue("GetFirstInventoryOwnerCharacter", item)
    if holder ~= nil and holder ~= "" then
        return holder
    end

    holder = safeOsiValue("GetInventoryOwner", item)
    if holder ~= nil and holder ~= "" then
        return holder
    end

    return nil
end

local function getItemStackAmount(item)
    local fn = OSI_CALLS.GetStackAmount
    if fn == nil then
        return 1
    end

    local ok, exact = pcall(fn, item)
    if not ok then
        return 1
    end

    local amount = math.floor(tonumber(exact) or 1)
    if amount < 1 then
        amount = 1
    end
    return amount
end

local function isInventoryHeldItem(item)
    return getItemInventoryHolder(item) ~= nil
end

local function refreshInventoryItemValueViaDrop(itemRef, target)
    local itemGuid = getObjectUuid(itemRef)
    if itemGuid == nil or isStoryItem(itemGuid) then
        return false
    end

    local holder = getItemInventoryHolder(itemGuid)
    if holder == nil then
        return false
    end

    local wasEquipped = safeOsiValue("IsEquipped", itemGuid) == 1
    local amount = getItemStackAmount(itemGuid)
    local before = getGoldValue(itemGuid)

    if wasEquipped then
        safeOsi("Unequip", holder, itemGuid)
    end

    if not safeOsi("Drop", itemGuid) then
        if wasEquipped then
            safeOsi("Equip", holder, itemGuid, 0, 0, 1)
        end
        return false
    end

    setEntityGoldValue(itemGuid, target)

    if not safeOsi("ToInventory", itemGuid, holder, amount, 0, 1) then
        return false
    end

    if wasEquipped then
        safeOsi("Equip", holder, itemGuid, 0, 0, 1)
    end

    setEntityGoldValue(itemGuid, target)

    local after = getGoldValue(itemGuid)
    debugLog("Inventory relink for %s before=%s after=%s target=%s equipped=%s",
        tostring(itemGuid), tostring(before), tostring(after), tostring(target), tostring(wasEquipped))
    return after == target
end

local function tryRefreshItemInstance(itemRef, statTargets, seen)
    local itemGuid = getEntityUuid(itemRef)
    if itemGuid == nil or seen[itemGuid] then
        return false
    end

    seen[itemGuid] = true
    if not isItem(itemRef) or isStoryItem(itemRef) then
        return false
    end

    local stats = getStatString(itemRef)
    local target = stats ~= nil and statTargets[tostring(stats)] or nil
    if target == nil then
        return false
    end

    local current = getGoldValue(itemRef)
    if setEntityGoldValue(itemRef, target) then
        return current ~= target
    end

    if isInventoryHeldItem(itemRef) then
        return refreshInventoryItemValueViaDrop(itemRef, target)
    end

    return false
end

local function refreshExistingItemInstances(statTargets)
    if statTargets == nil or next(statTargets) == nil then
        return 0
    end

    local updated = 0
    local seen = {}

    for _, item in ipairs(getAllEntitiesWith("ServerItem")) do
        if tryRefreshItemInstance(item, statTargets, seen) then
            updated = updated + 1
        end
    end

    for _, item in ipairs(collectPartyInventoryItems()) do
        local itemRef = item.Entity or item.Guid
        if tryRefreshItemInstance(itemRef, statTargets, seen) then
            updated = updated + 1
        end
    end

    return updated
end

local function applyItemValueStatCorrections(reason)
    if not itemValueCorrectionEnabled() then
        return
    end

    local changed = 0
    local restored = 0
    local failed = 0
    local locked = 0
    local checked = 0
    local instancesUpdated = 0
    local firstError = nil
    local vars = ensureVars()
    local statTargets = {}

    forEachItemStat(function(entry)
        checked = checked + 1
        local target, mode = getTargetStatValue(entry)
        local current = tonumber(entry.GoldValue) or 0
        local statName = tostring(entry.Stats or "")
        if statName == "" then
            return
        end

        if target == nil then
            if mode == "locked" then
                locked = locked + 1
            end

            local original = vars.OriginalItemValues[statName]
            if original ~= nil and original ~= false and current ~= original then
                local ok, err = setStatGoldValue(statName, original)
                if ok then
                    restored = restored + 1
                    statTargets[statName] = original
                    vars.OriginalItemValues[statName] = nil
                else
                    failed = failed + 1
                    firstError = firstError or tostring(err or "unknown error")
                end
            elseif mode ~= "locked" then
                vars.OriginalItemValues[statName] = nil
            end
            return
        end

        statTargets[statName] = target

        if vars.OriginalItemValues[statName] == nil then
            vars.OriginalItemValues[statName] = entry.ValueKnown == true and current or false
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

    instancesUpdated = refreshExistingItemInstances(statTargets)

    -- Remember the targets so vendor stock can be re-synced when a trade window opens.
    Session.StatTargets = statTargets
    if changed > 0 or restored > 0 or instancesUpdated > 0 or reason == "mcm" then
        Session.StatTargetsVersion = (Session.StatTargetsVersion or 0) + 1
    end

    -- Value corrections only change GoldValue, which entryAllowed already re-resolves
    -- live via effectiveGoldValue() on every check. They don't change which templates
    -- are eligible, so there's no need to force a full ~11k-template pool rebuild here
    -- (that's still triggered separately, correctly, by onSettingsChanged for settings
    -- that actually affect eligibility, e.g. ProtectStory, ExcludedItems).
    Session.ItemValueIndex = nil

    if failed > 0 then
        log("Item value stat correction from %s checked=%d changed=%d restored=%d instances=%d locked=%d failed=%d firstError=%s",
            tostring(reason or "settings"), checked, changed, restored, instancesUpdated, locked, failed, firstError or "")
    elseif changed > 0 or restored > 0 or locked > 0 or instancesUpdated > 0 then
        log("Item value stat correction from %s checked=%d changed=%d restored=%d instances=%d locked=%d",
            tostring(reason or "settings"), checked, changed, restored, instancesUpdated, locked)
    else
        debugLog("Item value stat correction from %s checked=%d changed=0 restored=0", tostring(reason or "settings"), checked)
    end
end

-- Profiling showed this full ~13k-item pass (2-5 s each) running 4 times per load, because
-- StatsLoaded, SessionLoaded, bootstrap, SavegameLoaded and LevelGameplayStarted each schedule
-- one. One pass per session is enough; a settings change from MCM still forces a new pass.
local statCorrectionPending = false
local statCorrectionDone = false

local function scheduleItemValueStatCorrections(reason, delay)
    local forced = (reason == "mcm")
    if forced then
        statCorrectionDone = false
    elseif statCorrectionDone or statCorrectionPending then
        debugLog("Item value stat correction '%s' skipped (already done or pending this session)", tostring(reason))
        return
    end

    statCorrectionPending = true
    local function run()
        statCorrectionPending = false
        statCorrectionDone = true
        applyItemValueStatCorrections(reason)
    end

    if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
        Ext.Timer.WaitFor(delay or 250, run)
    else
        run()
    end
end

local function buildItemValueIndex()
    if Session.ItemValueIndex ~= nil then
        return Session.ItemValueIndex
    end

    local index = {}
    forEachItemStat(function(entry)
        local value, known = effectiveGoldValue(entry)
        index[#index + 1] = {
            StatName = entry.Stats,
            Template = entry.Template,
            DisplayName = entry.DisplayName or entry.Name or entry.Stats,
            Icon = entry.Icon,
            Rarity = entry.Rarity,
            Value = value,
            BaseValue = tonumber(entry.GoldValue) or 0,
            ValueKnown = known == true,
            IsModded = entry.IsModded == true,
            ModId = entry.ModId,
        }
    end)

    table.sort(index, function(a, b)
        local an = tostring(a.DisplayName or a.StatName or "")
        local bn = tostring(b.DisplayName or b.StatName or "")
        return an < bn
    end)

    Session.ItemValueIndex = index
    log("Item value index built with %d searchable items", #index)
    return index
end

local itemValueIndexUnsendableLogged = false

local function sendItemValueIndexToUser(user)
    -- Without ChunkedNet the only route is one net message, and the full index (~5 MB) is far over
    -- the game's 1 MB message limit, so it always failed after costing ~7 s to build and
    -- stringify. The client builds its own local index (see ItemValueIndex_Client.lua), so skip.
    if not (ChunkedNet ~= nil and type(ChunkedNet.SendTableToUser) == "function" and user ~= nil) then
        if not itemValueIndexUnsendableLogged then
            itemValueIndexUnsendableLogged = true
            log("Item value index not sent: ChunkedNet unavailable (client uses its local index)")
        end
        return
    end

    local index = buildItemValueIndex()
    if ChunkedNet ~= nil and type(ChunkedNet.SendTableToUser) == "function" and user ~= nil then
        ChunkedNet.SendTableToUser(user, ITEM_VALUE_INDEX_CHANNEL, index)
        return
    end

    if Ext ~= nil and Ext.Json ~= nil and type(Ext.Json.Stringify) == "function" then
        local ok, payload = pcall(Ext.Json.Stringify, index)
        if ok and type(payload) == "string" then
            if user ~= nil and Ext.ServerNet ~= nil and type(Ext.ServerNet.PostMessageToUser) == "function" then
                Ext.ServerNet.PostMessageToUser(user, ITEM_VALUE_INDEX_CHANNEL, payload)
            elseif Ext.Net ~= nil and type(Ext.Net.BroadcastMessage) == "function" then
                Ext.Net.BroadcastMessage(ITEM_VALUE_INDEX_CHANNEL, payload)
            end
        end
    end
end

local function essentialCategoryOf(entry)
    for _, key in ipairs({ entry.Template, entry.Stats, entry.Name }) do
        local id = string.lower(tostring(key or ""))
        if ESSENTIAL_INJURY_IDS[id] == true then
            return "injury"
        end
        if ESSENTIAL_REVIVE_IDS[id] == true then
            return "revive"
        end
    end
    return "supply"
end

-- The template -> essential subset only changes when the template pool is rebuilt, so it is
-- cached against the pool's identity instead of rescanning ~11k templates per vendor visit.
local function getEssentialCandidates()
    local templates = buildTemplatePool()
    local cache = Session.EssentialCache
    if cache == nil or cache.Source ~= templates then
        local list = {}
        for _, entry in ipairs(templates) do
            if isEssentialVendorItem(entry.Template, entry.Stats, entry.Name) then
                list[#list + 1] = entry
            end
        end
        cache = { Source = templates, List = list }
        Session.EssentialCache = cache
    end
    return cache.List
end

local function buildEssentialVendorPool()
    local buckets = { injury = {}, revive = {}, supply = {} }
    local total = 0
    local seen = {}
    local options = { FilterJunk = false }

    local function consider(entry)
        local id = entry.Template
        if id == nil or seen[id] then
            return
        end
        if entryAllowed(entry, options) then
            seen[id] = true
            local bucket = buckets[essentialCategoryOf(entry)]
            bucket[#bucket + 1] = entry
            total = total + 1
        end
    end

    for _, entry in ipairs(getEssentialCandidates()) do
        consider(entry)
    end

    for _, entry in ipairs(getLoadedList()) do
        if isEssentialVendorItem(entry.Template, entry.Stats, entry.Name) then
            consider(entry)
        end
    end

    return buckets, total
end

local function pickRandomEntry(pool)
    if pool == nil or #pool == 0 then
        return nil
    end

    return pool[randomInt(1, #pool)]
end

local function weightedPickRandomEntry(pool, maxAttempts)
    if pool == nil or #pool == 0 then
        return nil
    end

    if not settingBool(SETTINGS.RarityWeightsEnabled) then
        return pickRandomEntry(pool)
    end

    maxAttempts = tonumber(maxAttempts) or #pool
    if maxAttempts < 1 then
        maxAttempts = 1
    end

    for _ = 1, maxAttempts do
        local entry = pool[randomInt(1, #pool)]
        if entry ~= nil then
            local weight = getRarityWeight(entry.Rarity)
            if weight >= 100 then
                return entry
            end
            if weight <= 0 then
                -- skip, try again
            else
                local roll = randomInt(1, 100)
                if roll <= weight then
                    return entry
                end
            end
        end
    end

    return pool[randomInt(1, #pool)]
end

local function templateAddTo(template, target)
    if template == nil or template == "" or target == nil or target == "" then
        return false
    end

    if safeOsi("TemplateAddTo", template, target, 1, 0) then
        return true
    end

    local created = safeOsiValue("CreateAtObject", template, target, 0, 0, "", 0)
    if created ~= nil and created ~= "" then
        return safeOsi("ToInventory", created, target, 1, 0, 1)
    end

    return false
end

local function canDeleteItem(item, holder, vendorMode)
    if item == nil or not isItem(item) or isStoryItem(item) then
        return false
    end

    local template = getTemplate(item)
    local stats = getStatString(item)
    if template == nil or template == "" or containsUnsafePattern(template, stats, nil) then
        return false
    end

    if vendorMode and settingBool(SETTINGS.VendorPreserveEssential) and isEssentialVendorItem(template, stats, nil) then
        return false
    end

    if stats == "OBJ_GoldPile" or tostring(template):lower():find("loot_gold", 1, true) ~= nil then
        return false
    end

    if vendorMode and canTrade(holder) == false then
        return false
    end

    return true
end

local function requestDelete(item)
    if item == nil or item == "" then
        return false
    end

    return safeOsi("RequestDelete", item)
end

local function snapshotInventory(holder)
    local snapshot = {}
    for _, item in ipairs(collectInventoryItems(holder, { PrimaryOnly = false, Recursive = true })) do
        snapshot[item.Guid] = true
    end
    return snapshot
end

local function removeUnsafeGeneratedItems(holder, before)
    local removed = 0
    before = before or {}

    for _, item in ipairs(collectInventoryItems(holder, { PrimaryOnly = false, Recursive = true })) do
        if before[item.Guid] ~= true then
            local template = getTemplate(item.Guid)
            local stats = getStatString(item.Guid)
            if isStoryItem(item.Guid) or containsUnsafePattern(template, stats, nil) then
                if requestDelete(item.Guid) then
                    removed = removed + 1
                    log("Removed unsafe generated item %s stats=%s template=%s", tostring(item.Guid), tostring(stats), tostring(template))
                else
                    log("Unsafe generated item could not be removed %s stats=%s template=%s", tostring(item.Guid), tostring(stats), tostring(template))
                end
            end
        end
    end

    return removed
end

local function removeOldLootFromHolder(holder, vendorMode)
    local removed = 0
    local options = vendorMode and { PrimaryOnly = true, Recursive = true } or { PrimaryOnly = false, Recursive = true }
    local items = collectInventoryItems(holder, options)
    for _, item in ipairs(items) do
        trackItem(item.Guid, "inventory")
    end

    for _, item in ipairs(items) do
        if canDeleteItem(item.Guid, holder, vendorMode) and requestDelete(item.Guid) then
            removed = removed + 1
        end
    end

    return removed
end

local function addRandomLoot(holder, count, options)
    local added = 0
    local attempts = 0
    local slowPool = nil
    local before = snapshotInventory(holder)
    for _ = 1, count do
        local entry = sampleLootEntry(options)
        if entry == nil then
            -- Sampling found nothing (very tight filters): fall back to the exhaustive scan.
            if slowPool == nil then
                slowPool = buildPool(options)
            end
            entry = weightedPickRandomEntry(slowPool, count * 3)
        end
        if entry == nil then
            break
        end

        attempts = attempts + 1
        if templateAddTo(entry.Template, holder) then
            added = added + 1
        end
    end

    local unsafeRemoved = removeUnsafeGeneratedItems(holder, before)
    if unsafeRemoved > 0 then
        added = math.max(0, added - unsafeRemoved)
    end

    local poolSize = slowPool ~= nil and #slowPool or (#getLoadedList() + #buildTemplatePool())
    return added, poolSize, attempts
end

local function addEssentialVendorLoot(holder, count)
    count = math.floor(tonumber(count) or 0)
    if count <= 0 then
        return 0, 0, 0
    end

    local chance = settingInt(SETTINGS.VendorEssentialChance, 0, 100)
    if chance <= 0 or (chance < 100 and randomInt(1, 100) > chance) then
        return 0, 0, 0
    end

    local buckets, poolSize = buildEssentialVendorPool()
    if poolSize == 0 then
        return 0, 0, 0
    end

    local added = 0
    local attempts = 0
    local maxAttempts = math.max(count * 6, count)
    local before = snapshotInventory(holder)
    local categoryCount = #ESSENTIAL_CATEGORY_ORDER
    local cursor = randomInt(1, categoryCount)
    while added < count and attempts < maxAttempts do
        -- Rotate through injury kits / revive scrolls / supplies so every category is
        -- represented before any repeats, skipping categories with nothing available.
        local entry = nil
        for step = 0, categoryCount - 1 do
            local slot = ((cursor - 1 + step) % categoryCount) + 1
            local bucket = buckets[ESSENTIAL_CATEGORY_ORDER[slot]]
            if #bucket > 0 then
                entry = pickRandomEntry(bucket)
                cursor = slot + 1
                break
            end
        end
        if entry == nil then
            break
        end

        attempts = attempts + 1
        if templateAddTo(entry.Template, holder) then
            added = added + 1
        end
    end

    local unsafeRemoved = removeUnsafeGeneratedItems(holder, before)
    if unsafeRemoved > 0 then
        added = math.max(0, added - unsafeRemoved)
    end

    return added, poolSize, attempts
end

local function cleanupVendorDuplicates(vendor, player)
    if not settingBool(SETTINGS.VendorDuplicateRemoval) then
        return
    end

    local seen = {}
    local maxValue = getLevel(player or vendor) * 100
    for _, item in ipairs(collectInventoryItems(vendor, { PrimaryOnly = true, Recursive = true })) do
        local template = getTemplate(item.Guid)
        if template ~= nil and canDeleteItem(item.Guid, vendor, true) then
            local value = getGoldValue(item.Guid)
            local maxStack = getMaxStack(item.Guid)
            if settingBool(SETTINGS.MaxValuePerLevel) and value > maxValue then
                requestDelete(item.Guid)
            elseif maxStack <= 1 then
                if seen[template] then
                    requestDelete(item.Guid)
                else
                    seen[template] = true
                end
            end
        end
    end
end

-- Items already sitting in a vendor's trade inventory keep the price the client last saw.
-- Writing Value on the server entity succeeds but never reaches that stale copy, which is why
-- a changed price only showed up after dropping the item and picking it back up. So when a
-- trade opens, relink (drop + re-add) the vendor's value-managed items once per correction
-- pass, which is the same thing the manual drop/pickup did.
local function resyncVendorItemValues(vendor)
    local targets = Session.StatTargets
    if targets == nil or next(targets) == nil or vendor == nil then
        return 0
    end

    local vendorKey = getObjectUuid(vendor)
    if vendorKey == nil then
        return 0
    end

    local version = Session.StatTargetsVersion or 0
    if Session.VendorValueSynced[vendorKey] == version then
        return 0
    end
    Session.VendorValueSynced[vendorKey] = version

    local refreshed = 0
    local ok, err = pcall(function()
        for _, item in ipairs(collectInventoryItems(vendor, { PrimaryOnly = true, Recursive = false })) do
            local stats = getStatString(item.Guid)
            local target = stats ~= nil and targets[tostring(stats)] or nil
            if target ~= nil and refreshInventoryItemValueViaDrop(item.Guid, target) then
                refreshed = refreshed + 1
            end
        end
    end)

    if not ok then
        debugLog("Vendor value resync failed for %s: %s", tostring(vendorKey), tostring(err))
    elseif refreshed > 0 then
        debugLog("Vendor value resync refreshed %d item(s) for %s", refreshed, tostring(vendorKey))
    end
    return refreshed
end

local function applyVendor(vendor, force, player)
    if not settingsEnabled() then
        log("Vendor skipped because the mod is disabled")
        return false
    end

    local forceApply = normalizeApplyForce(force)
    if forceApply == nil then
        log("Vendor skipped because randomization is frozen")
        return false
    end

    local randomStock = settingBool(SETTINGS.VendorRandom)
    local filteredStock = settingBool(SETTINGS.VendorFiltered)
    local vendorPlus = settingBool(SETTINGS.VendorPlus)
    local essentialStock = settingBool(SETTINGS.VendorEssentialStock) and (randomStock or filteredStock or vendorPlus)
    if not randomStock and not filteredStock and not vendorPlus then
        log("Vendor skipped because no vendor loot mode is enabled")
        return false
    end

    local vendorKey = getObjectUuid(vendor)
    if vendorKey == nil or isPartyMember(vendor) then
        log("Vendor skipped because it had no UUID or is a party member: %s", tostring(vendor))
        return false
    end

    local vars = ensureVars()
    if not forceApply and vars.ProcessedVendors[vendorKey] == vars.Generation then
        log("Vendor skipped because it was already processed in generation %d: %s", vars.Generation, tostring(vendorKey))
        return false
    end

    if vendorPlus and vars.VendorPlusLocks[vendorKey] == true then
        vars.ProcessedVendors[vendorKey] = vars.Generation
        log("Vendor++ skipped because this vendor is locked until long rest: %s", tostring(vendorKey))
        return false
    end

    player = player or getHost() or vendor
    logMutationApiAvailability()
    local countInventory = settingBool(SETTINGS.Debug)
    local beforeCount = countInventory and #collectInventoryItems(vendor, { PrimaryOnly = true, Recursive = true }) or -1
    local removed = 0
    if not vendorPlus and settingBool(SETTINGS.VendorRemoveExisting) then
        removed = removeOldLootFromHolder(vendor, true)
    end

    local level = getLevel(player)
    local count = settingInt(SETTINGS.VendorGeneratedItems, 0, 200)
    local essentialTarget = essentialStock and settingInt(SETTINGS.VendorEssentialCount, 0, 50) or 0
    log(
        "Processing vendor %s modes[random=%s filtered=%s vendor++=%s essential=%s] level=%d targetAdds=%d essentialTarget=%d inventoryBefore=%d removed=%d generation=%d",
        tostring(vendorKey),
        tostring(randomStock),
        tostring(filteredStock),
        tostring(vendorPlus),
        tostring(essentialStock),
        level,
        count,
        essentialTarget,
        beforeCount,
        removed,
        vars.Generation
    )

    local essentialAdded, essentialPoolSize, essentialAttempts = addEssentialVendorLoot(vendor, essentialTarget)

    local added, poolSize, attempts = addRandomLoot(vendor, count, {
        FilterJunk = filteredStock == true,
        MaxValue = level * 100,
    })

    cleanupVendorDuplicates(vendor, player)

    if count > 0 and added == 0 then
        local fallbackAdded, fallbackPoolSize, fallbackAttempts = addRandomLoot(vendor, 1, {
            FilterJunk = filteredStock == true,
            MaxValue = level * 100,
        })
        added = fallbackAdded
        poolSize = fallbackPoolSize
        attempts = attempts + fallbackAttempts
    end

    if vendorPlus then
        vars.VendorPlusLocks[vendorKey] = true
    end

    vars.ProcessedVendors[vendorKey] = vars.Generation
    local afterCount = countInventory and #collectInventoryItems(vendor, { PrimaryOnly = true, Recursive = true }) or -1
    log(
        "Processed vendor %s pool=%d attempts=%d added=%d essentialPool=%d essentialAttempts=%d essentialAdded=%d inventoryAfter=%d",
        tostring(vendorKey),
        tonumber(poolSize) or 0,
        tonumber(attempts) or 0,
        added,
        tonumber(essentialPoolSize) or 0,
        tonumber(essentialAttempts) or 0,
        essentialAdded,
        afterCount
    )
    return added > 0 or essentialAdded > 0
end

local function applyEnemy(enemy, force)
    if not settingsEnabled() or not settingBool(SETTINGS.EnemyRandom) then
        return false
    end

    local forceApply = normalizeApplyForce(force)
    if forceApply == nil then
        return false
    end

    if not isEnemy(enemy) then
        return false
    end

    local enemyKey = getObjectUuid(enemy)
    if enemyKey == nil then
        return false
    end

    local vars = ensureVars()
    if not forceApply and vars.ProcessedEnemies[enemyKey] == vars.Generation then
        return false
    end

    logMutationApiAvailability()
    if settingBool(SETTINGS.EnemyRemoveExisting) then
        removeOldLootFromHolder(enemy, false)
    end

    local level = getLevel(enemy)
    local scaling = settingInt(SETTINGS.EnemyDropScaling, 1, 12)
    local maxDrops = math.max(1, math.floor(level / scaling) + 1)
    local added = addRandomLoot(enemy, randomInt(1, maxDrops), {
        MaxValue = level * 100,
    })

    vars.ProcessedEnemies[enemyKey] = vars.Generation
    debugLog("Processed enemy %s, added=%d", tostring(enemyKey), added)
    return added > 0
end

local function applyLoaded(reason, force)
    local forceApply = normalizeApplyForce(force)
    if forceApply == nil then
        if reason ~= "periodic" then
            debugLog("Apply pass '%s' skipped because randomization is frozen", tostring(reason))
        end
        return
    end

    if Session.Applying then
        Session.ApplyPending = true
        return
    end

    Session.Applying = true
    ensureVars()

    if settingsEnabled() then
        buildTemplatePool()
        refreshLoadedPool()

        local vendors = 0
        local enemies = 0
        for _, character in ipairs(getAllEntitiesWith("ServerCharacter")) do
            local uuid = getEntityUuid(character)
            if uuid ~= nil then
                if canTrade(uuid) then
                    if applyVendor(uuid, forceApply) then
                        vendors = vendors + 1
                    end
                elseif applyEnemy(uuid, forceApply) then
                    enemies = enemies + 1
                end
            end
        end

        debugLog("Apply pass '%s' complete. vendors=%d enemies=%d", tostring(reason), vendors, enemies)
    end

    Session.Applying = false
    if Session.ApplyPending then
        Session.ApplyPending = false
        applyLoaded("pending", false)
    end
end

local function scheduleApply(reason, force, delay)
    local wait = tonumber(delay) or 250
    if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
        Ext.Timer.WaitFor(wait, function()
            applyLoaded(reason, force)
        end)
    elseif Ext ~= nil and type(Ext.OnNextTick) == "function" then
        Ext.OnNextTick(function()
            applyLoaded(reason, force)
        end)
    else
        applyLoaded(reason, force)
    end
end

local function startPeriodicScan()
    if Session.PeriodicStarted then
        return
    end

    Session.PeriodicStarted = true
    local function tick()
        if heavyGlobalScansEnabled()
            and settingBool(SETTINGS.PeriodicScan)
            and (not randomizationFrozen() or applyNewWhileFrozen())
        then
            scheduleApply("periodic", false, 1)
        end

        if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
            Ext.Timer.WaitFor(5000, tick)
        end
    end

    if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
        Ext.Timer.WaitFor(5000, tick)
    end
end

local function beginSettingsGeneration(reason, applyNow)
    local vars = ensureVars()
    vars.Generation = vars.Generation + 1
    vars.ProcessedVendors = {}
    vars.ProcessedEnemies = {}
    vars.PendingSettingsApply = nil
    Session.TemplatePool = nil
    Session.ItemValueIndex = nil
    debugLog("Started loot generation %d from %s", vars.Generation, tostring(reason or "settings"))
    if applyNow == true then
        scheduleApply(reason or "mcm", true, 250)
    end
end

local function onSettingsChanged(settingId)
    clearSettingCache(settingId)
    local vars = ensureVars()
    if settingId == SETTINGS.ItemValueOverrides then
        Session.ItemValueOverrideRules = nil
        Session.ItemValueOverrideRulesText = nil
        Session.ItemValueIndex = nil
    end

    if settingId == SETTINGS.ModdedValueIncludeOnly or settingId == SETTINGS.ModdedValueModList then
        Session.ModValueFilterCache = nil
    end

    if settingId == SETTINGS.LootModFilterEnabled or settingId == SETTINGS.LootModFilterMode or settingId == SETTINGS.LootModFilterList then
        Session.LootModFilterCache = nil
    end

    if settingId == SETTINGS.ExcludedItems then
        Session.ExcludedItemsCache = nil
    end

    if valueCorrectionSettingChanged(settingId) then
        scheduleItemValueStatCorrections("mcm", 100)
    end

    local wasFrozen = Session.FrozenState
    local nowFrozen = randomizationFrozen()
    Session.FrozenState = nowFrozen

    if settingId == SETTINGS.FreezeRandomization or (wasFrozen ~= nil and wasFrozen ~= nowFrozen) then
        if nowFrozen then
            debugLog("Randomization is frozen; current generated loot will be preserved")
            return
        end

        if vars.PendingSettingsApply == true then
            beginSettingsGeneration("mcm-unfreeze", false)
        else
            debugLog("Randomization unfrozen; future trade/death triggers will use current settings")
        end
        return
    end

    if not settingChangeAffectsLoot(settingId) then
        return
    end

    if nowFrozen then
        vars.PendingSettingsApply = true
        Session.TemplatePool = nil
        Session.ItemValueIndex = nil
        debugLog("MCM change deferred because randomization is frozen")
        return
    end

    beginSettingsGeneration("mcm", false)
end

local function onSessionReady(reason)
    clearSettingCache(nil)
    ensureVars()
    Session.FrozenState = randomizationFrozen()
    -- One scheduled pass is enough here; the "StatsLoaded" subscription below already
    -- triggers its own pass as soon as stats are actually ready, so a second fixed-delay
    -- full ~11k-item scan back-to-back with this one was pure duplicate cost.
    scheduleItemValueStatCorrections(reason or "session", 2000)
    if heavyGlobalScansEnabled() and settingBool(SETTINGS.ApplyOnLoad) then
        if not randomizationFrozen() or applyNewWhileFrozen() then
            scheduleApply(reason or "session", not randomizationFrozen(), 1000)
        else
            debugLog("Apply pass '%s' skipped because randomization is frozen", tostring(reason or "session"))
        end
    end
    startPeriodicScan()

    -- Building the ~11k-template pool took 3-3.6 s the first time an enemy died (a hitch in the
    -- middle of a fight). Do it once, shortly after load, instead.
    if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" and not Session.PoolWarmScheduled then
        Session.PoolWarmScheduled = true
        Ext.Timer.WaitFor(9000, function()
            if Session.TemplatePool == nil then
                pcall(buildTemplatePool)
            end
        end)
    end
end

local function clearLongRestLocks()
    if randomizationFrozen() then
        debugLog("Long-rest loot refresh skipped because randomization is frozen")
        return
    end

    local vars = ensureVars()
    vars.VendorPlusLocks = {}
    vars.ProcessedVendors = {}
    vars.ProcessedEnemies = {}
    vars.Generation = vars.Generation + 1
    debugLog("Long-rest loot locks cleared; vendors will refresh on next trade")
end

local function onCombined(_, _, _, _, _, _, newItem)
    if newItem == nil or not settingBool(SETTINGS.BlockCombined) then
        return
    end

    local template = getTemplate(newItem)
    local key = getObjectUuid(newItem)
    if template ~= nil then
        Session.BlockedItems[template] = true
    end
    if key ~= nil then
        Session.BlockedItems[key] = true
    end
end

local function onRequestTrade(player, vendor, _, _)
    if vendor == nil then
        return
    end

    log("RequestTrade detected for vendor %s", tostring(vendor))
    local vendorKey = getObjectUuid(vendor) or tostring(vendor)
    Session.PendingTrades[vendorKey] = {
        Player = player,
        Vendor = vendor,
        ProcSeen = false,
    }

    if Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
        Ext.Timer.WaitFor(1000, function()
            local pending = Session.PendingTrades[vendorKey]
            if pending ~= nil and pending.ProcSeen ~= true then
                log("RequestTrade fallback processing vendor %s", tostring(vendor))
                applyVendor(vendor, false, player)
                resyncVendorItemValues(vendor)
            end
        end)
    end
end

local function onTradeGenerationStarted(trader)
    if trader == nil then
        return
    end

    log("TradeGenerationStarted detected for trader %s", tostring(trader))
    applyVendor(trader, false)
    resyncVendorItemValues(trader)
end

local function onStartTrade(player, trader, _, _)
    if trader == nil then
        return
    end

    log("PROC_StartTrade detected for trader %s", tostring(trader))
    local traderKey = getObjectUuid(trader) or tostring(trader)
    Session.PendingTrades[traderKey] = Session.PendingTrades[traderKey] or {}
    Session.PendingTrades[traderKey].ProcSeen = true
    applyVendor(trader, false, player)
    resyncVendorItemValues(trader)
end

local function onTradeEnds(player, trader)
    if trader == nil then
        return
    end

    local traderKey = getObjectUuid(trader) or tostring(trader)
    Session.PendingTrades[traderKey] = nil
end

local function onCharacterLootedCharacter(player, character)
    if character == nil then
        return
    end

    log("CharacterLootedCharacter detected for character %s", tostring(character))
    applyEnemy(character, false)
end

local function registerListener(event, arity, phase, callback)
    if Ext == nil or Ext.Osiris == nil or type(Ext.Osiris.RegisterListener) ~= "function" then
        return
    end

    local ok, err = pcall(Ext.Osiris.RegisterListener, event, arity, phase, callback)
    if not ok then
        log("Could not register %s: %s", event, tostring(err))
    end
end

local function subscribeEvent(event, callback)
    local eventObject = Ext ~= nil and Ext.Events ~= nil and Ext.Events[event] or nil
    if eventObject == nil or type(eventObject.Subscribe) ~= "function" then
        return
    end

    pcall(function()
        eventObject:Subscribe(callback)
    end)
end

local function getMCMSettingId(payload)
    if type(payload) == "string" then
        return payload
    end

    if type(payload) ~= "table" then
        return nil
    end

    return payload.settingId
        or payload.settingID
        or payload.SettingId
        or payload.SettingID
        or payload.setting
        or payload.id
        or payload.Id
end

local function isMCMEventForThisMod(payload)
    if type(payload) ~= "table" then
        return false
    end

    local modId = payload.modUUID
        or payload.modGUID
        or payload.modUuid
        or payload.modGuid
        or payload.ModUUID
        or payload.ModGUID

    return modId == MOD_UUID
end

local function subscribeMCM()
    if Session.MCMSubscribed then
        return
    end

    local subscribed = false
    if Ext ~= nil and Ext.ModEvents ~= nil and Ext.ModEvents.BG3MCM ~= nil then
        local events = Ext.ModEvents.BG3MCM
        if events["MCM_Setting_Saved"] ~= nil then
            events["MCM_Setting_Saved"]:Subscribe(function(payload)
                if isMCMEventForThisMod(payload) then
                    local settingId = getMCMSettingId(payload)
                    if settingId == SETTINGS.ItemValueOverrides then
                        Session.ItemValueOverrideTextOverride = nil
                    end
                    onSettingsChanged(settingId)
                end
            end)
            subscribed = true
        end
        if events["MCM_Setting_Reset"] ~= nil then
            events["MCM_Setting_Reset"]:Subscribe(function(payload)
                if isMCMEventForThisMod(payload) then
                    local settingId = getMCMSettingId(payload)
                    if settingId == SETTINGS.ItemValueOverrides then
                        Session.ItemValueOverrideTextOverride = nil
                    end
                    onSettingsChanged(settingId)
                end
            end)
            subscribed = true
        end
    end

    if not subscribed
        and Mods ~= nil and Mods.BG3MCM ~= nil and Mods.BG3MCM.MCMAPI ~= nil
        and type(Mods.BG3MCM.MCMAPI.RegisterModSettingsChangedCallback) == "function"
    then
        local ok = pcall(function()
            Mods.BG3MCM.MCMAPI:RegisterModSettingsChangedCallback(MOD_UUID, function(payload)
                local settingId = getMCMSettingId(payload)
                if settingId == SETTINGS.ItemValueOverrides then
                    Session.ItemValueOverrideTextOverride = nil
                end
                onSettingsChanged(settingId)
            end)
        end)
        subscribed = ok
    end

    if subscribed then
        Session.MCMSubscribed = true
    elseif Ext ~= nil and Ext.Timer ~= nil and type(Ext.Timer.WaitFor) == "function" then
        Ext.Timer.WaitFor(1000, subscribeMCM)
    end
end

local function saveItemValueOverrideText(text)
    text = tostring(text or "")
    Session.ItemValueOverrideTextOverride = text
    Session.ItemValueOverrideRules = nil
    Session.ItemValueOverrideRulesText = nil
    Session.ItemValueIndex = nil

    local vars = ensureVars()
    vars.ItemValueOverrides = text

    if MCM ~= nil and type(MCM.Set) == "function" then
        pcall(function()
            MCM.Set(SETTINGS.ItemValueOverrides, text, MOD_UUID)
        end)
    end

    onSettingsChanged(SETTINGS.ItemValueOverrides)
end

if Ext ~= nil and type(Ext.RegisterNetListener) == "function" then
    Ext.RegisterNetListener(ITEM_VALUE_INDEX_CHANNEL .. "_REQ", function(_, _, user)
        log("Item value index request received")
        sendItemValueIndexToUser(user)
    end)

    Ext.RegisterNetListener(ITEM_VALUE_RULES_CHANNEL, function(_, payload, _)
        saveItemValueOverrideText(payload)
    end)
end

subscribeEvent("StatsLoaded", function()
    scheduleItemValueStatCorrections("stats-loaded", 1000)
end)

subscribeEvent("SessionLoaded", function()
    onSessionReady("session-loaded")
end)

subscribeEvent("ResetCompleted", function()
    Session.Applying = false
    Session.ApplyPending = false
    Session.TemplatePool = nil
    Session.ItemValueIndex = nil
    Session.LoadedPool = {}
    Session.LoadedList = nil
    Session.EssentialCache = nil
    Session.VendorValueSynced = {}
end)

registerListener("SavegameLoaded", 0, "after", function()
    onSessionReady("savegame-loaded")
end)
registerListener("LevelGameplayStarted", 2, "after", function(levelName, isEditorMode)
    if levelName ~= nil then
        local level = string.upper(tostring(levelName))
        if string.find(level, "ACT3") or string.find(level, "CITY") or string.find(level, "LWC") or string.find(level, "UDC") or string.find(level, "GMP") then
            Session.CurrentAct = 3
        elseif string.find(level, "ACT2") or string.find(level, "SHD") or string.find(level, "THM") or string.find(level, "FAO") then
            Session.CurrentAct = 2
        else
            Session.CurrentAct = 1
        end
        debugLog("Detected act %d from level '%s'", Session.CurrentAct, tostring(levelName))
    end
    onSessionReady("level-started")
end)
registerListener("CharacterLoadedInPreset", 1, "after", function()
    if heavyGlobalScansEnabled() and settingBool(SETTINGS.PeriodicScan) then
        scheduleApply("character-loaded", false, 500)
    end
end)
registerListener("RequestTrade", 4, "before", onRequestTrade)
registerListener("PROC_StartTrade", 4, "before", onStartTrade)
registerListener("TradeEnds", 2, "after", onTradeEnds)
registerListener("TradeGenerationStarted", 1, "before", onTradeGenerationStarted)
registerListener("Died", 1, "after", function(character)
    applyEnemy(character, false)
end)
registerListener("CharacterLootedCharacter", 2, "after", onCharacterLootedCharacter)
registerListener("Combined", 7, "after", onCombined)
registerListener("LongRestStarted", 0, "after", clearLongRestLocks)
registerListener("LongRestFinished", 0, "after", clearLongRestLocks)

subscribeMCM()
onSessionReady("bootstrap")
log("Server script loaded")

Mods = Mods or {}
Mods.AHRL = Mods.AHRL or {}
Mods.AHRL.Server = {
    ApplyLoaded = applyLoaded,
    ScheduleApply = scheduleApply,
    BuildPool = buildPool,
    ApplyVendor = applyVendor,
    ApplyEnemy = applyEnemy,
}
