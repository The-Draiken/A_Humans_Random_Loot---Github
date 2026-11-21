# A Human's Random Loot

A Baldur's Gate 3 mod that randomises **vendor stock** and **enemy loot**, using every item in your game, including items from your other mods. Everything is controlled from the **Mod Configuration Menu (MCM)**, so you can switch features on and off, and tune them, in game.

It also lets you **fix the prices of modded items** (many modded items cost 0 or 1 gold), set your **own price for any item**, and **block specific items** from ever showing up as random loot.

Out of the box the mod does nothing until you choose a vendor mode and/or turn on enemy loot. Nothing changes until you ask it to.

---

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick start](#quick-start)
- [How it works](#how-it-works)
- [Settings reference (MCM)](#settings-reference-mcm)
  - [General](#general)
  - [Vendors](#vendors)
  - [Enemies](#enemies)
  - [Modded Item Values](#modded-item-values)
  - [Loot Pool Filter](#loot-pool-filter)
  - [Rarity Weights by Act](#rarity-weights-by-act)
  - [Safety](#safety)
- [The Item Value Rules tab](#the-item-value-rules-tab)
- [Writing rules by hand](#writing-rules-by-hand)
- [Supported utility items](#supported-utility-items)
- [Performance](#performance)
- [FAQ and troubleshooting](#faq-and-troubleshooting)
- [Uninstalling](#uninstalling)

---

## Requirements

- [BG3 Script Extender](https://github.com/Norbyte/bg3se)
- [Mod Configuration Menu (BG3MCM)](https://www.nexusmods.com/baldursgate3/mods/9162)

## Installation

1. Install the Script Extender and Mod Configuration Menu.
2. Import `A_Humans_Random_Loot.pak` with your mod manager (for example BG3 Mod Manager).
3. Place it **below** Mod Configuration Menu in your load order and export/save the load order.
4. Start the game, open MCM (press **Insert** by default, or use the MCM button in the menu) and find **A Human's Random Loot**.

The mod adds no new items, spells or stats of its own; it only works with what is already in your game. It should be safe to add to an existing save.

## Quick start

| I want... | Turn on |
|---|---|
| Vendors to sell completely random stock | **Vendors → Random Vendor Stock** |
| Random stock, but no junk | **Vendors → Filtered Vendor Stock** |
| Vendors to keep their normal stock and get extra random items | **Vendors → Vendor++** |
| Enemies to drop random loot when they die | **Enemies → Enemy Random Loot** |
| Modded items to have sensible prices | **Modded Item Values → Correct Low-Value Modded Item Prices** |
| To change the price of one item | The **Item Value Rules** tab |

Every other setting has a sensible default you can leave alone.

---

## How it works

### Where the random items come from

The mod builds a **loot pool** from every item template the game has loaded, so items from your other mods are included automatically. It also adds items it finds in the vendor and enemy inventories it processes. Gold piles, story items and broken items are never in the pool (see [Safety](#safety)).

The pool is built once, a few seconds after a save loads, so it doesn't cause a hitch the first time something dies.

### Vendors

A vendor is randomised **when you open the trade window**. Depending on the mode you chose:

1. Their existing "safe" stock is removed (optional, see **Remove Existing Vendor Stock**).
2. They may receive a few **essential utility items** (injury kits, revive scrolls, camp supplies).
3. They receive random items from the pool. Items worth more than **your level × 100 gold** are skipped (see **Level Value Cap**).

Each vendor is only randomised **once**, so their stock does not change every time you talk to them. Vendors restock with new random items:

- after a **long rest**, or
- after you **change a setting** in MCM (unless randomisation is frozen).

### Enemies

When an enemy **dies** (or is looted), its loot is randomised:

1. Its existing safe inventory is removed (optional, see **Remove Existing Enemy Loot**).
2. It receives between **1** and **⌊enemy level ÷ Enemy Drop Scaling⌋ + 1** random items, each worth at most **enemy level × 100 gold**.

Party members, companions, vendors and (by default) bosses are never touched. Only characters that are hostile to you count as enemies, unless you turn on **Include Neutral NPCs**.

### Act detection

The mod detects which act you are in from the level you're on, and uses it for the [rarity weights](#rarity-weights-by-act), so you can make rare and legendary loot more common as the game goes on.

---

## Settings reference (MCM)

All settings are in MCM under **A Human's Random Loot → Settings**.

### General

| Setting | Default | What it does |
|---|---|---|
| **Enable Random Loot** | On | Master switch. Turn off to stop all vendor and enemy randomisation. |
| **Enable Bulk Loaded-Actor Scans** | Off | Allows the two "heavy" options below. Keep off for normal play. |
| **Apply On Load (Heavy)** | Off | When a save or level loads, randomise every vendor and enemy that is currently loaded, without waiting for you to trade or for them to die. Needs bulk scans on. |
| **Freeze Current Randomization** | Off | Locks in the loot you have now. Nothing is rerolled on load, on a settings change, on a long rest or by scans. Settings changes you make while frozen are applied when you unfreeze. |
| **Apply To New Actors While Frozen** | Off | While frozen, vendors and enemies that were **never** randomised still get randomised. Ones already done stay as they are. |
| **Watch Loaded Actors (Heavy)** | Off | Every 5 seconds, checks loaded characters for vendors and enemies that haven't been randomised yet. Needs bulk scans on. |
| **Debug Logging** | Off | Prints detailed processing information to the Script Extender console. Useful for bug reports. |

### Vendors

At least one of the first three options must be on for vendors to change.

| Setting | Default | What it does |
|---|---|---|
| **Random Vendor Stock** | Off | Replaces the vendor's safe stock with random loot. |
| **Filtered Vendor Stock** | Off | Same as above, but junk items are excluded from what the vendor gets. |
| **Vendor++** | Off | Keeps the vendor's normal stock and **adds** random items on top, once per long rest. |
| **Remove Existing Vendor Stock** | On | When Vendor++ is off, removes the vendor's safe existing stock before adding random items. Turn off to keep their stock and still add random items each restock. |
| **Duplicate Item Removal** | Off | Removes duplicate copies of non-stackable items from randomised vendors, and removes items above the level value cap. |
| **Generated Items Per Vendor** | 40 | How many random items each vendor gets (0–100). Not scaled by level. |
| **Essential Utility Stock** | On | Gives some vendors extra utility items: injury kits, revive and raise-dead scrolls, camp supplies and rest/crafting items. See [Supported utility items](#supported-utility-items). |
| **Essential Vendor Chance** | 50% | Chance that a randomised vendor gets essential utility items at all. Set to 100 if you want every vendor to carry them. |
| **Essential Items Per Vendor** | 3 | How many essential items are added when the chance succeeds (0–20). The mod rotates between **injury kits**, **revive scrolls** and **supplies**, so each type is represented before any repeats. |
| **Preserve Essential Stock** | On | Never removes utility items the vendor already sells, even when removing existing stock. |

### Enemies

| Setting | Default | What it does |
|---|---|---|
| **Enemy Random Loot** | Off | When an enemy dies, gives it random loot. |
| **Remove Existing Enemy Loot** | On | Removes the enemy's safe existing inventory before adding random loot. Turn off to keep their normal loot and add random items on top. |
| **Include Neutral NPCs** | Off | Also treats non-hostile NPCs (that aren't in your party and aren't vendors) as loot targets. |
| **Enemy Drop Scaling** | 4 | Controls how many items enemies drop: **1 to ⌊level ÷ this⌋ + 1**. Lower = more drops. With 4, a level 8 enemy drops 1–3 items, and a level 12 enemy drops 1–4. |

### Modded Item Values

Many modded items are worth 0 or 1 gold, which makes them free to buy and worthless to sell, and makes the level value cap meaningless for them. These options fix that.

| Setting | Default | What it does |
|---|---|---|
| **Correct Low-Value Modded Item Prices** | Off | Rewrites the price of modded items that are below the threshold (or have no price at all) to a price based on their rarity. |
| **Only Apply Mod List Below** | Off | **Off:** every mod is corrected, **except** the mods in the list. **On:** only the mods in the list are corrected. |
| **Mod Price Correction List** | *(empty)* | One entry per line: a mod UUID, a mod name, or part of a file path. `#` starts a comment. Empty = applies to all modded items. |
| **Low-Value Modded Threshold** | 50 | Modded items worth less than this (or with an unknown value) are corrected. |
| **Common Modded Value** | 500 | Price given to Common modded items. |
| **Uncommon Modded Value** | 650 | Price given to Uncommon modded items. |
| **Rare Modded Value** | 800 | Price given to Rare modded items. |
| **Very Rare Modded Value** | 1000 | Price given to Very Rare modded items. |
| **Legendary Modded Value** | 1500 | Price given to Legendary modded items. |
| **Individual Item Value Rules** | *(empty)* | Your per-item price rules. Easiest to manage from the [Item Value Rules tab](#the-item-value-rules-tab). |
| **Excluded Items** | *(empty)* | Items that can never appear as random loot. Also managed from the Item Value Rules tab. |

Price changes apply to the item everywhere: in your inventory, on the floor and in vendor stock. Items already sitting in a vendor's inventory are updated the next time you open that vendor's trade window. If you remove a rule or turn correction off, the original price is restored.

Base-game items are never touched by price correction. Only an individual rule can change a base-game item's price.

### Loot Pool Filter

Choose which mods' items can appear as random loot (for both vendors and enemies).

| Setting | Default | What it does |
|---|---|---|
| **Enable Loot Pool Mod Filter** | Off | Turns the filter on. When off, every item is allowed. |
| **Filter Mode** | Exclude | **Exclude:** items from the listed mods are blocked; everything else is allowed. **Include Only:** only items from the listed mods are allowed. **Vanilla Only:** only base-game items are allowed (the list is ignored). |
| **Mod Filter List** | *(empty)* | One mod UUID, mod name or file-path fragment per line. `#` for comments. An empty list in Exclude mode allows everything; an empty list in Include Only mode allows nothing. |

### Rarity Weights by Act

Off by default, so every item has the same chance. When on, each weight is the **percent chance (0–100) that an item of that rarity is accepted when it is picked**. A weight of 0 means that rarity (almost) never appears; 100 means it is always accepted.

| Rarity | Act 1 | Act 2 | Act 3 |
|---|---|---|---|
| Common | 50 | 30 | 20 |
| Uncommon | 30 | 30 | 25 |
| Rare | 15 | 25 | 30 |
| Very Rare | 4 | 10 | 15 |
| Legendary | 1 | 5 | 10 |

With the defaults, loot gets steadily better from Act 1 to Act 3.

### Safety

| Setting | Default | What it does |
|---|---|---|
| **Protect Story Items** | On | Never removes or gives quest items, story items, keys, letters, notes, books, containers, the Netherstones, the Astral Prism, Orphic items, Blood of Lathander, tadpoles and other plot-critical items. |
| **Skip Broken Items** | On | Never gives items that are confirmed broken: items whose name shows as "Not Found", items whose 3D model doesn't exist (they show as a placeholder model), and items that cast a spell that doesn't exist (which can crash the dice-roll screen). Each skipped item is listed, with the reason, in `Script Extender/A_Humans_Random_Loot/skipped_broken_items.txt`. The check tests itself on base-game items first and switches off any part of itself that doesn't work in your game version, so it can never empty the loot pool. |
| **Protect Bosses** | On | Never touches boss inventories. |
| **Block Combinable Results** | On | Items you've created by combining two items are kept out of the loot pool. |
| **Level Value Cap** | On | Vendor items are capped at **your level × 100 gold**, enemy items at **the enemy's level × 100 gold**. Items worth more are skipped. |
| **Allow Template-Only Items** | On | Allows items that have no known price yet. Turn off to only allow items with a known price. |
| **Include Junk** | On | Allows junk items in the loot pool. Filtered Vendor Stock always excludes junk for vendors. |

---

## The Item Value Rules tab

MCM has a second tab for this mod, **Item Value Rules**, where you can find any item in your game and change how it's handled, with no typing of rules needed.

1. Open **MCM → A Human's Random Loot → Item Value Rules**.
2. **Search** by the item's name or its internal StatName (the search tolerates small typos), **or** pick a mod from the **dropdown** to list that mod's items.
3. Up to 250 matching items are shown, with their icon, name, StatName and current price.

For each item you can:

| Column | What it does |
|---|---|
| **Keep** | Locks the item at its **original** price, so price correction never changes it. |
| **Custom** | Type a price and press **Set** to give the item that exact price. **Clear** removes the rule. |
| **No Vendor** | The item never appears as random vendor stock. |
| **No Enemy** | The item never appears as random enemy loot. |

Changes are saved into the **Individual Item Value Rules** and **Excluded Items** settings for you. If a newly installed mod's items don't show up, press **Refresh Item List**.

## Writing rules by hand

You can also type rules straight into the text settings. Put one rule per line (or separate rules with `;`). Lines starting with `#` are comments.

**Individual Item Value Rules**

```
# Give an item an exact price
ARM_Boots_Leather=1200
WPN_Longsword : 350

# Keep an item at its original price (also accepts keep, original or current)
OBJ_Potion_Healing=lock
```

**Excluded Items**

```
# Never sold by vendors
OBJ_Scroll_Fireball=vendor
# Never dropped by enemies
WPN_Greatsword=enemy
# Never appears anywhere
OBJ_Potion_Healing_Greater=both
```

The names above are only examples. Use the item's StatName (shown in brackets in the Item Value Rules tab) or its root template ID.

---

## Supported utility items

The **Essential Utility Stock** options recognise these items, if the base game or the relevant mod provides them:

- **Injury kits:** Grit and Glory injury kits.
- **Revive and raise-dead scrolls:** base-game Scroll of Revivify and True Resurrection, plus Damage Destruction's revive and raise-dead scrolls.
- **Supplies:** base-game camp supply packs and rations, Rest System supply packs, and APC's Rest System tools and crafting items (saw, toolkit, nails, flint, bench, stool, scroll-crafting kit and similar).

If a mod isn't installed, its items are simply skipped.

## Performance

The mod is designed to be light during normal play:

- It only does work when you **open a trade window** or an **enemy dies**, not constantly.
- The loot pool is built **once** after loading, and each loot roll checks only the few items it picks, not your whole item list.
- Price correction runs **once per session** (and again only when you change a price setting).
- The searchable item list for the Item Value Rules tab is only built when you open that tab.

The only costly options are the ones marked **(Heavy)**, which are off by default.

## FAQ and troubleshooting

**Nothing changed at a vendor.**
Make sure **Enable Random Loot** is on and at least one vendor mode (**Random Vendor Stock**, **Filtered Vendor Stock** or **Vendor++**) is on. A vendor that was already randomised won't change again until you long rest or change a setting. Also check that **Freeze Current Randomization** is off.

**Enemies drop nothing new.**
Turn on **Enemy Random Loot**. Bosses are skipped unless you turn off **Protect Bosses**, and neutral NPCs are skipped unless you turn on **Include Neutral NPCs**.

**Vendors only sell cheap items early on.**
That's the **Level Value Cap** (your level × 100 gold). It keeps you from buying endgame gear at level 2. Turn it off for no cap.

**I changed a price but the vendor still shows the old one.**
Close and reopen that vendor's trade window. Items in vendor stock are updated when the trade opens.

**An item keeps showing up that I don't want.**
Find it in the **Item Value Rules** tab and tick **No Vendor** and/or **No Enemy**.

**I want to see what was skipped as broken.**
Open `Script Extender/A_Humans_Random_Loot/skipped_broken_items.txt` (in your BG3 Script Extender data folder, usually `%LOCALAPPDATA%\Larian Studios\Baldur's Gate 3\Script Extender`).

**Reporting a bug.**
Turn on **Debug Logging**, reproduce the problem, and include the Script Extender console log with your report. You can comment and report stuff to me here: https://rpghq.org/forums/viewtopic.php?p=434169-a-human-s-random-loot-4-0-baldur-s-gate-3 , be aware of what kind of site the place is though, people are unhinged there so if you are heavily bothered by that stuff I advise just to only keep to my Threads and don't start searching through the whole Website.

## Uninstalling

Items the mod has already placed in vendor and enemy inventories, or that you've picked up, stay in your save; they are normal game items. To be safe, turn off **Correct Low-Value Modded Item Prices** and clear your **Individual Item Value Rules** before uninstalling, so original prices are restored, then save, quit and remove the mod.
