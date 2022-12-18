local _, L = ...
local DEBUG_PF = false
function T(str)
	return L[str]
end

-- key binding interface constants
BINDING_HEADER_PREMADEFILTER = "Premade Filter"
BINDING_NAME_PREMADEFILTER_SEARCH = "Trigger background search"

MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES = 1000
LFG_LIST_FRESH_FONT_COLOR = { r = 0.3, g = 0.9, b = 0.3 }

local COLOR_RESET = "|r"
local COLOR_GRAY = "|cffbbbbbb"
local COLOR_BLUE = "|cff88ccff"
local COLOR_GREEN = "|cff88ff88"
local COLOR_ORANGE = "|cffffaa66"

table.insert(UIChildWindows, "PremadeFilter_Frame")

local PremadeFilter_DefaultSettings = {
	Version = GetAddOnMetadata("premade-filter", "Version"),
	UpdateInterval = 15,
	ChatNotifications = nil,
	NewGroupChatNotifications = true,
	NewPlayerChatNotifications = true,
	ScrollOnTop = false,
}

local PremadeFilter_ActivityInfo = {

	--Classic
	["3-0-9"] = { tier = 1, instance = 1, raid = true }, --Molten Core
	["3-0-293"] = { tier = 1, instance = 2, raid = true }, --Blackwing Lair
	["3-0-294"] = { tier = 1, instance = 3, raid = true }, --Ruins of Ahn'Qiraj
	["3-0-295"] = { tier = 1, instance = 4, raid = true }, --Temple of Ahn'Qiraj

	--BC
	["3-0-45"] = { tier = 2, instance = 1, raid = true }, --Karazhan
	["3-0-296"] = { tier = 2, instance = 2, raid = true }, --Gruul's Lair
	["3-0-297"] = { tier = 2, instance = 3, raid = true }, --Magtheridon's Lair
	["3-0-298"] = { tier = 2, instance = 4, raid = true }, --Serpentshrine Cavern
	["3-0-299"] = { tier = 2, instance = 5, raid = true }, --Tempest Keep
	["3-0-300"] = { tier = 2, instance = 7, raid = true }, --Black Temple
	["3-0-301"] = { tier = 2, instance = 8, raid = true }, --Sunwell Plateau

	--WotLK
	["3-16-43"] = { tier = 3, instance = 2, raid = true, difficulty = 3 }, --Naxxramas 10
	["3-16-44"] = { tier = 3, instance = 2, raid = true, difficulty = 4 }, --Naxxramas 25

	["3-72-302"] = { tier = 3, instance = 5, raid = true, difficulty = 3 }, --Ulduar 10
	["3-72-303"] = { tier = 3, instance = 5, raid = true, difficulty = 4 }, --Ulduar 25

	["3-73-304"] = { tier = 3, instance = 6, raid = true, difficulty = 3 }, --Trial of the Crusader Normal 10
	["3-73-305"] = { tier = 3, instance = 6, raid = true, difficulty = 5 }, --Trial of the Crusader Heroic 10
	["3-73-306"] = { tier = 3, instance = 6, raid = true, difficulty = 4 }, --Trial of the Crusader Normal 25
	["3-73-307"] = { tier = 3, instance = 6, raid = true, difficulty = 6 }, --Trial of the Crusader Heroic 25

	["3-17-46"] = { tier = 3, instance = 8, raid = true, difficulty = 3 }, --Icecrown Citadel Normal 10
	["3-17-47"] = { tier = 3, instance = 8, raid = true, difficulty = 5 }, --Icecrown Citadel Heroic 10
	["3-17-48"] = { tier = 3, instance = 8, raid = true, difficulty = 4 }, --Icecrown Citadel Normal 25
	["3-17-49"] = { tier = 3, instance = 8, raid = true, difficulty = 6 }, --Icecrown Citadel Heroic 25

	["3-74-308"] = { tier = 3, instance = 9, raid = true, difficulty = 3 }, --The Ruby Sanctum Normal 10
	["3-74-309"] = { tier = 3, instance = 9, raid = true, difficulty = 5 }, --The Ruby Sanctum Heroic 10
	["3-74-310"] = { tier = 3, instance = 9, raid = true, difficulty = 4 }, --The Ruby Sanctum Normal 25
	["3-74-311"] = { tier = 3, instance = 9, raid = true, difficulty = 6 }, --The Ruby Sanctum Heroic 25

	--Cataclysm
	["3-76-319"] = { tier = 4, instance = 2, raid = true, difficulty = 3 }, --The Bastion of Twilight Normal 10
	["3-76-322"] = { tier = 4, instance = 2, raid = true, difficulty = 4 }, --The Bastion of Twilight Normal 25
	["3-76-320"] = { tier = 4, instance = 2, raid = true, difficulty = 5 }, --The Bastion of Twilight Heroic 10
	["3-76-321"] = { tier = 4, instance = 2, raid = true, difficulty = 6 }, --The Bastion of Twilight Heroic 25

	["3-75-313"] = { tier = 4, instance = 3, raid = true, difficulty = 3 }, --Blackwing Descent Normal 10
	["3-75-316"] = { tier = 4, instance = 3, raid = true, difficulty = 4 }, --Blackwing Descent Normal 25
	["3-75-317"] = { tier = 4, instance = 3, raid = true, difficulty = 5 }, --Blackwing Descent Heroic 10
	["3-75-318"] = { tier = 4, instance = 3, raid = true, difficulty = 6 }, --Blackwing Descent Heroic 25

	["3-77-323"] = { tier = 4, instance = 4, raid = true, difficulty = 3 }, --Throne of the Four Winds Normal 10
	["3-77-326"] = { tier = 4, instance = 4, raid = true, difficulty = 4 }, --Throne of the Four Winds Normal 25
	["3-77-324"] = { tier = 4, instance = 4, raid = true, difficulty = 5 }, --Throne of the Four Winds Heroic 10
	["3-77-325"] = { tier = 4, instance = 4, raid = true, difficulty = 6 }, --Throne of the Four Winds Heroic 25

	["3-78-327"] = { tier = 4, instance = 5, raid = true, difficulty = 3 }, --Firelands Normal 10
	["3-78-329"] = { tier = 4, instance = 5, raid = true, difficulty = 4 }, --Firelands Normal 25
	["3-78-328"] = { tier = 4, instance = 5, raid = true, difficulty = 5 }, --Firelands Heroic 10
	["3-78-330"] = { tier = 4, instance = 5, raid = true, difficulty = 6 }, --Firelands Heroic 25

	["3-79-331"] = { tier = 4, instance = 6, raid = true, difficulty = 3 }, --Dragon Soul Normal 10
	["3-79-332"] = { tier = 4, instance = 6, raid = true, difficulty = 5 }, --Dragon Soul Heroic 10
	["3-79-333"] = { tier = 4, instance = 6, raid = true, difficulty = 6 }, --Dragon Soul Heroic 25
	["3-79-334"] = { tier = 4, instance = 6, raid = true, difficulty = 4 }, --Dragon Soul Normal 25

	--MoP
	["3-0-397"] = { tier = 5, instance = 1, raid = true }, --Outdoor MoP

	["3-80-335"] = { tier = 5, instance = 2, raid = true, difficulty = 3 }, --Mogu'shan Vaults Normal 10
	["3-80-336"] = { tier = 5, instance = 2, raid = true, difficulty = 5 }, --Mogu'shan Vaults Heroic 10
	["3-80-337"] = { tier = 5, instance = 2, raid = true, difficulty = 4 }, --Mogu'shan Vaults Normal 25
	["3-80-338"] = { tier = 5, instance = 2, raid = true, difficulty = 6 }, --Mogu'shan Vaults Heroic 25

	["3-81-339"] = { tier = 5, instance = 3, raid = true, difficulty = 3 }, --Heart of Fear Normal 10
	["3-81-340"] = { tier = 5, instance = 3, raid = true, difficulty = 5 }, --Heart of Fear Heroic 10
	["3-81-341"] = { tier = 5, instance = 3, raid = true, difficulty = 4 }, --Heart of Fear Normal 25
	["3-81-342"] = { tier = 5, instance = 3, raid = true, difficulty = 6 }, --Heart of Fear Heroic 25

	["3-82-343"] = { tier = 5, instance = 4, raid = true, difficulty = 3 }, --Terrace of Endless Spring Normal 10
	["3-82-344"] = { tier = 5, instance = 4, raid = true, difficulty = 5 }, --Terrace of Endless Spring Heroic 10
	["3-82-345"] = { tier = 5, instance = 4, raid = true, difficulty = 4 }, --Terrace of Endless Spring Normal 25
	["3-82-346"] = { tier = 5, instance = 4, raid = true, difficulty = 6 }, --Terrace of Endless Spring Heroic 25

	["3-83-347"] = { tier = 5, instance = 5, raid = true, difficulty = 3 }, --Throne of Thunder Normal 10
	["3-83-348"] = { tier = 5, instance = 5, raid = true, difficulty = 5 }, --Throne of Thunder Heroic 10
	["3-83-349"] = { tier = 5, instance = 5, raid = true, difficulty = 6 }, --Throne of Thunder Heroic 25
	["3-83-350"] = { tier = 5, instance = 5, raid = true, difficulty = 4 }, --Throne of Thunder Normal 25

	["3-1-4"] = { tier = 5, instance = 6, raid = true, difficulty = 14 }, --Siege of Orgrimmar Normal
	["3-1-41"] = { tier = 5, instance = 6, raid = true, difficulty = 15 }, --Siege of Orgrimmar Heroic
	["3-1-42"] = { tier = 5, instance = 6, raid = true, difficulty = 16 }, --Siege of Orgrimmar Mythic

	--WoD
	["3-0-398"] = { tier = 6, instance = 1, raid = true }, --Outdoor WoD

	["3-14-37"] = { tier = 6, instance = 2, raid = true, difficulty = 14 }, --Highmaul Normal
	["3-14-38"] = { tier = 6, instance = 2, raid = true, difficulty = 15 }, --Highmaul Heroic
	["3-14-399"] = { tier = 6, instance = 2, raid = true, difficulty = 16 }, --Highmaul Mythic

	["3-15-39"] = { tier = 6, instance = 3, raid = true, difficulty = 14 }, --Blackrock Foundry Normal
	["3-15-40"] = { tier = 6, instance = 3, raid = true, difficulty = 15 }, --Blackrock Foundry Heroic
	["3-15-400"] = { tier = 6, instance = 3, raid = true, difficulty = 16 }, --Blackrock Foundry Mythic

	["3-110-409"] = { tier = 6, instance = 4, raid = true, difficulty = 14 }, --Hellfire Citadel Normal
	["3-110-410"] = { tier = 6, instance = 4, raid = true, difficulty = 15 }, --Hellfire Citadel Heroic
	["3-110-412"] = { tier = 6, instance = 4, raid = true, difficulty = 16 }, --Hellfire Citadel Mythic

	--Legion
	["3-0-458"] = { tier = 7, instance = 1, raid = true }, -- Outdoor Legion

	["3-122-413"] = { tier = 7, instance = 2, raid = true, difficulty = 14 }, -- Emerald Nightmare Normal
	["3-122-414"] = { tier = 7, instance = 2, raid = true, difficulty = 15 }, -- Emerald Nightmare Heroic
	["3-122-468"] = { tier = 7, instance = 2, raid = true, difficulty = 16 }, -- Emerald Nightmare Mythic

	["3-126-456"] = { tier = 7, instance = 3, raid = true, difficulty = 14 }, -- TOV Normal
	["3-126-457"] = { tier = 7, instance = 3, raid = true, difficulty = 15 }, -- TOV Heroic
	["3-126-480"] = { tier = 7, instance = 3, raid = true, difficulty = 16 }, -- TOV Mythic

	["3-123-415"] = { tier = 7, instance = 4, raid = true, difficulty = 14 }, -- Nighthold Normal
	["3-123-416"] = { tier = 7, instance = 4, raid = true, difficulty = 15 }, -- Nighthold Heroic
	["3-123-481"] = { tier = 7, instance = 4, raid = true, difficulty = 16 }, -- Nighthold Mythic

	["3-131-479"] = { tier = 7, instance = 5, raid = true, difficulty = 14 }, -- ToS Normal
	["3-131-478"] = { tier = 7, instance = 5, raid = true, difficulty = 15 }, -- ToS Heroic
	["3-131-492"] = { tier = 7, instance = 5, raid = true, difficulty = 16 }, -- ToS Mythic

	["3-132-482"] = { tier = 7, instance = 6, raid = true, difficulty = 14 }, -- AtBT Normal
	["3-132-483"] = { tier = 7, instance = 6, raid = true, difficulty = 15 }, -- AtBT Heroic
	["3-132-493"] = { tier = 7, instance = 6, raid = true, difficulty = 16 }, -- AtBT Mythic

	--BfA
	["3-0-657"] = { tier = 8, instance = 1, raid = true }, -- Outdoor BfA

	["3-135-494"] = { tier = 8, instance = 2, raid = true, difficulty = 14 }, -- Uldir Normal
	["3-135-495"] = { tier = 8, instance = 2, raid = true, difficulty = 15 }, -- Uldir Heroic
	["3-135-496"] = { tier = 8, instance = 2, raid = true, difficulty = 16 }, -- Uldir Mythic

	["3-251-663"] = { tier = 8, instance = 3, raid = true, difficulty = 14 }, -- Battle of Dazar'alor Normal
	["3-251-664"] = { tier = 8, instance = 3, raid = true, difficulty = 15 }, -- Battle of Dazar'alor Heroic
	["3-251-665"] = { tier = 8, instance = 3, raid = true, difficulty = 16 }, -- Battle of Dazar'alor Mythic

	["3-252-668"] = { tier = 8, instance = 4, raid = true, difficulty = 14 }, -- Crucible of Storms Normal
	["3-252-667"] = { tier = 8, instance = 4, raid = true, difficulty = 15 }, -- Crucible of Storms Heroic
	["3-252-666"] = { tier = 8, instance = 4, raid = true, difficulty = 16 }, -- Crucible of Storms Mythic

	["3-254-672"] = { tier = 8, instance = 5, raid = true, difficulty = 14 }, -- The Eternal Palace Normal
	["3-254-671"] = { tier = 8, instance = 5, raid = true, difficulty = 15 }, -- The Eternal Palace Heroic
	["3-254-670"] = { tier = 8, instance = 5, raid = true, difficulty = 16 }, -- The Eternal Palace Mythic

	["3-258-687"] = { tier = 8, instance = 6, raid = true, difficulty = 14 }, -- Ny'alotha Normal
	["3-258-686"] = { tier = 8, instance = 6, raid = true, difficulty = 15 }, -- Ny'alotha Heroic
	["3-258-685"] = { tier = 8, instance = 6, raid = true, difficulty = 16 }, -- Ny'alotha Mythic

	--Shadowlands
	["3-0-723"] = { tier = 9, instance = 1, raid = true }, -- Outdoor Shadowlands

	["3-267-720"] = { tier = 9, instance = 2, raid = true, difficulty = 14 }, --Castle Nathria Normal
	["3-267-722"] = { tier = 9, instance = 2, raid = true, difficulty = 15 }, --Castle Nathria Heroic
	["3-267-721"] = { tier = 9, instance = 2, raid = true, difficulty = 16 }, --Castle Nathria Mythic

	["3-271-743"] = { tier = 9, instance = 3, raid = true, difficulty = 14 }, --Sanctum of Domination Normal
	["3-271-744"] = { tier = 9, instance = 3, raid = true, difficulty = 15 }, --Sanctum of Domination Heroic
	["3-271-745"] = { tier = 9, instance = 3, raid = true, difficulty = 16 }, --Sanctum of Domination Mythic

	["3-282-1020"] = { tier = 9, instance = 4, raid = true, difficulty = 14 }, --Sepulcher of the First Ones Normal
	["3-282-1021"] = { tier = 9, instance = 4, raid = true, difficulty = 15 }, --Sepulcher of the First Ones Heroic
	["3-282-1022"] = { tier = 9, instance = 4, raid = true, difficulty = 16 }, --Sepulcher of the First Ones Mythic

	--Dragonflight
	["3-0-1146"] = { tier = 10, instance = 1, raid = true }, -- Outdoor Dragonflight
	
	["3-310-1189"] = { tier = 10, instance = 2, raid = true, difficulty = 14 }, --Vault of the Incarnates Normal
	["3-310-1190"] = { tier = 10, instance = 2, raid = true, difficulty = 15 }, --Vault of the Incarnates Heroic
	["3-310-1191"] = { tier = 10, instance = 2, raid = true, difficulty = 16 }, --Vault of the Incarnates Mythic
}

local PremadeFilter_RealmChapters = {
	-- US
	{ "Oceania", "Pacific", "Mountain", "Central", "Eastern", "Latin America", "Brazil" },

	-- Korea
	{ "한국" },

	-- EU
	{ "English", "French", "German", "Russian", "Spanish", "Portuguese", "Italian" },

	-- Taiwan
	{ "台灣" },

	-- China
	{ "五区", "三区", "二区", "推荐服务器", "十区", "一区" },
}

local PremadeFilter_Realms = {
	-- US
	-- Oceania
	{ name = "Aman'Thul", region = 1, chapter = 1 },
	{ name = "Barthilas", region = 1, chapter = 1 },
	{ name = "Caelestrasz", region = 1, chapter = 1 },
	{ name = "Dath'Remar", region = 1, chapter = 1 },
	{ name = "Dreadmaul", region = 1, chapter = 1 },
	{ name = "Frostmourne", region = 1, chapter = 1 },
	{ name = "Gundrak", region = 1, chapter = 1 },
	{ name = "Jubei'Thos", region = 1, chapter = 1 },
	{ name = "Khaz'goroth", region = 1, chapter = 1 },
	{ name = "Nagrand", region = 1, chapter = 1 },
	{ name = "Saurfang", region = 1, chapter = 1 },
	{ name = "Thaurissan", region = 1, chapter = 1 },

	-- Pacific
	{ name = "Aerie Peak", region = 1, chapter = 2 },
	{ name = "Akama", region = 1, chapter = 2 },
	{ name = "Antonidas", region = 1, chapter = 2 },
	{ name = "Baelgun", region = 1, chapter = 2 },
	{ name = "Borean Tundra", region = 1, chapter = 2 },
	{ name = "Bronzebeard", region = 1, chapter = 2 },
	{ name = "Cairne", region = 1, chapter = 2 },
	{ name = "Cenarius", region = 1, chapter = 2 },
	{ name = "Coilfang", region = 1, chapter = 2 },
	{ name = "Dalvengyr", region = 1, chapter = 2 },
	{ name = "Dark Iron", region = 1, chapter = 2 },
	{ name = "Darrowmere", region = 1, chapter = 2 },
	{ name = "Deathwing", region = 1, chapter = 2 },
	{ name = "Demon Soul", region = 1, chapter = 2 },
	{ name = "Doomhammer", region = 1, chapter = 2 },
	{ name = "Draenor", region = 1, chapter = 2 },
	{ name = "Dragonblight", region = 1, chapter = 2 },
	{ name = "Dragonmaw", region = 1, chapter = 2 },
	{ name = "Drak'thul", region = 1, chapter = 2 },
	{ name = "Draka", region = 1, chapter = 2 },
	{ name = "Echo Isles", region = 1, chapter = 2 },
	{ name = "Eldre'Thalas", region = 1, chapter = 2 },
	{ name = "Executus", region = 1, chapter = 2 },
	{ name = "Farstriders", region = 1, chapter = 2 },
	{ name = "Feathermoon", region = 1, chapter = 2 },
	{ name = "Fenris", region = 1, chapter = 2 },
	{ name = "Frostmane", region = 1, chapter = 2 },
	{ name = "Hydraxis", region = 1, chapter = 2 },
	{ name = "Hyjal", region = 1, chapter = 2 },
	{ name = "Kalecgos", region = 1, chapter = 2 },
	{ name = "Kil'jaeden", region = 1, chapter = 2 },
	{ name = "Kilrogg", region = 1, chapter = 2 },
	{ name = "Korgath", region = 1, chapter = 2 },
	{ name = "Korialstrasz", region = 1, chapter = 2 },
	{ name = "Lightbringer", region = 1, chapter = 2 },
	{ name = "Mok'Nathal", region = 1, chapter = 2 },
	{ name = "Mug'thol", region = 1, chapter = 2 },
	{ name = "Ner'zhul", region = 1, chapter = 2 },
	{ name = "Perenolde", region = 1, chapter = 2 },
	{ name = "Proudmoore", region = 1, chapter = 2 },
	{ name = "Scarlet Crusade", region = 1, chapter = 2 },
	{ name = "Shadowsong", region = 1, chapter = 2 },
	{ name = "Shandris", region = 1, chapter = 2 },
	{ name = "Shattered Halls", region = 1, chapter = 2 },
	{ name = "Shattered Hand", region = 1, chapter = 2 },
	{ name = "Silver Hand", region = 1, chapter = 2 },
	{ name = "Silvermoon", region = 1, chapter = 2 },
	{ name = "Skywall", region = 1, chapter = 2 },
	{ name = "Suramar", region = 1, chapter = 2 },
	{ name = "Terenas", region = 1, chapter = 2 },
	{ name = "Thorium Brotherhood", region = 1, chapter = 2 },
	{ name = "Tichondrius", region = 1, chapter = 2 },
	{ name = "Tortheldrin", region = 1, chapter = 2 },
	{ name = "Uldum", region = 1, chapter = 2 },
	{ name = "Windrunner", region = 1, chapter = 2 },
	{ name = "Winterhoof", region = 1, chapter = 2 },
	{ name = "Wyrmrest Accord", region = 1, chapter = 2 },

	-- Mountain
	{ name = "Azjol-Nerub", region = 1, chapter = 3 },
	{ name = "Blackrock", region = 1, chapter = 3 },
	{ name = "Blackwater Raiders", region = 1, chapter = 3 },
	{ name = "Cenarion Circle", region = 1, chapter = 3 },
	{ name = "Darkspear", region = 1, chapter = 3 },
	{ name = "Kel'Thuzad", region = 1, chapter = 3 },
	{ name = "Khaz Modan", region = 1, chapter = 3 },
	{ name = "Muradin", region = 1, chapter = 3 },
	{ name = "Nordrassil", region = 1, chapter = 3 },
	{ name = "Shadow Council", region = 1, chapter = 3 },
	{ name = "Sisters of Elune", region = 1, chapter = 3 },

	-- Central
	{ name = "Aegwynn", region = 1, chapter = 4 },
	{ name = "Agamaggan", region = 1, chapter = 4 },
	{ name = "Aggramar", region = 1, chapter = 4 },
	{ name = "Alexstrasza", region = 1, chapter = 4 },
	{ name = "Alleria", region = 1, chapter = 4 },
	{ name = "Anub'arak", region = 1, chapter = 4 },
	{ name = "Arathor", region = 1, chapter = 4 },
	{ name = "Archimonde", region = 1, chapter = 4 },
	{ name = "Azgalor", region = 1, chapter = 4 },
	{ name = "Azshara", region = 1, chapter = 4 },
	{ name = "Azuremyst", region = 1, chapter = 4 },
	{ name = "Blackhand", region = 1, chapter = 4 },
	{ name = "Blackwing Lair", region = 1, chapter = 4 },
	{ name = "Blade's Edge", region = 1, chapter = 4 },
	{ name = "Bladefist", region = 1, chapter = 4 },
	{ name = "Blood Furnace", region = 1, chapter = 4 },
	{ name = "Bloodscalp", region = 1, chapter = 4 },
	{ name = "Bonechewer", region = 1, chapter = 4 },
	{ name = "Boulderfist", region = 1, chapter = 4 },
	{ name = "Burning Blade", region = 1, chapter = 4 },
	{ name = "Burning Legion", region = 1, chapter = 4 },
	{ name = "Chromaggus", region = 1, chapter = 4 },
	{ name = "Crushridge", region = 1, chapter = 4 },
	{ name = "Daggerspine", region = 1, chapter = 4 },
	{ name = "Dawnbringer", region = 1, chapter = 4 },
	{ name = "Dentarg", region = 1, chapter = 4 },
	{ name = "Destromath", region = 1, chapter = 4 },
	{ name = "Dethecus", region = 1, chapter = 4 },
	{ name = "Detheroc", region = 1, chapter = 4 },
	{ name = "Drenden", region = 1, chapter = 4 },
	{ name = "Dunemaul", region = 1, chapter = 4 },
	{ name = "Eitrigg", region = 1, chapter = 4 },
	{ name = "Emerald Dream", region = 1, chapter = 4 },
	{ name = "Eredar", region = 1, chapter = 4 },
	{ name = "Exodar", region = 1, chapter = 4 },
	{ name = "Fizzcrank", region = 1, chapter = 4 },
	{ name = "Galakrond", region = 1, chapter = 4 },
	{ name = "Garithos", region = 1, chapter = 4 },
	{ name = "Garona", region = 1, chapter = 4 },
	{ name = "Garrosh", region = 1, chapter = 4 },
	{ name = "Gorefiend", region = 1, chapter = 4 },
	{ name = "Greymane", region = 1, chapter = 4 },
	{ name = "Gurubashi", region = 1, chapter = 4 },
	{ name = "Hakkar", region = 1, chapter = 4 },
	{ name = "Haomarush", region = 1, chapter = 4 },
	{ name = "Hellscream", region = 1, chapter = 4 },
	{ name = "Icecrown", region = 1, chapter = 4 },
	{ name = "Illidan", region = 1, chapter = 4 },
	{ name = "Jaedenar", region = 1, chapter = 4 },
	{ name = "Kargath", region = 1, chapter = 4 },
	{ name = "Khadgar", region = 1, chapter = 4 },
	{ name = "Kirin Tor", region = 1, chapter = 4 },
	{ name = "Kul Tiras", region = 1, chapter = 4 },
	{ name = "Lethon", region = 1, chapter = 4 },
	{ name = "Lightning's Blade", region = 1, chapter = 4 },
	{ name = "Lightninghoof", region = 1, chapter = 4 },
	{ name = "Madoran", region = 1, chapter = 4 },
	{ name = "Maelstrom", region = 1, chapter = 4 },
	{ name = "Maiev", region = 1, chapter = 4 },
	{ name = "Mal'Ganis", region = 1, chapter = 4 },
	{ name = "Malygos", region = 1, chapter = 4 },
	{ name = "Mannoroth", region = 1, chapter = 4 },
	{ name = "Medivh", region = 1, chapter = 4 },
	{ name = "Misha", region = 1, chapter = 4 },
	{ name = "Moon Guard", region = 1, chapter = 4 },
	{ name = "Nathrezim", region = 1, chapter = 4 },
	{ name = "Nazgrel", region = 1, chapter = 4 },
	{ name = "Nazjatar", region = 1, chapter = 4 },
	{ name = "Nesingwary", region = 1, chapter = 4 },
	{ name = "Norgannon", region = 1, chapter = 4 },
	{ name = "Onyxia", region = 1, chapter = 4 },
	{ name = "Quel'dorei", region = 1, chapter = 4 },
	{ name = "Ravencrest", region = 1, chapter = 4 },
	{ name = "Ravenholdt", region = 1, chapter = 4 },
	{ name = "Rexxar", region = 1, chapter = 4 },
	{ name = "Runetotem", region = 1, chapter = 4 },
	{ name = "Sargeras", region = 1, chapter = 4 },
	{ name = "Sen'jin", region = 1, chapter = 4 },
	{ name = "Sentinels", region = 1, chapter = 4 },
	{ name = "Shadowmoon", region = 1, chapter = 4 },
	{ name = "Shu'halo", region = 1, chapter = 4 },
	{ name = "Smolderthorn", region = 1, chapter = 4 },
	{ name = "Spinebreaker", region = 1, chapter = 4 },
	{ name = "Staghelm", region = 1, chapter = 4 },
	{ name = "Steamwheedle Cartel", region = 1, chapter = 4 },
	{ name = "Stonemaul", region = 1, chapter = 4 },
	{ name = "Stormreaver", region = 1, chapter = 4 },
	{ name = "Tanaris", region = 1, chapter = 4 },
	{ name = "Terokkar", region = 1, chapter = 4 },
	{ name = "The Underbog", region = 1, chapter = 4 },
	{ name = "The Venture Co", region = 1, chapter = 4 },
	{ name = "Thunderhorn", region = 1, chapter = 4 },
	{ name = "Thunderlord", region = 1, chapter = 4 },
	{ name = "Twisting Nether", region = 1, chapter = 4 },
	{ name = "Uldaman", region = 1, chapter = 4 },
	{ name = "Uther", region = 1, chapter = 4 },
	{ name = "Vek'nilash", region = 1, chapter = 4 },
	{ name = "Whisperwind", region = 1, chapter = 4 },
	{ name = "Wildhammer", region = 1, chapter = 4 },
	{ name = "Zangarmarsh", region = 1, chapter = 4 },

	-- Eastern
	{ name = "Altar of Storms", region = 1, chapter = 5 },
	{ name = "Alterac Mountains", region = 1, chapter = 5 },
	{ name = "Andorhal", region = 1, chapter = 5 },
	{ name = "Anetheron", region = 1, chapter = 5 },
	{ name = "Anvilmar", region = 1, chapter = 5 },
	{ name = "Area 52", region = 1, chapter = 5 },
	{ name = "Argent Dawn", region = 1, chapter = 5 },
	{ name = "Arthas", region = 1, chapter = 5 },
	{ name = "Arygos", region = 1, chapter = 5 },
	{ name = "Auchindoun", region = 1, chapter = 5 },
	{ name = "Balnazzar", region = 1, chapter = 5 },
	{ name = "Black Dragonflight", region = 1, chapter = 5 },
	{ name = "Bleeding Hollow", region = 1, chapter = 5 },
	{ name = "Bloodhoof", region = 1, chapter = 5 },
	{ name = "Cho'gall", region = 1, chapter = 5 },
	{ name = "Dalaran", region = 1, chapter = 5 },
	{ name = "Drak'Tharon", region = 1, chapter = 5 },
	{ name = "Durotan", region = 1, chapter = 5 },
	{ name = "Duskwood", region = 1, chapter = 5 },
	{ name = "Earthen Ring", region = 1, chapter = 5 },
	{ name = "Elune", region = 1, chapter = 5 },
	{ name = "Eonar", region = 1, chapter = 5 },
	{ name = "Firetree", region = 1, chapter = 5 },
	{ name = "Frostwolf", region = 1, chapter = 5 },
	{ name = "Ghostlands", region = 1, chapter = 5 },
	{ name = "Gilneas", region = 1, chapter = 5 },
	{ name = "Gnomeregan", region = 1, chapter = 5 },
	{ name = "Gorgonnash", region = 1, chapter = 5 },
	{ name = "Grizzly Hills", region = 1, chapter = 5 },
	{ name = "Gul'dan", region = 1, chapter = 5 },
	{ name = "Kael'thas", region = 1, chapter = 5 },
	{ name = "Laughing Skull", region = 1, chapter = 5 },
	{ name = "Llane", region = 1, chapter = 5 },
	{ name = "Lothar", region = 1, chapter = 5 },
	{ name = "Magtheridon", region = 1, chapter = 5 },
	{ name = "Malfurion", region = 1, chapter = 5 },
	{ name = "Malorne", region = 1, chapter = 5 },
	{ name = "Moonrunner", region = 1, chapter = 5 },
	{ name = "Rivendare", region = 1, chapter = 5 },
	{ name = "Scilla", region = 1, chapter = 5 },
	{ name = "Skullcrusher", region = 1, chapter = 5 },
	{ name = "Spirestone", region = 1, chapter = 5 },
	{ name = "Stormrage", region = 1, chapter = 5 },
	{ name = "Stormscale", region = 1, chapter = 5 },
	{ name = "The Forgotten Coast", region = 1, chapter = 5 },
	{ name = "The Scryers", region = 1, chapter = 5 },
	{ name = "Thrall", region = 1, chapter = 5 },
	{ name = "Trollbane", region = 1, chapter = 5 },
	{ name = "Turalyon", region = 1, chapter = 5 },
	{ name = "Undermine", region = 1, chapter = 5 },
	{ name = "Ursin", region = 1, chapter = 5 },
	{ name = "Vashj", region = 1, chapter = 5 },
	{ name = "Velen", region = 1, chapter = 5 },
	{ name = "Warsong", region = 1, chapter = 5 },
	{ name = "Ysera", region = 1, chapter = 5 },
	{ name = "Ysondre", region = 1, chapter = 5 },
	{ name = "Zul'jin", region = 1, chapter = 5 },
	{ name = "Zuluhed", region = 1, chapter = 5 },

	-- Latin America
	{ name = "Drakkari", region = 1, chapter = 6 },
	{ name = "Quel'Thalas", region = 1, chapter = 6 },
	{ name = "Ragnaros", region = 1, chapter = 6 },

	-- Brazil
	{ name = "Azralon", region = 1, chapter = 7 },
	{ name = "Gallywix", region = 1, chapter = 7 },
	{ name = "Goldrinn", region = 1, chapter = 7 },
	{ name = "Nemesis", region = 1, chapter = 7 },
	{ name = "Tol Barad", region = 1, chapter = 7 },

	-- Korea
	{ name = "가로나", region = 2, chapter = 1 },
	{ name = "달라란", region = 2, chapter = 1 },
	{ name = "데스윙", region = 2, chapter = 1 },
	{ name = "렉사르", region = 2, chapter = 1 },
	{ name = "말퓨리온", region = 2, chapter = 1 },
	{ name = "불타는 군단", region = 2, chapter = 1 },
	{ name = "세나리우스", region = 2, chapter = 1 },
	{ name = "알렉스트라자", region = 2, chapter = 1 },
	{ name = "와일드해머", region = 2, chapter = 1 },
	{ name = "하이잘", region = 2, chapter = 1 },
	{ name = "헬스크림", region = 2, chapter = 1 },
	{ name = "굴단", region = 2, chapter = 1 },
	{ name = "노르간논", region = 2, chapter = 1 },
	{ name = "듀로탄", region = 2, chapter = 1 },
	{ name = "스톰레이지", region = 2, chapter = 1 },
	{ name = "아즈샤라", region = 2, chapter = 1 },
	{ name = "윈드러너", region = 2, chapter = 1 },
	{ name = "줄진", region = 2, chapter = 1 },

	-- EU
	-- English
	{ name = "Aerie Peak", region = 3, chapter = 1 },
	{ name = "Agamaggan", region = 3, chapter = 1 },
	{ name = "Aggramar", region = 3, chapter = 1 },
	{ name = "Ahn'Qiraj", region = 3, chapter = 1 },
	{ name = "Al'Akir", region = 3, chapter = 1 },
	{ name = "Alonsus", region = 3, chapter = 1 },
	{ name = "Anachronos", region = 3, chapter = 1 },
	{ name = "Arathor", region = 3, chapter = 1 },
	{ name = "Argent Dawn", region = 3, chapter = 1 },
	{ name = "Aszune", region = 3, chapter = 1 },
	{ name = "Auchindoun", region = 3, chapter = 1 },
	{ name = "Azjol-Nerub", region = 3, chapter = 1 },
	{ name = "Azuremyst", region = 3, chapter = 1 },
	{ name = "Balnazzar", region = 3, chapter = 1 },
	{ name = "Blade's Edge", region = 3, chapter = 1 },
	{ name = "Bladefist", region = 3, chapter = 1 },
	{ name = "Bloodfeather", region = 3, chapter = 1 },
	{ name = "Bloodhoof", region = 3, chapter = 1 },
	{ name = "Bloodscalp", region = 3, chapter = 1 },
	{ name = "Boulderfist", region = 3, chapter = 1 },
	{ name = "Bronze Dragonflight", region = 3, chapter = 1 },
	{ name = "Bronzebeard", region = 3, chapter = 1 },
	{ name = "Burning Blade", region = 3, chapter = 1 },
	{ name = "Burning Legion", region = 3, chapter = 1 },
	{ name = "Burning Steppes", region = 3, chapter = 1 },
	{ name = "Chamber of Aspects", region = 3, chapter = 1 },
	{ name = "Chromaggus", region = 3, chapter = 1 },
	{ name = "Crushridge", region = 3, chapter = 1 },
	{ name = "Daggerspine", region = 3, chapter = 1 },
	{ name = "Darkmoon Faire", region = 3, chapter = 1 },
	{ name = "Darksorrow", region = 3, chapter = 1 },
	{ name = "Darkspear", region = 3, chapter = 1 },
	{ name = "Deathwing", region = 3, chapter = 1 },
	{ name = "Defias Brotherhood", region = 3, chapter = 1 },
	{ name = "Dentarg", region = 3, chapter = 1 },
	{ name = "Doomhammer", region = 3, chapter = 1 },
	{ name = "Draenor", region = 3, chapter = 1 },
	{ name = "Dragonblight", region = 3, chapter = 1 },
	{ name = "Dragonmaw", region = 3, chapter = 1 },
	{ name = "Drak'thul", region = 3, chapter = 1 },
	{ name = "Dunemaul", region = 3, chapter = 1 },
	{ name = "Earthen Ring", region = 3, chapter = 1 },
	{ name = "Emerald Dream", region = 3, chapter = 1 },
	{ name = "Emeriss", region = 3, chapter = 1 },
	{ name = "Eonar", region = 3, chapter = 1 },
	{ name = "Executus", region = 3, chapter = 1 },
	{ name = "Frostmane", region = 3, chapter = 1 },
	{ name = "Frostwhisper", region = 3, chapter = 1 },
	{ name = "Genjuros", region = 3, chapter = 1 },
	{ name = "Ghostlands", region = 3, chapter = 1 },
	{ name = "Grim Batol", region = 3, chapter = 1 },
	{ name = "Hakkar", region = 3, chapter = 1 },
	{ name = "Haomarush", region = 3, chapter = 1 },
	{ name = "Hellfire", region = 3, chapter = 1 },
	{ name = "Hellscream", region = 3, chapter = 1 },
	{ name = "Jaedenar", region = 3, chapter = 1 },
	{ name = "Karazhan", region = 3, chapter = 1 },
	{ name = "Kazzak", region = 3, chapter = 1 },
	{ name = "Khadgar", region = 3, chapter = 1 },
	{ name = "Kilrogg", region = 3, chapter = 1 },
	{ name = "Kor'gall", region = 3, chapter = 1 },
	{ name = "Kul Tiras", region = 3, chapter = 1 },
	{ name = "Laughing Skull", region = 3, chapter = 1 },
	{ name = "Lightbringer", region = 3, chapter = 1 },
	{ name = "Lightning's Blade", region = 3, chapter = 1 },
	{ name = "Magtheridon", region = 3, chapter = 1 },
	{ name = "Mazrigos", region = 3, chapter = 1 },
	{ name = "Moonglade", region = 3, chapter = 1 },
	{ name = "Nagrand", region = 3, chapter = 1 },
	{ name = "Neptulon", region = 3, chapter = 1 },
	{ name = "Nordrassil", region = 3, chapter = 1 },
	{ name = "Outland", region = 3, chapter = 1 },
	{ name = "Quel'Thalas", region = 3, chapter = 1 },
	{ name = "Ragnaros", region = 3, chapter = 1 },
	{ name = "Ravencrest", region = 3, chapter = 1 },
	{ name = "Ravenholdt", region = 3, chapter = 1 },
	{ name = "Runetotem", region = 3, chapter = 1 },
	{ name = "Saurfang", region = 3, chapter = 1 },
	{ name = "Scarshield Legion", region = 3, chapter = 1 },
	{ name = "Shadowsong", region = 3, chapter = 1 },
	{ name = "Shattered Halls", region = 3, chapter = 1 },
	{ name = "Shattered Hand", region = 3, chapter = 1 },
	{ name = "Silvermoon", region = 3, chapter = 1 },
	{ name = "Skullcrusher", region = 3, chapter = 1 },
	{ name = "Spinebreaker", region = 3, chapter = 1 },
	{ name = "Sporeggar", region = 3, chapter = 1 },
	{ name = "Steamwheedle Cartel", region = 3, chapter = 1 },
	{ name = "Stormrage", region = 3, chapter = 1 },
	{ name = "Stormreaver", region = 3, chapter = 1 },
	{ name = "Stormscale", region = 3, chapter = 1 },
	{ name = "Sunstrider", region = 3, chapter = 1 },
	{ name = "Sylvanas", region = 3, chapter = 1 },
	{ name = "Talnivarr", region = 3, chapter = 1 },
	{ name = "Tarren Mill", region = 3, chapter = 1 },
	{ name = "Terenas", region = 3, chapter = 1 },
	{ name = "Terokkar", region = 3, chapter = 1 },
	{ name = "The Maelstrom", region = 3, chapter = 1 },
	{ name = "The Sha'tar", region = 3, chapter = 1 },
	{ name = "The Venture Co", region = 3, chapter = 1 },
	{ name = "Thunderhorn", region = 3, chapter = 1 },
	{ name = "Trollbane", region = 3, chapter = 1 },
	{ name = "Turalyon", region = 3, chapter = 1 },
	{ name = "Twilight's Hammer", region = 3, chapter = 1 },
	{ name = "Twisting Nether", region = 3, chapter = 1 },
	{ name = "Vashj", region = 3, chapter = 1 },
	{ name = "Vek'nilash", region = 3, chapter = 1 },
	{ name = "Wildhammer", region = 3, chapter = 1 },
	{ name = "Xavius", region = 3, chapter = 1 },
	{ name = "Zenedar", region = 3, chapter = 1 },

	-- French
	{ name = "Arak-arahm", region = 3, chapter = 2 },
	{ name = "Arathi", region = 3, chapter = 2 },
	{ name = "Archimonde", region = 3, chapter = 2 },
	{ name = "Chants éternels", region = 3, chapter = 2 },
	{ name = "Cho'gall", region = 3, chapter = 2 },
	{ name = "Confrérie du Thorium", region = 3, chapter = 2 },
	{ name = "Conseil des Ombres", region = 3, chapter = 2 },
	{ name = "Culte de la Rive noire", region = 3, chapter = 2 },
	{ name = "Dalaran", region = 3, chapter = 2 },
	{ name = "Drek'Thar", region = 3, chapter = 2 },
	{ name = "Eitrigg", region = 3, chapter = 2 },
	{ name = "Eldre'Thalas", region = 3, chapter = 2 },
	{ name = "Elune", region = 3, chapter = 2 },
	{ name = "Garona", region = 3, chapter = 2 },
	{ name = "Hyjal", region = 3, chapter = 2 },
	{ name = "Illidan", region = 3, chapter = 2 },
	{ name = "Kael'thas", region = 3, chapter = 2 },
	{ name = "Khaz Modan", region = 3, chapter = 2 },
	{ name = "Kirin Tor", region = 3, chapter = 2 },
	{ name = "Krasus", region = 3, chapter = 2 },
	{ name = "La Croisade écarlate", region = 3, chapter = 2 },
	{ name = "Les Clairvoyants", region = 3, chapter = 2 },
	{ name = "Les Sentinelles", region = 3, chapter = 2 },
	{ name = "Marécage de Zangar", region = 3, chapter = 2 },
	{ name = "Medivh", region = 3, chapter = 2 },
	{ name = "Naxxramas", region = 3, chapter = 2 },
	{ name = "Ner'zhul", region = 3, chapter = 2 },
	{ name = "Rashgarroth", region = 3, chapter = 2 },
	{ name = "Sargeras", region = 3, chapter = 2 },
	{ name = "Sinstralis", region = 3, chapter = 2 },
	{ name = "Suramar", region = 3, chapter = 2 },
	{ name = "Temple noir", region = 3, chapter = 2 },
	{ name = "Throk'Feroth", region = 3, chapter = 2 },
	{ name = "Uldaman", region = 3, chapter = 2 },
	{ name = "Varimathras", region = 3, chapter = 2 },
	{ name = "Vol'jin", region = 3, chapter = 2 },
	{ name = "Ysondre", region = 3, chapter = 2 },

	-- German
	{ name = "Aegwynn", region = 3, chapter = 3 },
	{ name = "Alexstrasza", region = 3, chapter = 3 },
	{ name = "Alleria", region = 3, chapter = 3 },
	{ name = "Aman'thul", region = 3, chapter = 3 },
	{ name = "Ambossar", region = 3, chapter = 3 },
	{ name = "Anetheron", region = 3, chapter = 3 },
	{ name = "Antonidas", region = 3, chapter = 3 },
	{ name = "Anub'arak", region = 3, chapter = 3 },
	{ name = "Area 52", region = 3, chapter = 3 },
	{ name = "Arthas", region = 3, chapter = 3 },
	{ name = "Arygos", region = 3, chapter = 3 },
	{ name = "Azshara", region = 3, chapter = 3 },
	{ name = "Baelgun", region = 3, chapter = 3 },
	{ name = "Blackhand", region = 3, chapter = 3 },
	{ name = "Blackmoore", region = 3, chapter = 3 },
	{ name = "Blackrock", region = 3, chapter = 3 },
	{ name = "Blutkessel", region = 3, chapter = 3 },
	{ name = "Dalvengyr", region = 3, chapter = 3 },
	{ name = "Das Konsortium", region = 3, chapter = 3 },
	{ name = "Das Syndikat", region = 3, chapter = 3 },
	{ name = "Der Abyssische Rat", region = 3, chapter = 3 },
	{ name = "Der Mithrilorden", region = 3, chapter = 3 },
	{ name = "Der Rat von Dalaran", region = 3, chapter = 3 },
	{ name = "Destromath", region = 3, chapter = 3 },
	{ name = "Dethecus", region = 3, chapter = 3 },
	{ name = "Die Aldor", region = 3, chapter = 3 },
	{ name = "Die Arguswacht", region = 3, chapter = 3 },
	{ name = "Die Nachtwache", region = 3, chapter = 3 },
	{ name = "Die Silberne Hand", region = 3, chapter = 3 },
	{ name = "Die Todeskrallen", region = 3, chapter = 3 },
	{ name = "Die ewige Wacht", region = 3, chapter = 3 },
	{ name = "Dun Morogh", region = 3, chapter = 3 },
	{ name = "Durotan", region = 3, chapter = 3 },
	{ name = "Echsenkessel", region = 3, chapter = 3 },
	{ name = "Eredar", region = 3, chapter = 3 },
	{ name = "Festung der Stürme", region = 3, chapter = 3 },
	{ name = "Forscherliga", region = 3, chapter = 3 },
	{ name = "Frostmourne", region = 3, chapter = 3 },
	{ name = "Frostwolf", region = 3, chapter = 3 },
	{ name = "Garrosh", region = 3, chapter = 3 },
	{ name = "Gilneas", region = 3, chapter = 3 },
	{ name = "Gorgonnash", region = 3, chapter = 3 },
	{ name = "Gul'dan", region = 3, chapter = 3 },
	{ name = "Kargath", region = 3, chapter = 3 },
	{ name = "Kel'Thuzad", region = 3, chapter = 3 },
	{ name = "Khaz'goroth", region = 3, chapter = 3 },
	{ name = "Kil'jaeden", region = 3, chapter = 3 },
	{ name = "Krag'jin", region = 3, chapter = 3 },
	{ name = "Kult der Verdammten", region = 3, chapter = 3 },
	{ name = "Lordaeron", region = 3, chapter = 3 },
	{ name = "Lothar", region = 3, chapter = 3 },
	{ name = "Madmortem", region = 3, chapter = 3 },
	{ name = "Mal'Ganis", region = 3, chapter = 3 },
	{ name = "Malfurion", region = 3, chapter = 3 },
	{ name = "Malorne", region = 3, chapter = 3 },
	{ name = "Malygos", region = 3, chapter = 3 },
	{ name = "Mannoroth", region = 3, chapter = 3 },
	{ name = "Mug'thol", region = 3, chapter = 3 },
	{ name = "Nathrezim", region = 3, chapter = 3 },
	{ name = "Nazjatar", region = 3, chapter = 3 },
	{ name = "Nefarian", region = 3, chapter = 3 },
	{ name = "Nera'thor", region = 3, chapter = 3 },
	{ name = "Nethersturm", region = 3, chapter = 3 },
	{ name = "Norgannon", region = 3, chapter = 3 },
	{ name = "Nozdormu", region = 3, chapter = 3 },
	{ name = "Onyxia", region = 3, chapter = 3 },
	{ name = "Perenolde", region = 3, chapter = 3 },
	{ name = "Proudmoore", region = 3, chapter = 3 },
	{ name = "Rajaxx", region = 3, chapter = 3 },
	{ name = "Rexxar", region = 3, chapter = 3 },
	{ name = "Sen'jin", region = 3, chapter = 3 },
	{ name = "Shattrath", region = 3, chapter = 3 },
	{ name = "Taerar", region = 3, chapter = 3 },
	{ name = "Teldrassil", region = 3, chapter = 3 },
	{ name = "Terrordar", region = 3, chapter = 3 },
	{ name = "Theradras", region = 3, chapter = 3 },
	{ name = "Thrall", region = 3, chapter = 3 },
	{ name = "Tichondrius", region = 3, chapter = 3 },
	{ name = "Tirion", region = 3, chapter = 3 },
	{ name = "Todeswache", region = 3, chapter = 3 },
	{ name = "Ulduar", region = 3, chapter = 3 },
	{ name = "Un'Goro", region = 3, chapter = 3 },
	{ name = "Vek'lor", region = 3, chapter = 3 },
	{ name = "Wrathbringer", region = 3, chapter = 3 },
	{ name = "Ysera", region = 3, chapter = 3 },
	{ name = "Zirkel des Cenarius", region = 3, chapter = 3 },
	{ name = "Zuluhed", region = 3, chapter = 3 },

	-- Russian
	{ name = "Азурегос", region = 3, chapter = 4 },
	{ name = "Борейская тундра", region = 3, chapter = 4 },
	{ name = "Вечная Песня", region = 3, chapter = 4 },
	{ name = "Галакронд", region = 3, chapter = 4 },
	{ name = "Голдринн", region = 3, chapter = 4 },
	{ name = "Гордунни", region = 3, chapter = 4 },
	{ name = "Гром", region = 3, chapter = 4 },
	{ name = "Дракономор", region = 3, chapter = 4 },
	{ name = "Король-лич", region = 3, chapter = 4 },
	{ name = "Пиратская бухта", region = 3, chapter = 4 },
	{ name = "Подземье", region = 3, chapter = 4 },
	{ name = "Разувий", region = 3, chapter = 4 },
	{ name = "Ревущий фьорд", region = 3, chapter = 4 },
	{ name = "Свежеватель Душ", region = 3, chapter = 4 },
	{ name = "Седогрив", region = 3, chapter = 4 },
	{ name = "Страж Смерти", region = 3, chapter = 4 },
	{ name = "Термоштепсель", region = 3, chapter = 4 },
	{ name = "Ткач Смерти", region = 3, chapter = 4 },
	{ name = "Черный Шрам", region = 3, chapter = 4 },
	{ name = "Ясеневый лес", region = 3, chapter = 4 },

	-- Spanish
	{ name = "C'Thun", region = 3, chapter = 5 },
	{ name = "Colinas Pardas", region = 3, chapter = 5 },
	{ name = "Dun Modr", region = 3, chapter = 5 },
	{ name = "Exodar", region = 3, chapter = 5 },
	{ name = "Los Errantes", region = 3, chapter = 5 },
	{ name = "Minahonda", region = 3, chapter = 5 },
	{ name = "Sanguino", region = 3, chapter = 5 },
	{ name = "Shen'dralar", region = 3, chapter = 5 },
	{ name = "Tyrande", region = 3, chapter = 5 },
	{ name = "Uldum", region = 3, chapter = 5 },
	{ name = "Zul'jin", region = 3, chapter = 5 },

	-- Portuguese
	{ name = "Aggra (Português)", region = 3, chapter = 6 },

	-- Italian
	{ name = "Nemesis", region = 3, chapter = 7 },
	{ name = "Pozzo dell'Eternità", region = 3, chapter = 7 },

	-- Taiwan
	{ name = "世界之樹", region = 4, chapter = 1 },
	{ name = "冰霜之刺", region = 4, chapter = 1 },
	{ name = "冰風崗哨", region = 4, chapter = 1 },
	{ name = "地獄吼", region = 4, chapter = 1 },
	{ name = "天空之牆", region = 4, chapter = 1 },
	{ name = "尖石", region = 4, chapter = 1 },
	{ name = "巨龍之喉", region = 4, chapter = 1 },
	{ name = "日落沼澤", region = 4, chapter = 1 },
	{ name = "暗影之月", region = 4, chapter = 1 },
	{ name = "水晶之刺", region = 4, chapter = 1 },
	{ name = "狂熱之刃", region = 4, chapter = 1 },
	{ name = "米奈希爾", region = 4, chapter = 1 },
	{ name = "雷鱗", region = 4, chapter = 1 },
	{ name = "雲蛟衛", region = 4, chapter = 1 },
	{ name = "亞雷戈斯", region = 4, chapter = 1 },
	{ name = "夜空之歌", region = 4, chapter = 1 },
	{ name = "寒冰皇冠", region = 4, chapter = 1 },
	{ name = "屠魔山谷", region = 4, chapter = 1 },
	{ name = "憤怒使者", region = 4, chapter = 1 },
	{ name = "眾星之子", region = 4, chapter = 1 },
	{ name = "聖光之願", region = 4, chapter = 1 },
	{ name = "血之谷", region = 4, chapter = 1 },
	{ name = "語風", region = 4, chapter = 1 },
	{ name = "銀翼要塞", region = 4, chapter = 1 },
	{ name = "阿薩斯", region = 4, chapter = 1 },

	-- China
	-- 五区
	{ name = "万色星辰", region = 5, chapter = 1 },
	{ name = "世界之树", region = 5, chapter = 1 },
	{ name = "亚雷戈斯", region = 5, chapter = 1 },
	{ name = "伊兰尼库斯", region = 5, chapter = 1 },
	{ name = "伊森利恩", region = 5, chapter = 1 },
	{ name = "伊森德雷", region = 5, chapter = 1 },
	{ name = "伊萨里奥斯", region = 5, chapter = 1 },
	{ name = "元素之力", region = 5, chapter = 1 },
	{ name = "冬寒", region = 5, chapter = 1 },
	{ name = "冬泉谷", region = 5, chapter = 1 },
	{ name = "冰川之拳", region = 5, chapter = 1 },
	{ name = "刺骨利刃", region = 5, chapter = 1 },
	{ name = "加兹鲁维", region = 5, chapter = 1 },
	{ name = "卡珊德拉", region = 5, chapter = 1 },
	{ name = "厄祖玛特", region = 5, chapter = 1 },
	{ name = "埃基尔松", region = 5, chapter = 1 },
	{ name = "塞拉摩", region = 5, chapter = 1 },
	{ name = "大地之怒", region = 5, chapter = 1 },
	{ name = "夺灵者", region = 5, chapter = 1 },
	{ name = "守护之剑", region = 5, chapter = 1 },
	{ name = "密林游侠", region = 5, chapter = 1 },
	{ name = "巫妖之王", region = 5, chapter = 1 },
	{ name = "布兰卡德", region = 5, chapter = 1 },
	{ name = "幽暗沼泽", region = 5, chapter = 1 },
	{ name = "恶魔之翼", region = 5, chapter = 1 },
	{ name = "扎拉赞恩", region = 5, chapter = 1 },
	{ name = "提尔之手", region = 5, chapter = 1 },
	{ name = "斩魔者", region = 5, chapter = 1 },
	{ name = "日落沼泽", region = 5, chapter = 1 },
	{ name = "暮色森林", region = 5, chapter = 1 },
	{ name = "朵丹尼尔", region = 5, chapter = 1 },
	{ name = "永夜港", region = 5, chapter = 1 },
	{ name = "法拉希姆", region = 5, chapter = 1 },
	{ name = "深渊之巢", region = 5, chapter = 1 },
	{ name = "激流之傲", region = 5, chapter = 1 },
	{ name = "火喉", region = 5, chapter = 1 },
	{ name = "火烟之谷", region = 5, chapter = 1 },
	{ name = "烈焰荆棘", region = 5, chapter = 1 },
	{ name = "狂热之刃", region = 5, chapter = 1 },

	--三区
	{ name = "丹莫德", region = 5, chapter = 2 },
	{ name = "伊莫塔尔", region = 5, chapter = 2 },
	{ name = "凯恩血蹄", region = 5, chapter = 2 },
	{ name = "加基森", region = 5, chapter = 2 },
	{ name = "加里索斯", region = 5, chapter = 2 },
	{ name = "勇士岛", region = 5, chapter = 2 },
	{ name = "千针石林", region = 5, chapter = 2 },
	{ name = "双子峰", region = 5, chapter = 2 },
	{ name = "古加尔", region = 5, chapter = 2 },
	{ name = "圣火神殿", region = 5, chapter = 2 },
	{ name = "埃克索图斯", region = 5, chapter = 2 },
	{ name = "埃德萨拉", region = 5, chapter = 2 },
	{ name = "塔纳利斯", region = 5, chapter = 2 },
	{ name = "塞拉赞恩", region = 5, chapter = 2 },
	{ name = "外域", region = 5, chapter = 2 },
	{ name = "大漩涡", region = 5, chapter = 2 },
	{ name = "天空之墙", region = 5, chapter = 2 },
	{ name = "天谴之门", region = 5, chapter = 2 },
	{ name = "奥妮克希亚", region = 5, chapter = 2 },
	{ name = "奥斯里安", region = 5, chapter = 2 },
	{ name = "安戈洛", region = 5, chapter = 2 },
	{ name = "巴瑟拉斯", region = 5, chapter = 2 },
	{ name = "布莱克摩", region = 5, chapter = 2 },
	{ name = "布莱恩", region = 5, chapter = 2 },
	{ name = "恐怖图腾", region = 5, chapter = 2 },
	{ name = "恶魔之魂", region = 5, chapter = 2 },
	{ name = "托塞德林", region = 5, chapter = 2 },
	{ name = "普罗德摩", region = 5, chapter = 2 },
	{ name = "杜隆坦", region = 5, chapter = 2 },
	{ name = "格雷迈恩", region = 5, chapter = 2 },
	{ name = "沃金", region = 5, chapter = 2 },
	{ name = "火羽山", region = 5, chapter = 2 },
	{ name = "灰谷", region = 5, chapter = 2 },
	{ name = "熊猫酒仙", region = 5, chapter = 2 },
	{ name = "燃烧之刃", region = 5, chapter = 2 },
	{ name = "狂风峭壁", region = 5, chapter = 2 },
	{ name = "玛里苟斯", region = 5, chapter = 2 },
	{ name = "瑟莱德丝", region = 5, chapter = 2 },
	{ name = "甜水绿洲", region = 5, chapter = 2 },

	--二区
	{ name = "主宰之剑", region = 5, chapter = 3 },
	{ name = "伊利丹", region = 5, chapter = 3 },
	{ name = "克洛玛古斯", region = 5, chapter = 3 },
	{ name = "克苏恩", region = 5, chapter = 3 },
	{ name = "军团要塞", region = 5, chapter = 3 },
	{ name = "冰霜之刃", region = 5, chapter = 3 },
	{ name = "凤凰之神", region = 5, chapter = 3 },
	{ name = "刀塔", region = 5, chapter = 3 },
	{ name = "卡德加", region = 5, chapter = 3 },
	{ name = "卡拉赞", region = 5, chapter = 3 },
	{ name = "古拉巴什", region = 5, chapter = 3 },
	{ name = "哈兰", region = 5, chapter = 3 },
	{ name = "哈卡", region = 5, chapter = 3 },
	{ name = "地狱之石", region = 5, chapter = 3 },
	{ name = "地狱咆哮", region = 5, chapter = 3 },
	{ name = "埃加洛尔", region = 5, chapter = 3 },
	{ name = "埃苏雷格", region = 5, chapter = 3 },
	{ name = "塞泰克", region = 5, chapter = 3 },
	{ name = "塞纳留斯", region = 5, chapter = 3 },
	{ name = "夏维安", region = 5, chapter = 3 },
	{ name = "太阳之井", region = 5, chapter = 3 },
	{ name = "奈法利安", region = 5, chapter = 3 },
	{ name = "奎尔萨拉斯", region = 5, chapter = 3 },
	{ name = "奥拉基尔", region = 5, chapter = 3 },
	{ name = "奥金顿", region = 5, chapter = 3 },
	{ name = "安其拉", region = 5, chapter = 3 },
	{ name = "安纳塞隆", region = 5, chapter = 3 },
	{ name = "屠魔山谷", region = 5, chapter = 3 },
	{ name = "巴纳扎尔", region = 5, chapter = 3 },
	{ name = "希雷诺斯", region = 5, chapter = 3 },
	{ name = "库尔提拉斯", region = 5, chapter = 3 },
	{ name = "弗塞雷迦", region = 5, chapter = 3 },
	{ name = "德拉诺", region = 5, chapter = 3 },
	{ name = "戈古纳斯", region = 5, chapter = 3 },
	{ name = "战歌", region = 5, chapter = 3 },
	{ name = "托尔巴拉德", region = 5, chapter = 3 },
	{ name = "拉文凯斯", region = 5, chapter = 3 },
	{ name = "拉文霍德", region = 5, chapter = 3 },
	{ name = "拉贾克斯", region = 5, chapter = 3 },
	{ name = "摩摩尔", region = 5, chapter = 3 },
	{ name = "无尽之海", region = 5, chapter = 3 },
	{ name = "无底海渊", region = 5, chapter = 3 },
	{ name = "暗影之月", region = 5, chapter = 3 },
	{ name = "暗影迷宫", region = 5, chapter = 3 },
	{ name = "月光林地", region = 5, chapter = 3 },
	{ name = "月神殿", region = 5, chapter = 3 },
	{ name = "末日祷告祭坛", region = 5, chapter = 3 },
	{ name = "格瑞姆巴托", region = 5, chapter = 3 },
	{ name = "格鲁尔", region = 5, chapter = 3 },
	{ name = "桑德兰", region = 5, chapter = 3 },
	{ name = "梅尔加尼", region = 5, chapter = 3 },
	{ name = "梦境之树", region = 5, chapter = 3 },
	{ name = "森金", region = 5, chapter = 3 },
	{ name = "死亡熔炉", region = 5, chapter = 3 },
	{ name = "毁灭之锤", region = 5, chapter = 3 },
	{ name = "永恒之井", region = 5, chapter = 3 },
	{ name = "泰兰德", region = 5, chapter = 3 },
	{ name = "泰拉尔", region = 5, chapter = 3 },
	{ name = "洛丹伦", region = 5, chapter = 3 },
	{ name = "海克泰尔", region = 5, chapter = 3 },
	{ name = "海加尔", region = 5, chapter = 3 },
	{ name = "海达希亚", region = 5, chapter = 3 },
	{ name = "深渊之喉", region = 5, chapter = 3 },
	{ name = "火焰之树", region = 5, chapter = 3 },
	{ name = "熔火之心", region = 5, chapter = 3 },
	{ name = "燃烧军团", region = 5, chapter = 3 },
	{ name = "爱斯特纳", region = 5, chapter = 3 },
	{ name = "玛法里奥", region = 5, chapter = 3 },
	{ name = "玛维·影歌", region = 5, chapter = 3 },
	{ name = "瓦丝琪", region = 5, chapter = 3 },
	{ name = "瓦拉斯塔兹", region = 5, chapter = 3 },
	{ name = "瓦里玛萨斯", region = 5, chapter = 3 },

	--推荐服务器
	{ name = "丽丽（四川）", region = 5, chapter = 4 },
	{ name = "晴日峰（江苏）", region = 5, chapter = 4 },
	{ name = "瓦里安", region = 5, chapter = 4 },

	--十区
	{ name = "亡语者", region = 5, chapter = 5 },
	{ name = "兰娜瑟尔", region = 5, chapter = 5 },
	{ name = "冬拥湖", region = 5, chapter = 5 },
	{ name = "加尔", region = 5, chapter = 5 },
	{ name = "古达克", region = 5, chapter = 5 },
	{ name = "嚎风峡湾", region = 5, chapter = 5 },
	{ name = "壁炉谷", region = 5, chapter = 5 },
	{ name = "奎尔丹纳斯", region = 5, chapter = 5 },
	{ name = "奥尔加隆", region = 5, chapter = 5 },
	{ name = "奥杜尔", region = 5, chapter = 5 },
	{ name = "安加萨", region = 5, chapter = 5 },
	{ name = "安格博达", region = 5, chapter = 5 },
	{ name = "安苏", region = 5, chapter = 5 },
	{ name = "布鲁塔卢斯", region = 5, chapter = 5 },
	{ name = "影之哀伤", region = 5, chapter = 5 },
	{ name = "戈提克", region = 5, chapter = 5 },
	{ name = "斯克提斯", region = 5, chapter = 5 },
	{ name = "末日行者", region = 5, chapter = 5 },
	{ name = "沙怒", region = 5, chapter = 5 },
	{ name = "洛肯", region = 5, chapter = 5 },
	{ name = "熵魔", region = 5, chapter = 5 },
	{ name = "玛洛加尔", region = 5, chapter = 5 },
	{ name = "瓦拉纳", region = 5, chapter = 5 },
	{ name = "生态船", region = 5, chapter = 5 },
	{ name = "白骨荒野", region = 5, chapter = 5 },

	--一区
	{ name = "伊瑟拉", region = 5, chapter = 6 },
	{ name = "克尔苏加德", region = 5, chapter = 6 },
	{ name = "冰风岗", region = 5, chapter = 6 },
	{ name = "凯尔萨斯", region = 5, chapter = 6 },
	{ name = "利刃之拳", region = 5, chapter = 6 },
	{ name = "卡德罗斯", region = 5, chapter = 6 },
	{ name = "卡扎克", region = 5, chapter = 6 },
	{ name = "古尔丹", region = 5, chapter = 6 },
	{ name = "回音山", region = 5, chapter = 6 },
	{ name = "国王之谷", region = 5, chapter = 6 },
	{ name = "图拉扬", region = 5, chapter = 6 },
	{ name = "埃雷达尔", region = 5, chapter = 6 },
	{ name = "埃霍恩", region = 5, chapter = 6 },
	{ name = "基尔加丹", region = 5, chapter = 6 },
	{ name = "基尔罗格", region = 5, chapter = 6 },
	{ name = "塔伦米尔", region = 5, chapter = 6 },
	{ name = "奈萨里奥", region = 5, chapter = 6 },
	{ name = "奥特兰克", region = 5, chapter = 6 },
	{ name = "奥蕾莉亚", region = 5, chapter = 6 },
	{ name = "奥达曼", region = 5, chapter = 6 },
	{ name = "安东尼达斯", region = 5, chapter = 6 },
	{ name = "安威玛尔", region = 5, chapter = 6 },
	{ name = "寒冰皇冠", region = 5, chapter = 6 },
	{ name = "尘风峡谷", region = 5, chapter = 6 },
	{ name = "山丘之王", region = 5, chapter = 6 },
	{ name = "巨龙之吼", region = 5, chapter = 6 },
	{ name = "巴尔古恩", region = 5, chapter = 6 },
	{ name = "希尔瓦娜斯", region = 5, chapter = 6 },
	{ name = "库德兰", region = 5, chapter = 6 },
	{ name = "影牙要塞", region = 5, chapter = 6 },
	{ name = "拉格纳罗斯", region = 5, chapter = 6 },
	{ name = "提瑞斯法", region = 5, chapter = 6 },
	{ name = "斯坦索姆", region = 5, chapter = 6 },
	{ name = "时光之穴", region = 5, chapter = 6 },
	{ name = "普瑞斯托", region = 5, chapter = 6 },
	{ name = "暗影裂口", region = 5, chapter = 6 },
	{ name = "暗影议会", region = 5, chapter = 6 },
	{ name = "暴风祭坛", region = 5, chapter = 6 },
	{ name = "死亡之翼", region = 5, chapter = 6 },
	{ name = "洛萨", region = 5, chapter = 6 },
	{ name = "激流堡", region = 5, chapter = 6 },
	{ name = "烈焰峰", region = 5, chapter = 6 },
	{ name = "燃烧平原", region = 5, chapter = 6 },
	{ name = "玛多兰", region = 5, chapter = 6 },
	{ name = "玛瑟里顿", region = 5, chapter = 6 },
	{ name = "玛诺洛斯", region = 5, chapter = 6 },
	{ name = "瑞文戴尔", region = 5, chapter = 6 },
	{ name = "白银之手", region = 5, chapter = 6 },
}

PremadeFilterEditBoxMixin = {}
function PremadeFilterEditBoxMixin:AddToTabCategory(tabCategory, editBox)
	local addToTab = editBox or self
	LFGListEditBox_AddToTabCategory(addToTab, tabCategory)
end

function PremadeFilterEditBoxMixin:OnLoad()
	if self.tabCategory then
		self:AddToTabCategory(self.tabCategory)
	end
end

function PremadeFilterEditBoxMixin:GetSelectedActivityID()
	return self:GetParent().selectedActivity or self:GetParent():GetParent().selectedActivity
end

function PremadeFilterEditBoxMixin:OnShow()
	self:SetEnabled(true)
	self.editBoxEnabled = true
end

function PremadeFilterEditBoxMixin:OnTabPressed()
	LFGListEditBox_OnTabPressed(self)
end

StaticPopupDialogs["PREMADEFILTER_CONFIRM_CLOSE"] = {
	text = T(
		"Automatic monitoring of new groups in background is broken since patch 7.2. It was forbidden by Blizzard and is no longer possible. See https://us.battle.net/forums/en/wow/topic/20754326419 for more details.\n\nYou can manually trigger background search by assigning key binding."
	),
	button1 = OKAY,
	button2 = NO,
	OnShow = function(self)
		PremadeFilter_Frame.closeConfirmation = true
	end,
	OnHide = function(self)
		PremadeFilter_Frame.closeConfirmation = false
	end,
	OnAccept = function(self, arg1, reason)
		if PremadeFilter_Frame:IsVisible() then
			PremadeFilter_Frame.ShowNextTime = true

			HideUIPanel(PVEFrame)

			PremadeFilter_MinimapButton:Show()

			PremadeFilter_StartMonitoring()
		end
	end,
	OnCancel = function(self, arg1, reason)
		PremadeFilter_Frame.ShowNextTime = false
		PremadeFilter_Frame:Hide()
		PremadeFilter_Frame.AdvancedButton:Enable()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

StaticPopupDialogs["PREMADEFILTER_SAVE_FILTERSET"] = {
	text = T("Enter filter set name"),
	hasEditBox = true,
	maxLetters = 100,
	editBoxWidth = 350,
	button1 = SAVE,
	button2 = CANCEL,
	OnShow = function(self)
		local defaultText = T("New filter set")
		local index = PremadeFilter_Frame.selectedFilterSet
		local text
		if index <= #PremadeFilter_Data.FilterSetsOrder then
			text = PremadeFilter_Data.FilterSetsOrder[index]
		else
			text = defaultText
		end
		self.editBox:SetText(text)
		self.editBox:SetFocus()
	end,
	OnAccept = function(self, arg1, reason)
		local defaultText = T("New filter set")
		local text = self.editBox:GetText():gsub("^%s*(.-)%s*$", "%1")

		if text == defaultText or text == "" then
			local index = 2
			repeat
				text = string.format("%s %d", defaultText, index)
				index = index + 1
			until not PremadeFilter_Data.FilterSets[text]
		end

		if type(PremadeFilter_Data.FilterSets[text]) ~= "table" then
			table.insert(PremadeFilter_Data.FilterSetsOrder, text)
			PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder
		end

		PremadeFilter_Data.FilterSets[text] = PremadeFilter_GetFilters()

		PremadeFilter_FixFilterSets()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

StaticPopupDialogs["PREMADEFILTER_CONFIRM_DELETE"] = {
	text = T("Are you sure you want to delete filter set?"),
	button1 = YES,
	button2 = NO,
	OnAccept = function(self, arg1, reason)
		local index = PremadeFilter_Frame.selectedFilterSet

		if index <= #PremadeFilter_Data.FilterSetsOrder then
			local text = table.remove(PremadeFilter_Data.FilterSetsOrder, index)
			PremadeFilter_Data.FilterSets[text] = nil

			PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder + 1
			PremadeFilter_SetFilters({
				category = PremadeFilter_Frame.selectedCategory,
				group = PremadeFilter_Frame.selectedGroup,
				activity = PremadeFilter_Frame.selectedActivity,
			})
		end
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

PremadeFilter_TutorialMixin = {}

function PremadeFilter_TutorialMixin:OnLoad()
	self.PremadeFilter_HelpPlate = {
		FramePos = { x = 0, y = -22 },
		FrameSize = { width = 817, height = 409 },
		[1] = {
			ButtonPos = { x = 280, y = -25 },
			HighLightBox = { x = 23, y = -33, width = 296, height = 84 },
			ToolTipDir = "RIGHT",
			ToolTipText = T("Select group activity: quest, dungeon, raid, difficulty"),
		},
		[2] = {
			ButtonPos = { x = 313, y = -242 },
			HighLightBox = { x = 322, y = -250, width = 233, height = 91 },
			ToolTipDir = "UP",
			ToolTipText = T("Define minimum and/or maximum number of players of any role.") .. "\n\n" .. T(
				"For example if you are a tank you can set maximum number of tanks to 1 and you get the groups you are guaranteed to have a spot."
			),
		},
		[3] = {
			ButtonPos = { x = 280, y = -313 },
			HighLightBox = { x = 23, y = -120, width = 296, height = 231 },
			ToolTipDir = "UP",
			ToolTipText = T(
				"If you want to join a group of highly equipped characters you can setup minimum item level defined for its members."
			) .. "\n\n" .. T(
				"You can find a group that uses specific voice chat software or a group tha doesn't use voice chat at all."
			),
		},
		[4] = {
			ButtonPos = { x = 516, y = -25 },
			HighLightBox = { x = 322, y = -33, width = 233, height = 213 },
			ToolTipDir = "UP",
			ToolTipText = T(
				"You can mark the bosses you want to be still alive with [v] and the bosses you want to be already defeated by [-]."
			),
		},

		[5] = {
			ButtonPos = { x = 655, y = -302 },
			HighLightBox = { x = 558, y = -33, width = 239, height = 308 },
			ToolTipDir = "UP",
			ToolTipText = T("Want to find a mythic raid? Choose your realm only."),
		},
		[6] = {
			ButtonPos = { x = 535, y = 22 },
			HighLightBox = { x = 558, y = 21, width = 258, height = 43 },
			ToolTipDir = "LEFT",
			ToolTipText = T("You can save the filters to use them in future."),
		},
		[7] = {
			ButtonPos = { x = 122, y = -350 },
			HighLightBox = { x = 0, y = -355, width = 145, height = 36 },
			ToolTipDir = "RIGHT",
			ToolTipText = T(
				"By hiding the window you can activate background search so you can do anything else in the game."
			) .. "\n\n" .. T("The addon notifies you if it finds a group that matches your requirements."),
		},
		[8] = {
			ButtonPos = { x = 646, y = -350 },
			HighLightBox = { x = 669, y = -355, width = 145, height = 36 },
			ToolTipDir = "LEFT",
			ToolTipText = T(
				"The filters take effect when you click this button. The changes don't take effect until you do that."
			),
		},
	}
end

function PremadeFilter_TutorialMixin:OnHide()
	HelpPlate_Hide()
end

function PremadeFilter_TutorialMixin:OnClick()
	local mainFrame = self:GetParent()
	if not HelpPlate_IsShowing(self.PremadeFilter_HelpPlate) and mainFrame:IsShown() then
		HelpPlate_Show(self.PremadeFilter_HelpPlate, mainFrame, self)
	else
		HelpPlate_Hide()
	end
end

function PremadeFilter_SearchStringFromFilters(selectedActivity)
	if PremadeFilter_Data.Settings.AutoFillSearchBox then
		C_LFGList.ClearSearchTextFields()
		if selectedActivity ~= nil then
			C_LFGList.SetSearchToActivity(selectedActivity)
		end
	end
end

function PremadeFilter_AddCategoryEntry(self, info, categoryID, name, filters)
	if filters ~= 0 and #C_LFGList.GetAvailableActivities(categoryID, nil, filters) == 0 then
		return
	end
	info.text = LFGListUtil_GetDecoratedCategoryName(name, filters, false)
	info.value = categoryID
	info.arg1 = filters
	info.checked = (self.selectedCategory == categoryID and self.selectedFilters == filters)
	info.isRadio = true
	UIDropDownMenu_AddButton(info)
end

function PremadeFilter_PopulateCategories(self, _, info)
	local categories = C_LFGList.GetAvailableCategories(self.baseFilters)
	for i = 1, #categories do
		local categoryID = categories[i]
		local CategoryInfo = C_LFGList.GetLfgCategoryInfo(categoryID)
		if CategoryInfo.separateRecommended then
			PremadeFilter_AddCategoryEntry(self, info, categoryID, CategoryInfo.name, Enum.LFGListFilter.Recommended)
			PremadeFilter_AddCategoryEntry(self, info, categoryID, CategoryInfo.name, Enum.LFGListFilter.NotRecommended)
		else
			PremadeFilter_AddCategoryEntry(self, info, categoryID, CategoryInfo.name, 0)
		end
	end
end

-----------------Temporary (i hope) fix for Blizzard restricted actions------------------------
LFGList_ReportAdvertisement = function(searchResultID, leaderName) --Protected func, not completable with addons.
	local reportInfo = ReportInfo:CreateReportInfoFromType(Enum.ReportType.GroupFinderPosting)
	reportInfo:SetGroupFinderSearchResultID(searchResultID)
	ReportFrame:InitiateReport(reportInfo, leaderName, nil, nil, false)
end

function PremadeFilter_GetPlaystyleString(playstyle, activityInfo)
	if activityInfo and C_LFGList.GetLfgCategoryInfo(activityInfo.categoryID).showPlaystyleDropdown and playstyle then
		local typeStr
		if activityInfo.isMythicPlusActivity and playstyle == 1 then
			typeStr = GROUP_FINDER_PVE_PLAYSTYLE1
		elseif activityInfo.isMythicPlusActivity and playstyle == 2 then
			typeStr = GROUP_FINDER_PVE_PLAYSTYLE2
		elseif activityInfo.isMythicPlusActivity and playstyle == 3 then
			typeStr = GROUP_FINDER_PVE_PLAYSTYLE3
		elseif activityInfo.isRatedPvpActivity and playstyle == 1 then
			typeStr = GROUP_FINDER_PVP_PLAYSTYLE1
		elseif activityInfo.isRatedPvpActivity and playstyle == 2 then
			typeStr = GROUP_FINDER_PVP_PLAYSTYLE2
		elseif activityInfo.isRatedPvpActivity and playstyle == 3 then
			typeStr = GROUP_FINDER_PVP_PLAYSTYLE3
		elseif activityInfo.isCurrentRaidActivity and playstyle == 1 then
			typeStr = GROUP_FINDER_PVE_RAID_PLAYSTYLE1
		elseif activityInfo.isCurrentRaidActivity and playstyle == 2 then
			typeStr = GROUP_FINDER_PVE_RAID_PLAYSTYLE2
		elseif activityInfo.isCurrentRaidActivity and playstyle == 3 then
			typeStr = GROUP_FINDER_PVE_RAID_PLAYSTYLE3
		elseif activityInfo.isMythicActivity and playstyle == 1 then
			typeStr = GROUP_FINDER_PVE_MYTHICZERO_PLAYSTYLE1
		elseif activityInfo.isMythicActivity and playstyle == 2 then
			typeStr = GROUP_FINDER_PVE_MYTHICZERO_PLAYSTYLE2
		elseif activityInfo.isMythicActivity and playstyle == 3 then
			typeStr = GROUP_FINDER_PVE_MYTHICZERO_PLAYSTYLE3
		end
		return typeStr
	else
		return nil
	end
end

function LFGListEntryCreation_SetTitleFromActivityInfo(_) end --Protected func, not completable with addons. No name when creating activity without authenticator now.

C_LFGList.GetPlaystyleString = --There is no reason to do this api func protected, but they do.
	function(playstyle, activityInfo)
		return PremadeFilter_GetPlaystyleString(playstyle, activityInfo)
	end
--------------------------------------------------------------------------------------------

function PremadeFilter_OnPlayStyleSelected(self, dropdown, playstyle)
	local activityInfo = C_LFGList.GetActivityInfoTable(self.selectedActivity)
	self.selectedPlaystyle = playstyle
	UIDropDownMenu_SetSelectedValue(dropdown, playstyle)
	UIDropDownMenu_SetText(dropdown, PremadeFilter_GetPlaystyleString(playstyle, activityInfo))
	local labelText
	if activityInfo.isRatedPvpActivity then
		labelText = LFG_PLAYSTYLE_LABEL_PVP
	elseif activityInfo.isMythicPlusActivity then
		labelText = LFG_PLAYSTYLE_LABEL_PVE
	elseif activityInfo.isCurrentRaidActivity then
		labelText = LFG_PLAYSTYLE_LABEL_PVE_RAID
	else
		labelText = LFG_PLAYSTYLE_LABEL_PVE_MYTHICZERO
	end
	self.PlayStyleLabel:SetText(labelText)
end

function PremadeFilter_SetupPlayStyleDropDown(self, dropdown, info)
	if not self.selectedActivity or not self.selectedCategory then
		return
	end
	local activityInfo = C_LFGList.GetActivityInfoTable(self.selectedActivity)
	if activityInfo.isRatedPvpActivity then
		info.text = PremadeFilter_GetPlaystyleString(Enum.LFGEntryPlaystyle.Standard, activityInfo)
		info.value = Enum.LFGEntryPlaystyle.Standard
		info.checked = false
		info.isRadio = true
		info.func = function()
			PremadeFilter_OnPlayStyleSelected(self, dropdown, Enum.LFGEntryPlaystyle.Standard)
		end
		UIDropDownMenu_AddButton(info)
		info.text = PremadeFilter_GetPlaystyleString(Enum.LFGEntryPlaystyle.Casual, activityInfo)
		info.value = Enum.LFGEntryPlaystyle.Casual
		info.checked = false
		info.isRadio = true
		info.func = function()
			PremadeFilter_OnPlayStyleSelected(self, dropdown, Enum.LFGEntryPlaystyle.Casual)
		end
		UIDropDownMenu_AddButton(info)
		info.text = PremadeFilter_GetPlaystyleString(Enum.LFGEntryPlaystyle.Hardcore, activityInfo)
		info.value = Enum.LFGEntryPlaystyle.Hardcore
		info.checked = false
		info.isRadio = true
		info.func = function()
			PremadeFilter_OnPlayStyleSelected(self, dropdown, Enum.LFGEntryPlaystyle.Hardcore)
		end
		UIDropDownMenu_AddButton(info)
	else
		info.text = PremadeFilter_GetPlaystyleString(Enum.LFGEntryPlaystyle.Standard, activityInfo)
		info.value = Enum.LFGEntryPlaystyle.Standard
		info.checked = false
		info.isRadio = true
		info.func = function()
			PremadeFilter_OnPlayStyleSelected(self, dropdown, Enum.LFGEntryPlaystyle.Standard)
		end
		UIDropDownMenu_AddButton(info)
		info.text = PremadeFilter_GetPlaystyleString(Enum.LFGEntryPlaystyle.Casual, activityInfo)
		info.value = Enum.LFGEntryPlaystyle.Casual
		info.checked = false
		info.isRadio = true
		info.func = function()
			PremadeFilter_OnPlayStyleSelected(self, dropdown, Enum.LFGEntryPlaystyle.Casual)
		end
		UIDropDownMenu_AddButton(info)
		info.text = PremadeFilter_GetPlaystyleString(Enum.LFGEntryPlaystyle.Hardcore, activityInfo)
		info.value = Enum.LFGEntryPlaystyle.Hardcore
		info.func = function()
			PremadeFilter_OnPlayStyleSelected(self, dropdown, Enum.LFGEntryPlaystyle.Hardcore)
		end
		info.checked = false
		info.isRadio = true
		UIDropDownMenu_AddButton(info)
	end
	local categoryInfo = C_LFGList.GetLfgCategoryInfo(self.selectedCategory)
	local shouldShowPlayStyleDropdown = categoryInfo.showPlaystyleDropdown
		and (
			activityInfo.isMythicPlusActivity
			or activityInfo.isRatedPvpActivity
			or activityInfo.isCurrentRaidActivity
			or activityInfo.isMythicActivity
		)
	dropdown:SetShown(shouldShowPlayStyleDropdown)
	self.PlayStyleLabel:SetShown(shouldShowPlayStyleDropdown)
	local labelText
	if activityInfo.isRatedPvpActivity then
		labelText = LFG_PLAYSTYLE_LABEL_PVP
	elseif activityInfo.isMythicPlusActivity then
		labelText = LFG_PLAYSTYLE_LABEL_PVE
	elseif activityInfo.isCurrentRaidActivity then
		labelText = LFG_PLAYSTYLE_LABEL_PVE_RAID
	else
		labelText = LFG_PLAYSTYLE_LABEL_PVE_MYTHICZERO
	end
	self.PlayStyleLabel:SetText(labelText)
end

function PremadeFilter_EntrySelect(self, filters, categoryID, groupID, activityID)
	filters = bit.bor(self.baseFilters or 0, filters or 0)
	if (filters == 0) or (filters == self.baseFilters) and activityID then
		filters = C_LFGList.GetActivityInfoTable(activityID).filters or filters
	end
	filters, categoryID, groupID, activityID =
		LFGListUtil_AugmentWithBest(filters, categoryID, groupID, activityID)
	self.selectedCategory = categoryID
	self.selectedGroup = groupID
	self.selectedActivity = activityID
	self.selectedFilters = filters
	local categoryInfo = C_LFGList.GetLfgCategoryInfo(categoryID)
	local activityInfo = C_LFGList.GetActivityInfoTable(activityID)
	if not activityInfo then
		return
	end
	UIDropDownMenu_SetText(
		self.CategoryDropDown,
		LFGListUtil_GetDecoratedCategoryName(categoryInfo.name, filters, false)
	)
	UIDropDownMenu_SetText(self.ActivityDropDown, activityInfo.shortName)
	local groupName = C_LFGList.GetActivityGroupInfo(groupID)
	UIDropDownMenu_SetText(self.GroupDropDown, groupName or activityInfo.shortName)

	local shouldShowPlayStyleDropdown = categoryInfo.showPlaystyleDropdown
		and (
			activityInfo.isMythicPlusActivity
			or activityInfo.isRatedPvpActivity
			or activityInfo.isCurrentRaidActivity
			or activityInfo.isMythicActivity
		)
	if shouldShowPlayStyleDropdown then
		PremadeFilter_OnPlayStyleSelected(
			self,
			self.PlayStyleDropdown,
			self.selectedPlaystyle or Enum.LFGEntryPlaystyle.Standard
		)
	end
	if not shouldShowPlayStyleDropdown then
		self.selectedPlaystyle = nil
	end

	if activityInfo.ilvlSuggestion ~= 0 then
		self.ItemLevel.EditBox.Instructions:SetFormattedText(LFG_LIST_RECOMMENDED_ILVL, activityInfo.ilvlSuggestion)
	else
		self.ItemLevel.EditBox.Instructions:SetText(LFG_LIST_ITEM_LEVEL_INSTR_SHORT)
	end

	self.ActivityDropDown:SetShown(groupName and not categoryInfo.autoChooseActivity)
	self.GroupDropDown:SetShown(not categoryInfo.autoChooseActivity)

	self.PlayStyleCheckButton:SetShown(shouldShowPlayStyleDropdown)
	self.PlayStyleDropdown:SetShown(shouldShowPlayStyleDropdown and self.PlayStyleCheckButton:GetChecked())
	self.PlayStyleLabel:SetShown(shouldShowPlayStyleDropdown)
	self.MythicPlusRating:SetShown(activityInfo.isMythicPlusActivity)
	self.PVPRating:SetShown(activityInfo.isRatedPvpActivity)
	self.ItemLevel:SetShown(not activityInfo.isPvpActivity)
	self.PvpItemLevel:SetShown(activityInfo.isPvpActivity)
end

function PremadeFilter_GetAvailableBosses()
	local bossList = {}
	local activityIndex = string.format(
		"%d-%d-%d",
		PremadeFilter_Frame.selectedCategory,
		PremadeFilter_Frame.selectedGroup,
		PremadeFilter_Frame.selectedActivity
	)
	local activity = PremadeFilter_ActivityInfo[activityIndex]
	if not EncounterJournal then
		EncounterJournal_LoadUI()
	end

	if type(activity) == "table" then
		EncounterJournal_TierDropDown_Select(nil, activity.tier)

		local instanceID = EJ_GetInstanceByIndex(activity.instance, activity.raid)

		if GetLocale() == "zhCN" then --Fix zhCN UI API bug (https://twitter.com/liruqi/status/946870306873909248)
			if activity.tier == 7 and activity.instance == 6 and instanceID == 959 then
				instanceID = 946
			end
		end

		EncounterJournal_DisplayInstance(instanceID)

		if activity.difficulty then
			EncounterJournal_SelectDifficulty(nil, activity.difficulty)
		end

		local encounter = 1
		local boss
		repeat
			boss = EJ_GetEncounterInfoByIndex(encounter, instanceID)
			if boss then
				table.insert(bossList, { name = boss })
			end
			encounter = encounter + 1
		until not boss
	end

	return bossList
end

function PremadeFilter_BossList_Update()
	FauxScrollFrame_Update(PremadeFilter_Frame_BossListScrollFrame, #PremadeFilter_Frame.availableBosses, 10, 16)

	local offset = FauxScrollFrame_GetOffset(PremadeFilter_Frame_BossListScrollFrame)

	for i = 1, 10 do
		local button = _G["PremadeFilter_Frame_BossListButton" .. i]
		local bossIndex = i + offset
		local info = PremadeFilter_Frame.availableBosses[bossIndex]
		if info then
			if type(info.isChecked) == "nil" then
				button.statusButton.CheckedNone = false
				button.statusButton:SetChecked(false)
				button.statusButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
				button.bossName:SetTextColor(0.7, 0.7, 0.7)
			elseif info.isChecked then
				button.statusButton.CheckedNone = false
				button.statusButton:SetChecked(false)
				button.statusButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
				button.statusButton:SetChecked(true)
				button.bossName:SetTextColor(0, 1, 0)
			else
				button.statusButton.CheckedNone = true
				button.statusButton:SetChecked(false)
				button.statusButton:SetCheckedTexture("Interface\\Buttons\\UI-MultiCheck-Up")
				button.statusButton:SetChecked(true)
				button.bossName:SetTextColor(1, 0, 0)
			end

			button.bossName:SetText(info.name)
			button.bossName:SetFontObject(QuestDifficulty_Header)
			button:SetWidth(195)
			button:Show()
		else
			button:Hide()
		end
		button.bossIndex = bossIndex
	end
end

function PremadeFilter_OnCategorySelected(self, id, filters)
	self.selectedCategory = id
	self.selectedFilters = filters

	LFGListCategorySelection_SelectCategory(LFGListFrame.CategorySelection, id, filters)
	PremadeFilter_EntrySelect(self, filters, id, nil, nil)

	PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses()
	PremadeFilter_BossList_Update()

	PremadeFilter_SearchStringFromFilters(self.selectedActivity)
end

function PremadeFilter_OnGroupSelected(self, id, buttonType)
	self.selectedGroup = id

	if buttonType == "activity" then
		PremadeFilter_EntrySelect(self, nil, nil, nil, id)
	elseif buttonType == "group" then
		PremadeFilter_EntrySelect(self, self.selectedFilters, self.selectedCategory, id)
	elseif buttonType == "more" then
		PremadeFilterActivityFinder_Show(self.ActivityFinder, self.selectedCategory, nil)
		return true
	end

	PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses()
	PremadeFilter_BossList_Update()

	PremadeFilter_SearchStringFromFilters(self.selectedActivity)
end

function PremadeFilter_OnActivitySelected(self, id, buttonType)
	self.selectedActivity = id

	if buttonType == "activity" then
		PremadeFilter_EntrySelect(self, nil, nil, nil, id)
	elseif buttonType == "more" then
		PremadeFilterActivityFinder_Show(self.ActivityFinder, self.selectedCategory, self.selectedGroup)
		return true
	end

	PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses()
	PremadeFilter_BossList_Update()

	PremadeFilter_SearchStringFromFilters(id)
end

function PremadeFilter_Frame_OnLoad(self)
	self:RegisterEvent("LFG_LIST_APPLICANT_LIST_UPDATED")
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("CHAT_MSG_ADDON")
	self.AdvancedButton:SetParent(LFGListFrame.SearchPanel)
	self.AdvancedButton:SetPoint("TOPRIGHT", LFGListFrame.SearchPanel.RefreshButton, "TOPLEFT", 0, 0)

	self:SetParent(LFGListFrame.SearchPanel)
	self:SetPoint("TOPLEFT", LFGListFrame.SearchPanel, "TOPRIGHT", 10, -20)
	self:SetPoint("BOTTOMLEFT", LFGListFrame.SearchPanel, "BOTTOMRIGHT", 10, 0)

	LFGListUtil_SetUpDropDown(
		self,
		self.CategoryDropDown,
		PremadeFilter_PopulateCategories,
		PremadeFilter_OnCategorySelected
	)
	LFGListUtil_SetUpDropDown(
		self,
		self.GroupDropDown,
		LFGListEntryCreation_PopulateGroups,
		PremadeFilter_OnGroupSelected
	)
	LFGListUtil_SetUpDropDown(
		self,
		self.ActivityDropDown,
		LFGListEntryCreation_PopulateActivities,
		PremadeFilter_OnActivitySelected
	)
	LFGListUtil_SetUpDropDown(self, self.PlayStyleDropdown, PremadeFilter_SetupPlayStyleDropDown)
	self.baseFilters = 0

	PremadeFilter_OnHide(self)

	self.baseFilters = Enum.LFGListFilter.PvE
	self.selectedFilters = Enum.LFGListFilter.PvE
	self.results = {}
	self.SearchTime = {}
	self.updated = {}
	self.availableBosses = nil
	self.realmName = GetRealmName()
	self.realmInfo = PremadeFilter_GetRealmInfo(GetCurrentRegion(), self.realmName)
	self.realmList = PremadeFilter_GetRegionRealms(self.realmInfo)
	self.visibleRealms = PremadeFilter_GetVisibleRealms()
	self.freshResults = {}
	self.resultInfo = {}
	self.chatNotifications = {}
	self.selectedFilterSet = 0

	PremadeFilter_RealmList_Update()

	QueueStatusButton:HookScript("OnShow", function()
		PremadeFilter_StopMonitoring()
	end)

	self.oldHyperlinkClick = DEFAULT_CHAT_FRAME:GetScript("OnHyperlinkClick")
	DEFAULT_CHAT_FRAME:SetScript("OnHyperlinkClick", PremadeFilter_Hyperlink_OnClick)

	self.oldHyperlinkEnter = DEFAULT_CHAT_FRAME:GetScript("OnHyperlinkEnter")
	self.oldHyperlinkLeave = DEFAULT_CHAT_FRAME:GetScript("OnHyperlinkLeave")
	DEFAULT_CHAT_FRAME:SetScript("OnHyperlinkEnter", PremadeFilter_Hyperlink_OnEnter)
	DEFAULT_CHAT_FRAME:SetScript("OnHyperlinkLeave", PremadeFilter_Hyperlink_OnLeave)

	C_ChatInfo.RegisterAddonMessagePrefix("PREMADE_FILTER")
end

function PremadeFilter_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		local addonName = ...
		if addonName == "premade-filter" then
			if not PremadeFilter_Data then
				PremadeFilter_Data = {}
			end
		end
	elseif event == "LFG_LIST_APPLICANT_LIST_UPDATED" then
		PremadeFilter_OnApplicantListUpdated(self, event, ...)
	elseif event == "CHAT_MSG_ADDON" then
		local prefix, msg, _, sender = ...

		if prefix == "PREMADE_FILTER" then
			if msg == "VER?" then
				local player = UnitName("player")
				local version = GetAddOnMetadata("premade-filter", "Version")

				C_ChatInfo.SendAddonMessage("PREMADE_FILTER", "VER!" .. player .. ":" .. version, "WHISPER", sender)

				if DEBUG_PF then
					PremadeFilter_PrintMessage(DEFAULT_CHAT_FRAME, sender .. " requested addon version")
				end
			elseif msg:sub(1, 4) == "VER!" then
				local version = GetAddOnMetadata("premade-filter", "Version")
				local receivedVersion = msg:gsub("^VER%!(.+):(.+)$", "%2")
				if receivedVersion > version then
					PremadeFilter_PrintMessage(DEFAULT_CHAT_FRAME, T("New version available"))
				end

				if DEBUG_PF then
					PremadeFilter_PrintMessage(DEFAULT_CHAT_FRAME, msg:sub(5))
				end
			end
		end
	end
end

function PremadeFilter_FixSettings()
	if type(PremadeFilter_Data.Settings) ~= "table" then
		PremadeFilter_Data.Settings = PremadeFilter_DefaultSettings
	end

	if not PremadeFilter_Data.Settings.Version then
		PremadeFilter_Data.Settings = PremadeFilter_DefaultSettings
		PremadeFilter_Data.Settings.Version = GetAddOnMetadata("premade-filter", "Version")
	elseif PremadeFilter_Data.Settings.Version == "0.8.4" then
		PremadeFilter_Data.Settings.NewGroupChatNotifications = PremadeFilter_DefaultSettings.NewGroupChatNotifications
		PremadeFilter_Data.Settings.ChatNotifications = nil
		PremadeFilter_Data.Settings.NewPlayerChatNotifications = PremadeFilter_Data.Settings.ChatNotifications
		PremadeFilter_Data.Settings.ScrollOnTop = false
		PremadeFilter_Data.Settings.Version = "0.9.94"
	elseif PremadeFilter_Data.Settings.Version ~= GetAddOnMetadata("premade-filter", "Version") then
		PremadeFilter_Data.Settings.Version = GetAddOnMetadata("premade-filter", "Version")
	end
	if PremadeFilter_Data.Settings.ScrollOnTop == nil then
		PremadeFilter_Data.Settings.ScrollOnTop = false
	end
	if PremadeFilter_Data.Settings.AutoFillSearchBox == nil then
		PremadeFilter_Data.Settings.AutoFillSearchBox = true
	end

	if
		type(PremadeFilter_Data.Settings.UpdateInterval) ~= "number"
		or PremadeFilter_Data.Settings.UpdateInterval < 2
		or PremadeFilter_Data.Settings.UpdateInterval > 60
	then
		PremadeFilter_Data.Settings.UpdateInterval = PremadeFilter_DefaultSettings.UpdateInterval
	end
end

function PremadeFilter_SetSettings(name, value)
	PremadeFilter_FixSettings()

	if name then
		PremadeFilter_Data.Settings[name] = value
	else
		PremadeFilter_Data.Settings = value
	end

	PremadeFilter_FixSettings()
end

function PremadeFilter_GetSettings(name)
	PremadeFilter_FixSettings()

	if name then
		if PremadeFilter_Data.Settings[name] == nil then
			PremadeFilter_Data.Settings[name] = PremadeFilter_DefaultSettings[name]
		end
		return PremadeFilter_Data.Settings[name]
	else
		return PremadeFilter_Data.Settings
	end
end

do
	function PremadeFilter_GetGreaterGroupId(CategoryId, Filters)
		if not CategoryId or not Filters then
			return nil
		end
		local Groups = C_LFGList.GetAvailableActivityGroups(CategoryId, Filters)
		if Groups then
			table.sort(Groups)
			return Groups[#Groups]
		end
		return nil
	end

	function PremadeFilter_GetGreaterActivityId(CategoryId, GroupID, Filters)
		if not CategoryId or not GroupID or not Filters then
			return nil
		end
		local Activities = C_LFGList.GetAvailableActivities(CategoryId, GroupID, Filters)
		if Activities then
			table.sort(Activities)
			return Activities[#Activities]
		end
		return nil
	end
end

function PremadeFilter_Frame_AdvancedButton_OnShow()
	if LFGListFrame.SearchPanel.ScrollBar:IsVisible() and not _G["LFGListFrame"].SearchPanel.ScrollBar.CheckButton then
		local Points = { one = {}, two = {} }

		Points["one"].this, Points["one"].to, Points["one"].that, Points["one"].x, Points["one"].y =
			LFGListFrame.SearchPanel.ScrollBar:GetPoint(2)
		local ScrollOnTopCheckBox = CreateFrame(
			"CheckButton",
			"LFGListFrame.SearchPanel.ScrollBar.CheckButton",
			LFGListFrame.SearchPanel.ScrollBar,
			"PremadeFilter_ScrollBarCheckButtonTemplate"
		)
		ScrollOnTopCheckBox:SetSize(
			LFGListFrame.SearchPanel.ScrollBar.Background.Begin:GetWidth(),
			LFGListFrame.SearchPanel.ScrollBar.Background.Begin:GetWidth()
		)
		ScrollOnTopCheckBox:SetPoint("TOPLEFT", LFGListFrame.SearchPanel.ScrollBox, "TOPRIGHT", 0, 7)
		LFGListFrame.SearchPanel.ScrollBar:ClearAllPoints()
		LFGListFrame.SearchPanel.ScrollBar:SetPoint("TOPRIGHT", ScrollOnTopCheckBox, "BOTTOMRIGHT", 0, 6)
		LFGListFrame.SearchPanel.ScrollBar:SetPoint(
			Points["one"].this,
			Points["one"].to,
			Points["one"].that,
			Points["one"].x,
			Points["one"].y
		)

		ScrollOnTopCheckBox:SetChecked(PremadeFilter_Data.Settings.ScrollOnTop)
		ScrollOnTopCheckBox:SetScript("PostClick", function()
			PremadeFilter_Data.Settings.ScrollOnTop = ScrollOnTopCheckBox:GetChecked()
		end)

		local success = LFGListFrame.SearchPanel:HookScript("OnShow", function()
			LFGListFrame.SearchPanel.SearchBox:SetWidth(LFGListFrame.SearchPanel.SearchBox:GetWidth() - 18)
		end)
		if success then
			Points["two"].this, Points["two"].to, Points["two"].that, Points["two"].x, Points["two"].y =
				LFGListFrame.SearchPanel.FilterButton:GetPoint(1)
			LFGListFrame.SearchPanel.FilterButton:ClearAllPoints()
			LFGListFrame.SearchPanel.FilterButton:SetPoint(
				Points["two"].this,
				Points["two"].to,
				Points["two"].that,
				Points["two"].x + 18,
				Points["two"].y
			)

			local AutoFillCheckBox = CreateFrame(
				"CheckButton",
				"LFGListSearchPanelSearchBoxAutoFillCheckButton",
				LFGListFrame.SearchPanel,
				"PremadeFilter_SearchBoxCheckButtonTemplate"
			)
			AutoFillCheckBox:SetSize(18, 29)
			AutoFillCheckBox:SetPoint(
				Points["two"].this,
				Points["two"].to,
				Points["two"].that,
				Points["two"].x - 1,
				Points["two"].y
			)
			AutoFillCheckBox:SetChecked(PremadeFilter_Data.Settings.AutoFillSearchBox)
			AutoFillCheckBox:SetScript("PostClick", function()
				PremadeFilter_Data.Settings.AutoFillSearchBox = AutoFillCheckBox:GetChecked()
			end)
		end
	end
end

function PremadeFilter_OnShow(self)
	local categoryID = LFGListFrame.categoryID
	local baseFilters = LFGListFrame.baseFilters

	self.categoryID = categoryID
	self.baseFilters = baseFilters

	local selectedCategory
	local selectedFilters
	local selectedGroup
	local selectedActivity

	if
		self.selectedCategory ~= LFGListFrame.CategorySelection.selectedCategory
		or self.selectedFilters ~= LFGListFrame.CategorySelection.selectedFilters
	then
		selectedCategory = LFGListFrame.CategorySelection.selectedCategory
		selectedFilters = LFGListFrame.CategorySelection.selectedFilters
		selectedGroup = PremadeFilter_GetGreaterGroupId(
			LFGListFrame.CategorySelection.selectedCategory,
			LFGListFrame.CategorySelection.selectedFilters
		)
		selectedActivity = PremadeFilter_GetGreaterActivityId(
			LFGListFrame.CategorySelection.selectedCategory,
			selectedGroup,
			LFGListFrame.CategorySelection.selectedFilters
		)
	else
		selectedCategory = self.selectedCategory
		selectedFilters = self.selectedFilters
		selectedGroup = self.selectedGroup
		selectedActivity = self.selectedActivity
	end

	PremadeFilter_EntrySelect(self, selectedFilters, selectedCategory, selectedGroup, selectedActivity)

	PremadeFilter_SearchStringFromFilters(selectedActivity)

	if type(self.availableBosses) ~= "table" or #self.availableBosses <= 0 then
		self.availableBosses = PremadeFilter_GetAvailableBosses()
		PremadeFilter_BossList_Update()
	end

	self.AdvancedButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
	self.AdvancedButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
	self.AdvancedButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")

	if not PremadeFilter_Frame.ShowNextTime then
		PremadeFilter_MinimapButton:Hide()
		PremadeFilter_MinimapButton.Eye:StopAnimating()
	end

	PremadeFilter_StopNotification()

	PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
end

function PremadeFilter_OnHide(self)
	self.AdvancedButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	self.AdvancedButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	self.AdvancedButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")

	StaticPopup_Hide("PREMADEFILTER_CONFIRM_CLOSE")
	StaticPopup_Hide("PREMADEFILTER_SAVE_FILTERSET")

	HelpPlate_Hide()
end

function PremadeFilter_Toggle()
	if PremadeFilter_Frame:IsVisible() then
		if QueueStatusButton:IsVisible() or PremadeFilter_Frame.closeConfirmation then
			PremadeFilter_Frame:Hide()
		else
			StaticPopup_Show("PREMADEFILTER_CONFIRM_CLOSE")
		end
	else
		PremadeFilter_Frame:Show()
	end
end

function PremadeFilter_FilterButton_OnClick(self)
	LFGListSearchPanel_SetCategory(
		LFGListFrame.SearchPanel,
		PremadeFilter_Frame.selectedCategory,
		PremadeFilter_Frame.selectedFilters,
		PremadeFilter_Frame.baseFilters
	)
	LFGListSearchPanel_DoSearch(self:GetParent():GetParent())
end

function PremadeFilter_GetRealmInfo(region, realmName)
	for index, info in pairs(PremadeFilter_Realms) do
		if info.region == region and info.name == realmName then
			return info
		end
	end

	return nil
end

function PremadeFilter_GetRegionRealms(realmInfo)
	if not realmInfo then
		return nil
	end

	local realmList = {}
	local chapter = nil
	local currentChapterIndex = nil

	for index, info in pairs(PremadeFilter_Realms) do
		if info.region == realmInfo.region then
			if info.chapter ~= chapter then
				chapter = info.chapter
				currentChapterIndex = #realmList + 1

				-- add chapter
				table.insert(realmList, {
					isChapter = true,
					isCollapsed = true,
					name = PremadeFilter_RealmChapters[info.region][info.chapter],
					region = info.region,
					chapter = info.chapter,
					index = currentChapterIndex,
					isChecked = true,
				})
			end

			-- add realm
			info.index = #realmList + 1
			info.chapterIndex = currentChapterIndex
			info.isChecked = true
			table.insert(realmList, info)
		end
	end

	return realmList
end

function PremadeFilter_GetVisibleRealms()
	local visibleRealms = {}

	if PremadeFilter_Frame.realmList then
		for i = 1, #PremadeFilter_Frame.realmList do
			local info = PremadeFilter_Frame.realmList[i]
			if info.isChapter or not PremadeFilter_Frame.realmList[info.chapterIndex].isCollapsed then
				table.insert(visibleRealms, info)
			end
		end
	end

	return visibleRealms
end

function PremadeFilter_GetSelectedRealms()
	if not PremadeFilter_Frame.realmList then
		return nil
	end

	local selectedRealms = { "" }
	local totalRealms = 1

	for i = 1, #PremadeFilter_Frame.realmList do
		local info = PremadeFilter_Frame.realmList[i]
		if not info.isChapter then
			totalRealms = totalRealms + 1
			if info.isChecked then
				local name = info.name:gsub("[%s%']+", "")
				table.insert(selectedRealms, name:lower())
			end
		end
	end

	if #selectedRealms == totalRealms then
		-- all realms selected
		return nil
	else
		return selectedRealms
	end
end

function PremadeFilter_ExpandOrCollapseButton_OnClick(self, button)
	local info = self:GetParent().info

	PremadeFilter_Frame.realmList[info.index].isCollapsed = not info.isCollapsed
	PremadeFilter_Frame.visibleRealms = PremadeFilter_GetVisibleRealms()

	PremadeFilter_RealmList_Update()
end

function PremadeFilter_RealmListCheckButton_OnClick(button, _, _, _)
	local info = button:GetParent().info
	local update = info.isChapter and not info.isCollapsed
	local isChecked = button:GetChecked()

	if info.isChapter then
		repeat
			PremadeFilter_Frame.realmList[info.index].isChecked = isChecked
			info = PremadeFilter_Frame.realmList[info.index + 1]
		until not info or info.isChapter
	else
		PremadeFilter_Frame.realmList[info.index].isChecked = isChecked

		local chapterInfo = PremadeFilter_Frame.realmList[info.chapterIndex]
		local chapterChecked = true
		info = PremadeFilter_Frame.realmList[chapterInfo.index + 1]
		repeat
			chapterChecked = chapterChecked and info.isChecked
			info = PremadeFilter_Frame.realmList[info.index + 1]
		until not chapterChecked or not info or info.isChapter

		if chapterChecked ~= chapterInfo.isChecked then
			PremadeFilter_Frame.realmList[chapterInfo.index].isChecked = chapterChecked
			update = true
		end
	end

	if update then
		PremadeFilter_RealmList_Update()
	end

	PlaySound(isChecked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
end

function PremadeFilter_RealmList_Update()
	FauxScrollFrame_Update(PremadeFilter_Frame_RealmListScrollFrame, #PremadeFilter_Frame.visibleRealms, 16, 16)

	local offset = FauxScrollFrame_GetOffset(PremadeFilter_Frame_RealmListScrollFrame)

	for i = 1, 16 do
		local button = _G["PremadeFilter_Frame_RealmListButton" .. i]
		local info = PremadeFilter_Frame.visibleRealms[i + offset]
		if info then
			button.info = info
			button.instanceName:SetText(info.name)
			button.instanceName:SetFontObject(QuestDifficulty_Header)
			button.instanceName:SetPoint("RIGHT", button, "RIGHT", 0, 0)

			if info.isChapter then
				if info.isCollapsed then
					button.expandOrCollapseButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
				else
					button.expandOrCollapseButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
				end
				button.expandOrCollapseButton:Show()
			else
				button.expandOrCollapseButton:Hide()
			end

			button.enableButton:SetChecked(info.isChecked)

			button:SetWidth(195)
			button:Show()
		else
			button:Hide()
		end
	end
end

function PremadeFilterActivityFinder_OnLoad(self)
	self.Dialog.ScrollFrame.update = function()
		PremadeFilterActivityFinder_Update(self)
	end
	self.Dialog.ScrollFrame.scrollBar.doNotHide = true
	HybridScrollFrame_CreateButtons(self.Dialog.ScrollFrame, "PremadeFilterActivityListTemplate")

	self.matchingActivities = {}
end

function PremadeFilterActivityFinder_Show(self, categoryID, groupID, filters)
	self.Dialog.EntryBox:SetText("")
	self.categoryID = categoryID
	self.groupID = groupID
	self.filters = filters
	self.selectedActivity = nil
	PremadeFilterActivityFinder_UpdateMatching(self)
	self:Show()
	self.Dialog.EntryBox:SetFocus()
end

function PremadeFilterActivityFinder_UpdateMatching(self)
	self.matchingActivities = C_LFGList.GetAvailableActivities(self.categoryID, self.groupID, self.filters)
	LFGListUtil_SortActivitiesByRelevancy(self.matchingActivities)
	if not self.selectedActivity or not tContains(self.matchingActivities, self.selectedActivity) then
		self.selectedActivity = self.matchingActivities[1]
	end
	PremadeFilterActivityFinder_Update(self)
end

function PremadeFilterActivityFinder_Update(self)
	local activities = self.matchingActivities

	local offset = HybridScrollFrame_GetOffset(self.Dialog.ScrollFrame)

	for i = 1, #self.Dialog.ScrollFrame.buttons do
		local button = self.Dialog.ScrollFrame.buttons[i]
		local idx = i + offset
		local id = activities[idx]
		if id then
			button:SetText(C_LFGList.GetActivityInfoTable(id).fullName)
			button.activityID = id
			button.Selected:SetShown(self.selectedActivity == id)
			if self.selectedActivity == id then
				button:LockHighlight()
			else
				button:UnlockHighlight()
			end
			button:Show()
		else
			button:Hide()
		end
	end

	HybridScrollFrame_Update(
		self.Dialog.ScrollFrame,
		self.Dialog.ScrollFrame.buttons[1]:GetHeight() * #activities,
		self.Dialog.ScrollFrame:GetHeight()
	)
end

function PremadeFilterActivityFinder_Accept(self)
	if self.selectedActivity then
		PremadeFilter_OnActivitySelected(self:GetParent(), self.selectedActivity, "activity")
		PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses()
		PremadeFilter_BossList_Update()
	end
	self:Hide()
end

function PremadeFilterActivityFinder_Cancel(self)
	self:Hide()
end

function PremadeFilterActivityFinder_Select(self, activityID)
	self.selectedActivity = activityID
	PremadeFilterActivityFinder_Update(self)
end

function LFGListSearchPanel_DoSearch(self)
	local visible = PremadeFilter_Frame:IsVisible()
	local category = PremadeFilter_Frame.selectedCategory
	local searchText = self.SearchBox:GetText()
	local languages = C_LFGList.GetLanguageSearchFilter()

	if LFGListFrame.SearchPanel.ScrollBox:IsVisible() and PremadeFilter_Data.Settings.ScrollOnTop then
		LFGListFrame.SearchPanel.ScrollBox:ScrollToBegin()
	end

	if visible and category then
		C_LFGList.Search(category, self.filters, self.preferredFilters, languages)
	else
		category = self.categoryID
		if not category then
			return
		end
		C_LFGList.Search(category, self.filters, self.preferredFilters, languages)
	end

	PremadeFilter_Frame.selectedCategory = category
	if PremadeFilter_Frame.SearchTime[PremadeFilter_Frame.selectedCategory] then
		PremadeFilter_Frame.updated[PremadeFilter_Frame.selectedCategory] =
			PremadeFilter_Frame.SearchTime[PremadeFilter_Frame.selectedCategory]
	else
		PremadeFilter_Frame.updated[PremadeFilter_Frame.selectedCategory] = time()
	end
	if not self.searching or not PremadeFilter_Frame.SearchTime[PremadeFilter_Frame.selectedCategory] then
		PremadeFilter_Frame.SearchTime[PremadeFilter_Frame.selectedCategory] = time()
	end
	PremadeFilter_Frame.extraFilters = PremadeFilter_GetFilters()

	self.searching = true
	self.searchFailed = false
	self.selectedResult = nil

	LFGListSearchPanel_UpdateResultList(self)

	-- If auto-create is desired, then the caller needs to set up that data after the search begins.
	-- There's an issue with using OnTextChanged to handle this due to how OnShow processes the update.
	if self.previousSearchText ~= searchText then
		LFGListEntryCreation_ClearAutoCreateMode(self:GetParent().EntryCreation)
	end

	self.previousSearchText = searchText

	if not PremadeFilter_MinimapButton:IsVisible() then
		PremadeFilter_MinimapButton.LastUpdate = 0
	end
end

function PremadeFilter_GetFilters()
	if not PremadeFilter_Frame:IsVisible() and not PremadeFilter_MinimapButton:IsVisible() then
		return nil
	end

	local filters = {}

	-- category
	filters.category = PremadeFilter_Frame.selectedCategory

	-- group
	filters.group = PremadeFilter_Frame.selectedGroup

	-- activity
	filters.activity = PremadeFilter_Frame.selectedActivity

	-- item level
	if PremadeFilter_Frame.ItemLevel.CheckButton:GetChecked() and PremadeFilter_Frame.ItemLevel:IsShown() then
		filters.ilvl = tonumber(PremadeFilter_Frame.ItemLevel.EditBox:GetText())
	elseif PremadeFilter_Frame.PvpItemLevel.CheckButton:GetChecked() and PremadeFilter_Frame.PvpItemLevel:IsShown() then
		filters.ilvl = tonumber(PremadeFilter_Frame.PvpItemLevel.EditBox:GetText())
	end

	-- Play style
	if PremadeFilter_Frame.PlayStyleCheckButton:GetChecked() and PremadeFilter_Frame.PlayStyleCheckButton:IsShown() then
		filters.pstyle = PremadeFilter_Frame.selectedPlaystyle
	end

	--Mythic+ rating
	if
		PremadeFilter_Frame.MythicPlusRating.CheckButton:GetChecked()
		and PremadeFilter_Frame.MythicPlusRating:IsShown()
	then
		filters.mpr = tonumber(PremadeFilter_Frame.MythicPlusRating.EditBox:GetText())
	end

	--PvP rating
	if PremadeFilter_Frame.PVPRating.CheckButton:GetChecked() and PremadeFilter_Frame.PVPRating:IsShown() then
		filters.pvpr = tonumber(PremadeFilter_Frame.PVPRating.EditBox:GetText())
	end

	-- voice chat
	if PremadeFilter_Frame.VoiceChat.CheckButton:GetChecked() then
		local vcNone = PremadeFilter_Frame.VoiceChat.CheckButton.CheckedNone
		filters.vc = {
			Checked = true,
			none = vcNone,
		}
	else
		filters.vc = {
			Checked = false,
			none = false,
		}
	end

	-- realm
	local selectedRealms = PremadeFilter_GetSelectedRealms()
	if selectedRealms then
		filters.realms = table.concat(selectedRealms, "-")
	end

	-- members
	if PremadeFilter_Frame.PlayersTankCheckButton:GetChecked() then
		filters.minTanks = tonumber(PremadeFilter_Frame.MinTanks:GetText())
		filters.maxTanks = tonumber(PremadeFilter_Frame.MaxTanks:GetText())
	end
	if PremadeFilter_Frame.PlayersHealerCheckButton:GetChecked() then
		filters.minHealers = tonumber(PremadeFilter_Frame.MinHealers:GetText())
		filters.maxHealers = tonumber(PremadeFilter_Frame.MaxHealers:GetText())
	end
	if PremadeFilter_Frame.PlayersDamagerCheckButton:GetChecked() then
		filters.minDamagers = tonumber(PremadeFilter_Frame.MinDamagers:GetText())
		filters.maxDamagers = tonumber(PremadeFilter_Frame.MaxDamagers:GetText())
	end

	-- bosses
	if type(PremadeFilter_Frame.availableBosses) == "table" and #PremadeFilter_Frame.availableBosses > 0 then
		filters.bosses = {}
		for index, info in pairs(PremadeFilter_Frame.availableBosses) do
			if type(info.isChecked) ~= "nil" then
				filters.bosses[info.name] = info.isChecked
			end
		end
	end

	return filters
end

function PremadeFilter_SetFilters(filters)
	PremadeFilter_Frame.selectedCategory = filters.category
	PremadeFilter_EntrySelect(
		PremadeFilter_Frame,
		PremadeFilter_Frame.selectedFilters,
		filters.category,
		filters.group,
		filters.activity
	)

	PremadeFilter_SearchStringFromFilters(filters.activity)

	PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses()

	-- item level
	if type(filters.ilvl) == "number" and filters.ilvl > 0 and PremadeFilter_Frame.ItemLevel:IsShown() then
		PremadeFilter_Frame.ItemLevel.CheckButton:SetChecked(true)
		PremadeFilter_Frame.ItemLevel.EditBox:SetText(filters.ilvl)
		PremadeFilter_Frame.ItemLevel.EditBox:Show()
		PremadeFilter_Frame.PvpItemLevel.CheckButton:SetChecked(false)
		PremadeFilter_Frame.PvpItemLevel.EditBox:SetText("")
		PremadeFilter_Frame.PvpItemLevel.EditBox:Hide()
	elseif type(filters.ilvl) == "number" and filters.ilvl > 0 and PremadeFilter_Frame.PvpItemLevel:IsShown() then
		PremadeFilter_Frame.PvpItemLevel.CheckButton:SetChecked(true)
		PremadeFilter_Frame.PvpItemLevel.EditBox:SetText(filters.ilvl)
		PremadeFilter_Frame.PvpItemLevel.EditBox:Show()
		PremadeFilter_Frame.ItemLevel.CheckButton:SetChecked(false)
		PremadeFilter_Frame.ItemLevel.EditBox:SetText("")
		PremadeFilter_Frame.ItemLevel.EditBox:Hide()
	else
		PremadeFilter_Frame.ItemLevel.CheckButton:SetChecked(false)
		PremadeFilter_Frame.ItemLevel.EditBox:SetText("")
		PremadeFilter_Frame.ItemLevel.EditBox:Hide()
		PremadeFilter_Frame.PvpItemLevel.CheckButton:SetChecked(false)
		PremadeFilter_Frame.PvpItemLevel.EditBox:SetText("")
		PremadeFilter_Frame.PvpItemLevel.EditBox:Hide()
	end

	--Play style
	if filters.pstyle and filters.pstyle ~= 0 and PremadeFilter_Frame.PlayStyleCheckButton:IsShown() then
		PremadeFilter_Frame.PlayStyleCheckButton:SetChecked(true)
		PremadeFilter_Frame.PlayStyleDropdown:SetShown(true)
		PremadeFilter_OnPlayStyleSelected(PremadeFilter_Frame, PremadeFilter_Frame.PlayStyleDropdown, filters.pstyle)
	else
		PremadeFilter_Frame.PlayStyleCheckButton:SetChecked(false)
		PremadeFilter_Frame.PlayStyleDropdown:SetShown(false)
		PremadeFilter_OnPlayStyleSelected(
			PremadeFilter_Frame,
			PremadeFilter_Frame.PlayStyleDropdown,
			Enum.LFGEntryPlaystyle.Standard
		)
	end

	--Mythic+ rating
	if type(filters.mpr) == "number" and filters.mpr > 0 and PremadeFilter_Frame.MythicPlusRating:IsShown() then
		PremadeFilter_Frame.MythicPlusRating.CheckButton:SetChecked(true)
		PremadeFilter_Frame.MythicPlusRating.EditBox:SetText(filters.mpr)
		PremadeFilter_Frame.MythicPlusRating.EditBox:Show()
	else
		PremadeFilter_Frame.MythicPlusRating.CheckButton:SetChecked(false)
		PremadeFilter_Frame.MythicPlusRating.EditBox:SetText("")
		PremadeFilter_Frame.MythicPlusRating.EditBox:Hide()
	end

	--PvP rating
	if type(filters.pvpr) == "number" and filters.pvpr > 0 and PremadeFilter_Frame.PVPRating:IsShown() then
		PremadeFilter_Frame.PVPRating.CheckButton:SetChecked(true)
		PremadeFilter_Frame.PVPRating.EditBox:SetText(filters.pvpr)
		PremadeFilter_Frame.PVPRating.EditBox:Show()
	else
		PremadeFilter_Frame.PVPRating.CheckButton:SetChecked(false)
		PremadeFilter_Frame.PVPRating.EditBox:SetText("")
		PremadeFilter_Frame.PVPRating.EditBox:Hide()
	end

	-- voice chat
	PremadeFilter_Frame.VoiceChat.CheckButton:SetChecked(false)
	PremadeFilter_Frame.VoiceChat.CheckButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	if type(filters.vc) == "table" then
		PremadeFilter_Frame.VoiceChat.CheckButton.CheckedNone = filters.vc.none
		if filters.vc.Checked then
			PremadeFilter_Frame.VoiceChat.CheckButton:SetChecked(false)
			if filters.vc.none then
				PremadeFilter_Frame.VoiceChat.CheckButton:SetCheckedTexture("Interface\\Buttons\\UI-MultiCheck-Up")
			end
			PremadeFilter_Frame.VoiceChat.CheckButton:SetChecked(true)
		end
	end

	-- realm
	if filters.realms and PremadeFilter_Frame.realmList then
		local noneChecked
		for i = 1, #PremadeFilter_Frame.realmList do
			if PremadeFilter_Frame.realmList[i].isChapter then
				if i > 1 then
					local chapter = PremadeFilter_Frame.realmList[i - 1].chapterIndex
					if noneChecked then
						PremadeFilter_Frame.realmList[chapter].isCollapsed = true
					end
				end
				PremadeFilter_Frame.realmList[i].isChecked = true
				PremadeFilter_Frame.realmList[i].isCollapsed = true
				noneChecked = true
			else
				local chapter = PremadeFilter_Frame.realmList[i].chapterIndex
				local name = PremadeFilter_Frame.realmList[i].name:gsub("[%s%']+", "")
				local checked = (filters.realms:find("-" .. name:lower(), 1, true) ~= nil)

				PremadeFilter_Frame.realmList[i].isChecked = checked

				if not checked then
					PremadeFilter_Frame.realmList[chapter].isChecked = false
					PremadeFilter_Frame.realmList[chapter].isCollapsed = false
				else
					noneChecked = false
				end
			end
		end

		if noneChecked then
			local lastRealm = #PremadeFilter_Frame.realmList
			local lastChapter = PremadeFilter_Frame.realmList[lastRealm].chapterIndex
			PremadeFilter_Frame.realmList[lastChapter].isCollapsed = true
		end
	elseif PremadeFilter_Frame.realmList then
		for i = 1, #PremadeFilter_Frame.realmList do
			PremadeFilter_Frame.realmList[i].isChecked = true
			PremadeFilter_Frame.realmList[i].isCollapsed = true
		end
	end
	PremadeFilter_Frame.visibleRealms = PremadeFilter_GetVisibleRealms()
	PremadeFilter_RealmList_Update()

	-- members
	PremadeFilter_Frame.PlayersTankCheckButton:SetChecked(false)
	PremadeFilter_Frame.MinTanks:SetText("")
	PremadeFilter_Frame.MaxTanks:SetText("")
	PremadeFilter_Frame.PlayersNoTankMinLabel:Show()
	PremadeFilter_Frame.PlayersNoTankMaxLabel:Show()
	PremadeFilter_Frame.MinTanks:Hide()
	PremadeFilter_Frame.MaxTanks:Hide()
	if type(filters.minTanks) == "number" then
		PremadeFilter_Frame.PlayersTankCheckButton:SetChecked(true)
		PremadeFilter_Frame.MinTanks:SetText(filters.minTanks)
		PremadeFilter_Frame.PlayersNoTankMinLabel:Hide()
		PremadeFilter_Frame.PlayersNoTankMaxLabel:Hide()
		PremadeFilter_Frame.MinTanks:Show()
		PremadeFilter_Frame.MaxTanks:Show()
	end
	if type(filters.maxTanks) == "number" then
		PremadeFilter_Frame.PlayersTankCheckButton:SetChecked(true)
		PremadeFilter_Frame.MaxTanks:SetText(filters.maxTanks)
		PremadeFilter_Frame.PlayersNoTankMinLabel:Hide()
		PremadeFilter_Frame.PlayersNoTankMaxLabel:Hide()
		PremadeFilter_Frame.MinTanks:Show()
		PremadeFilter_Frame.MaxTanks:Show()
	end

	PremadeFilter_Frame.PlayersHealerCheckButton:SetChecked(false)
	PremadeFilter_Frame.MinHealers:SetText("")
	PremadeFilter_Frame.MaxHealers:SetText("")
	PremadeFilter_Frame.PlayersNoHealerMinLabel:Show()
	PremadeFilter_Frame.PlayersNoHealerMaxLabel:Show()
	PremadeFilter_Frame.MinHealers:Hide()
	PremadeFilter_Frame.MaxHealers:Hide()
	if type(filters.minHealers) == "number" then
		PremadeFilter_Frame.PlayersHealerCheckButton:SetChecked(true)
		PremadeFilter_Frame.MinHealers:SetText(filters.minHealers)
		PremadeFilter_Frame.PlayersNoHealerMinLabel:Hide()
		PremadeFilter_Frame.PlayersNoHealerMaxLabel:Hide()
		PremadeFilter_Frame.MinHealers:Show()
		PremadeFilter_Frame.MaxHealers:Show()
	end
	if type(filters.maxHealers) == "number" then
		PremadeFilter_Frame.PlayersHealerCheckButton:SetChecked(true)
		PremadeFilter_Frame.MaxHealers:SetText(filters.maxHealers)
		PremadeFilter_Frame.PlayersNoHealerMinLabel:Hide()
		PremadeFilter_Frame.PlayersNoHealerMaxLabel:Hide()
		PremadeFilter_Frame.MinHealers:Show()
		PremadeFilter_Frame.MaxHealers:Show()
	end

	PremadeFilter_Frame.PlayersDamagerCheckButton:SetChecked(false)
	PremadeFilter_Frame.MinDamagers:SetText("")
	PremadeFilter_Frame.MaxDamagers:SetText("")
	PremadeFilter_Frame.PlayersNoDamagerMinLabel:Show()
	PremadeFilter_Frame.PlayersNoDamagerMaxLabel:Show()
	PremadeFilter_Frame.MinDamagers:Hide()
	PremadeFilter_Frame.MaxDamagers:Hide()
	if type(filters.minDamagers) == "number" then
		PremadeFilter_Frame.PlayersDamagerCheckButton:SetChecked(true)
		PremadeFilter_Frame.MinDamagers:SetText(filters.minDamagers)
		PremadeFilter_Frame.PlayersNoDamagerMinLabel:Hide()
		PremadeFilter_Frame.PlayersNoDamagerMaxLabel:Hide()
		PremadeFilter_Frame.MinDamagers:Show()
		PremadeFilter_Frame.MaxDamagers:Show()
	end
	if type(filters.maxDamagers) == "number" then
		PremadeFilter_Frame.PlayersDamagerCheckButton:SetChecked(true)
		PremadeFilter_Frame.MaxDamagers:SetText(filters.maxDamagers)
		PremadeFilter_Frame.PlayersNoDamagerMinLabel:Hide()
		PremadeFilter_Frame.PlayersNoDamagerMaxLabel:Hide()
		PremadeFilter_Frame.MinDamagers:Show()
		PremadeFilter_Frame.MaxDamagers:Show()
	end

	-- bosses
	for index, info in pairs(PremadeFilter_Frame.availableBosses) do
		if type(filters.bosses) == "table" and type(filters.bosses[info.name]) ~= "nil" then
			PremadeFilter_Frame.availableBosses[index].isChecked = filters.bosses[info.name]
		else
			PremadeFilter_Frame.availableBosses[index].isChecked = nil
		end
	end

	PremadeFilter_BossList_Update()
end

function PremadeFilter_GetInfoName(PFGIN_activityID, PFGIN_name, PFGIN_leaderName)
	return PFGIN_activityID .. "-" .. PFGIN_name .. "-" .. (PFGIN_leaderName or "")
end

function LFGListSearchPanel_UpdateResultList(self)
	if not self.searching then
		self.totalResults, self.results = C_LFGList.GetFilteredSearchResults()
		local numResults = 0
		local extraFilters = PremadeFilter_Frame.extraFilters
		local newResults = {}
		PremadeFilter_Frame.freshResults = {}

		if not PremadeFilter_Frame.selectedCategory then
			PremadeFilter_Frame.selectedCategory = LFGListFrame.CategorySelection.selectedCategory
		end

		for i = 1, #self.results do
			local resultID = self.results[i]
			local searchResultInfo = C_LFGList.GetSearchResultInfo(resultID)
			local age = searchResultInfo.age
			local activityID = searchResultInfo.activityID
			local leaderName = searchResultInfo.leaderName
			local voiceChat = searchResultInfo.voiceChat
			local ActivityInfoTable = C_LFGList.GetActivityInfoTable(activityID, nil, searchResultInfo.isWarMode)
			local categoryID = ActivityInfoTable.categoryID
			local groupID = ActivityInfoTable.groupFinderActivityGroupID
			local memberCounts = C_LFGList.GetSearchResultMemberCounts(resultID)
			local name = searchResultInfo.name
			local infoName = PremadeFilter_GetInfoName(activityID, name)
			local matches = true

			if extraFilters then
				-- category
				if matches and extraFilters.category then
					matches = (categoryID == extraFilters.category)
				end

				-- group
				if matches and extraFilters.group then
					matches = (groupID == extraFilters.group)
				end

				-- activity
				if matches and extraFilters.activity then
					matches = (activityID == extraFilters.activity)
				end

				-- item level
				if matches and extraFilters.ilvl then
					matches = (searchResultInfo.requiredItemLevel >= extraFilters.ilvl)
				end

				-- Play style
				if matches and extraFilters.pstyle then
					matches = (searchResultInfo.playstyle == extraFilters.pstyle)
				end

				-- Mythic+ rating
				if matches and extraFilters.mpr then
					matches = (searchResultInfo.requiredDungeonScore >= extraFilters.mpr)
				end

				-- PvP rating
				if matches and extraFilters.pvpr then
					matches = (searchResultInfo.requiredPvpRating >= extraFilters.pvpr)
				end

				-- voice chat
				if matches and extraFilters.vc then
					if extraFilters.vc.Checked and not extraFilters.vc.none then
						matches = (voiceChat ~= "")
					elseif extraFilters.vc.none then
						matches = (voiceChat == "")
					end
				end

				-- realm
				if matches and leaderName and extraFilters.realms then
					local leaderRealm = leaderName:gmatch("-.+$")()
					if not leaderRealm then
						leaderRealm = "-" .. PremadeFilter_Frame.realmName:gsub("[%s%']+", "")
					end
					matches = extraFilters.realms:find(leaderRealm:lower(), 1, true) and true or false
				end

				-- members
				if matches and extraFilters.minTanks then
					matches = (memberCounts.TANK >= extraFilters.minTanks)
				end
				if matches and extraFilters.maxTanks then
					matches = (memberCounts.TANK <= extraFilters.maxTanks)
				end

				if matches and extraFilters.minHealers then
					matches = (memberCounts.HEALER >= extraFilters.minHealers)
				end
				if matches and extraFilters.maxHealers then
					matches = (memberCounts.HEALER <= extraFilters.maxHealers)
				end

				if matches and extraFilters.minDamagers then
					matches = (memberCounts.DAMAGER >= extraFilters.minDamagers)
				end
				if matches and extraFilters.maxDamagers then
					matches = (memberCounts.DAMAGER <= extraFilters.maxDamagers)
				end

				-- bosses
				if matches and extraFilters.bosses then
					local completedEncounters = C_LFGList.GetSearchResultEncounterInfo(resultID)
					local bossesDefeated = {}

					if type(completedEncounters) == "table" then
						for i = 1, #completedEncounters do
							local boss = completedEncounters[i]
							local shortName = boss:match("^([^%,%-%s]+)")
							bossesDefeated[shortName] = true
						end
					end

					for boss, filterStatus in pairs(extraFilters.bosses) do
						local shortName = boss:match("^([^%,%-%s]+)")
						local bossStatus = (type(bossesDefeated[shortName]) == "nil")
						if bossStatus ~= filterStatus then
							matches = false
							break
						end
					end
				end
			end

			-- RESULT
			if matches then
				numResults = numResults + 1
				newResults[numResults] = resultID

				if
					PremadeFilter_Frame.SearchTime[PremadeFilter_Frame.selectedCategory] - age
					> PremadeFilter_Frame.updated[PremadeFilter_Frame.selectedCategory]
				then
					PremadeFilter_Frame.freshResults[resultID] = true

					if PremadeFilter_MinimapButton:IsVisible() then
						PremadeFilter_StartNotification()

						if
							PremadeFilter_GetSettings("NewGroupChatNotifications")
							and not PremadeFilter_Frame.chatNotifications[infoName]
						then
							PremadeFilter_Frame.chatNotifications[infoName] = true
							PremadeFilter_PrintMessage(
								DEFAULT_CHAT_FRAME,
								T("found new group") .. " " .. PremadeFilter_GetHyperlink(name, { infoName = infoName })
							)
						end
					end
				end
			end
		end

		if #self.results > 0 and not PremadeFilter_MinimapButton:IsVisible() then
			PremadeFilter_MinimapButton.LastUpdate = 0
		end

		self.totalResults = numResults
		self.results = newResults
		self.applications = C_LFGList.GetApplications()
		LFGListUtil_SortSearchResults(self.results)
	end
	LFGListSearchPanel_UpdateResults(self)
end

function LFGListSearchEntry_Update(self)
	local resultID = self.resultID
	local _, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(resultID)
	local isApplication = (appStatus ~= "none" or pendingStatus)
	local isAppFinished = LFGListUtil_IsStatusInactive(appStatus) or LFGListUtil_IsStatusInactive(pendingStatus)

	--Update visibility based on whether we're an application or not
	self.isApplication = isApplication
	self.ApplicationBG:SetShown(isApplication and not isAppFinished)
	self.ResultBG:SetShown(not isApplication or isAppFinished)
	self.DataDisplay:SetShown(not isApplication)
	self.CancelButton:SetShown(isApplication and pendingStatus ~= "applied")
	self.CancelButton:SetEnabled(LFGListUtil_IsAppEmpowered())
	self.CancelButton.Icon:SetDesaturated(not LFGListUtil_IsAppEmpowered())
	self.CancelButton.tooltip = (not LFGListUtil_IsAppEmpowered()) and LFG_LIST_APP_UNEMPOWERED
	self.Spinner:SetShown(pendingStatus == "applied")

	if pendingStatus == "applied" and C_LFGList.GetRoleCheckInfo() then
		self.PendingLabel:SetText(LFG_LIST_ROLE_CHECK)
		self.PendingLabel:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		self.PendingLabel:Show()
		self.ExpirationTime:Hide()
		self.CancelButton:Hide()
	elseif pendingStatus == "cancelled" or appStatus == "cancelled" or appStatus == "failed" then
		self.PendingLabel:SetText(LFG_LIST_APP_CANCELLED)
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
		self.PendingLabel:Show()
		self.ExpirationTime:Hide()
		self.CancelButton:Hide()
	elseif appStatus == "declined" or appStatus == "declined_full" or appStatus == "declined_delisted" then
		self.PendingLabel:SetText((appStatus == "declined_full") and LFG_LIST_APP_FULL or LFG_LIST_APP_DECLINED)
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
		self.PendingLabel:Show()
		self.ExpirationTime:Hide()
		self.CancelButton:Hide()
	elseif appStatus == "timedout" then
		self.PendingLabel:SetText(LFG_LIST_APP_TIMED_OUT)
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
		self.PendingLabel:Show()
		self.ExpirationTime:Hide()
		self.CancelButton:Hide()
	elseif appStatus == "invited" then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITED)
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		self.PendingLabel:Show()
		self.ExpirationTime:Hide()
		self.CancelButton:Hide()
	elseif appStatus == "inviteaccepted" then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITE_ACCEPTED)
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		self.PendingLabel:Show()
		self.ExpirationTime:Hide()
		self.CancelButton:Hide()
	elseif appStatus == "invitedeclined" then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITE_DECLINED)
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
		self.PendingLabel:Show()
		self.ExpirationTime:Hide()
		self.CancelButton:Hide()
	elseif isApplication and pendingStatus ~= "applied" then
		self.PendingLabel:SetText(LFG_LIST_PENDING)
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		self.PendingLabel:Show()
		self.ExpirationTime:Show()
		self.CancelButton:Show()
	else
		self.PendingLabel:Hide()
		self.ExpirationTime:Hide()
		self.CancelButton:Hide()
	end

	--Center justify if we're on more than one line
	if self.PendingLabel:GetHeight() > 15 then
		self.PendingLabel:SetJustifyH("CENTER")
	else
		self.PendingLabel:SetJustifyH("RIGHT")
	end

	--Change the anchor of the label depending on whether we have the expiration time
	if self.ExpirationTime:IsShown() then
		self.PendingLabel:SetPoint("RIGHT", self.ExpirationTime, "LEFT", -3, 0)
	else
		self.PendingLabel:SetPoint("RIGHT", self.ExpirationTime, "RIGHT", -3, 0)
	end

	self.expiration = GetTime() + appDuration
	local panel = self:GetParent():GetParent():GetParent()
	local searchResultInfo = C_LFGList.GetSearchResultInfo(resultID)
	local activityID = searchResultInfo.activityID
	local name = searchResultInfo.name
	local voiceChat = searchResultInfo.voiceChat
	local isDelisted = searchResultInfo.isDelisted
	local activityName = C_LFGList.GetActivityFullName(activityID, nil, searchResultInfo.isWarMode)
	self.infoName = PremadeFilter_GetInfoName(activityID, name)
	self.resultID = resultID
	self.Selected:SetShown(panel.selectedResult == resultID and not isApplication and not isDelisted)
	self.Highlight:SetShown(panel.selectedResult ~= resultID and not isApplication and not isDelisted)
	local nameColor = NORMAL_FONT_COLOR
	local activityColor = GRAY_FONT_COLOR

	if isDelisted or isAppFinished then
		nameColor = LFG_LIST_DELISTED_FONT_COLOR
		activityColor = LFG_LIST_DELISTED_FONT_COLOR
	elseif
		searchResultInfo.numBNetFriends > 0
		or searchResultInfo.numCharFriends > 0
		or searchResultInfo.numGuildMates > 0
	then
		nameColor = BATTLENET_FONT_COLOR
	elseif self.fresh then
		nameColor = LFG_LIST_FRESH_FONT_COLOR
	end

	self.Name:SetWidth(0)
	self.Name:SetText(name)
	self.Name:SetTextColor(nameColor.r, nameColor.g, nameColor.b)
	self.ActivityName:SetText(activityName)
	self.ActivityName:SetTextColor(activityColor.r, activityColor.g, activityColor.b)
	self.VoiceChat:SetShown(voiceChat ~= "")
	self.VoiceChat.tooltip = voiceChat
	local displayData = C_LFGList.GetSearchResultMemberCounts(resultID)

	LFGListGroupDataDisplay_Update(self.DataDisplay, activityID, displayData, isDelisted)

	local nameWidth = isApplication and 165 or 176

	if voiceChat ~= "" then
		nameWidth = nameWidth - 22
	end
	if self.Name:GetWidth() > nameWidth then
		self.Name:SetWidth(nameWidth)
	end

	self.ActivityName:SetWidth(nameWidth)
	local mouseFocus = GetMouseFocus()

	if mouseFocus == self then
		LFGListSearchEntry_OnEnter(self)
	end
	if mouseFocus == self.VoiceChat then
		mouseFocus:GetScript("OnEnter")(mouseFocus)
	end

	if isApplication then
		self:SetScript("OnUpdate", LFGListSearchEntry_UpdateExpiration)
		LFGListSearchEntry_UpdateExpiration(self)
	else
		self:SetScript("OnUpdate", nil)
	end
end

function LFGListSearchPanel_InitButton(button, elementData)
	button.resultID = elementData.resultID
	button.infoName = elementData.infoName
	button.fresh = PremadeFilter_Frame.freshResults[elementData.resultID]
	LFGListSearchEntry_Update(button)
	button:SetScript("OnEnter", PremadeFilter_SearchEntry_OnEnter)
end

function LFGListSearchPanel_UpdateResults(self)
	--If we have an application selected, deselect it.
	LFGListSearchPanel_ValidateSelected(self)

	if self.searching then
		self.SearchingSpinner:Show()
		self.ScrollBox.NoResultsFound:Hide()
		self.ScrollBox.StartGroupButton:Hide()
		self.ScrollBox:ClearDataProvider()
	else
		self.SearchingSpinner:Hide()

		local dataProvider = CreateDataProvider()
		local results = self.results
		for index = 1, #results do
			local searchResultInfo = C_LFGList.GetSearchResultInfo(results[index])
			dataProvider:Insert({
				resultID = results[index],
				infoName = PremadeFilter_GetInfoName(searchResultInfo.activityID, searchResultInfo.name),
			})
		end

		local apps = self.applications
		local resultSet = tInvert(self.results)
		for i, app in ipairs(apps) do
			if not resultSet[app] then
				local searchResultInfo = C_LFGList.GetSearchResultInfo(app)
				dataProvider:Insert({
					resultID = app,
					infoName = PremadeFilter_GetInfoName(searchResultInfo.activityID, searchResultInfo.name),
				})
			end
		end

		if self.totalResults == 0 then
			self.ScrollBox.NoResultsFound:Show()
			self.ScrollBox.StartGroupButton:SetShown(not self.searchFailed)
			self.ScrollBox.StartGroupButton:ClearAllPoints()
			self.ScrollBox.StartGroupButton:SetPoint("BOTTOM", self.ScrollBox.NoResultsFound, "BOTTOM", 0, -27)
			self.ScrollBox.NoResultsFound:SetText(
				self.searchFailed and LFG_LIST_SEARCH_FAILED or LFG_LIST_NO_RESULTS_FOUND
			)
		elseif self.shouldAlwaysShowCreateGroupButton then
			self.ScrollBox.NoResultsFound:Hide()
			self.ScrollBox.StartGroupButton:SetShown(false)

			dataProvider:Insert({ startGroup = true })
		else
			self.ScrollBox.NoResultsFound:Hide()
			self.ScrollBox.StartGroupButton:SetShown(false)
		end

		self.ScrollBox:SetDataProvider(dataProvider, ScrollBoxConstants.RetainScrollPosition)

		--Reanchor the errors to not overlap applications
		if not self.ScrollBox:HasScrollableExtent() then
			local extent = self.ScrollBox:GetExtent()
			self.ScrollBox.NoResultsFound:SetPoint("TOP", self.ScrollBox, "TOP", 0, -extent - 27)
		end
	end
	LFGListSearchPanel_UpdateButtonStatus(self)
end

function LFGListSearchEntry_OnEnter(self)
	PremadeFilter_SearchEntry_OnEnter(self)
end

do
	function PremadeFilter_GetTooltipInfo(resultID)
		local searchResultInfo = C_LFGList.GetSearchResultInfo(resultID)
		local activityID = searchResultInfo.activityID
		if not activityID then
			return nil
		end
		local numMembers = searchResultInfo.numMembers
		local playStyle = searchResultInfo.playstyle
		local numBNetFriends = searchResultInfo.numBNetFriends
		local numCharFriends = searchResultInfo.numCharFriends
		local numGuildMates = searchResultInfo.numGuildMates
		local questID = searchResultInfo.questID
		local activityInfo = C_LFGList.GetActivityInfoTable(activityID, questID, searchResultInfo.isWarMode)

		local classCounts = {}
		local memberList = {}

		for i = 1, numMembers do
			local role, class, classLocalized, specLocalized = C_LFGList.GetSearchResultMemberInfo(resultID, i)
			local roleImg
			if role == "DAMAGER" then
				roleImg = "|A:8040:16:16|a"
			elseif role == "HEALER" then
				roleImg = "|A:8041:16:16|a"
			elseif role == "TANK" then
				roleImg = "|A:8042:16:16|a"
			else
				roleImg = ""
			end
			local info = {
				role = roleImg .. specLocalized,
				title = classLocalized,
				color = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR,
			}

			table.insert(memberList, info)

			if not classCounts[class] then
				classCounts[class] = {
					title = info.title,
					color = info.color,
					counts = {},
				}
			end

			if not classCounts[class].counts[info.role] then
				classCounts[class].counts[info.role] = 0
			end

			classCounts[class].counts[info.role] = classCounts[class].counts[info.role] + 1
		end

		local friendList = {}
		if numBNetFriends + numCharFriends + numGuildMates > 0 then
			friendList = LFGListSearchEntryUtil_GetFriendList(resultID)
		end

		return {
			memberCounts = C_LFGList.GetSearchResultMemberCounts(resultID),
			completedEncounters = C_LFGList.GetSearchResultEncounterInfo(resultID),
			autoAccept = searchResultInfo.autoAccept,
			isDelisted = searchResultInfo.isDelisted,
			name = searchResultInfo.name,
			comment = searchResultInfo.comment,
			iLvl = searchResultInfo.requiredItemLevel,
			HonorLevel = searchResultInfo.requiredHonorLevel,
			DungeonScore = searchResultInfo.requiredDungeonScore,
			PvpRating = searchResultInfo.requiredPvpRating,
			voiceChat = searchResultInfo.voiceChat,
			leaderName = searchResultInfo.leaderName,
			age = searchResultInfo.age,
			leaderOverallDungeonScore = searchResultInfo.leaderOverallDungeonScore,
			leaderDungeonScoreInfo = searchResultInfo.leaderDungeonScoreInfo,
			leaderPvpRatingInfo = searchResultInfo.leaderPvpRatingInfo,
			playStyle = playStyle,
			questID = questID,
			activityID = activityID,
			numMembers = numMembers,
			classCounts = classCounts,
			friendList = friendList,
			activityName = activityInfo.fullName,
			useHonorLevel = activityInfo.useHonorLevel,
			displayType = activityInfo.displayType,
			isMythicPlusActivity = activityInfo.isMythicPlusActivity,
			isRatedPvpActivity = activityInfo.isRatedPvpActivity,
			playstyleString = PremadeFilter_GetPlaystyleString(playStyle, activityInfo),
			memberList = memberList,
		}
	end
end
function PremadeFilter_SearchEntry_OnEnter(self)
	local info = PremadeFilter_GetTooltipInfo(self.resultID)

	-- setup tooltip
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 25, 0)
	GameTooltip:SetText(info.name, 1, 1, 1, true)
	GameTooltip:AddLine(info.activityName)

	if info.playStyle > 0 and info.playstyleString then
		GameTooltip_AddColoredLine(GameTooltip, info.playstyleString, GREEN_FONT_COLOR)
	end

	if info.comment and info.comment == "" and info.questID then
		info.comment = LFGListUtil_GetQuestDescription(info.questID)
	end
	if info.comment ~= "" then
		GameTooltip:AddLine(
			string.format(LFG_LIST_COMMENT_FORMAT, info.comment),
			GRAY_FONT_COLOR.r,
			GRAY_FONT_COLOR.g,
			GRAY_FONT_COLOR.b,
			true
		)
	end
	GameTooltip:AddLine(" ")
	if info.DungeonScore > 0 then
		GameTooltip:AddLine(GROUP_FINDER_MYTHIC_RATING_REQ_TOOLTIP:format(info.DungeonScore))
	end
	if info.PvpRating > 0 then
		GameTooltip:AddLine(GROUP_FINDER_PVP_RATING_REQ_TOOLTIP:format(info.PvpRating))
	end
	if info.iLvl > 0 then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_ILVL, info.iLvl))
	end
	if info.useHonorLevel and info.HonorLevel > 0 then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_HONOR_LEVEL, info.HonorLevel))
	end
	if info.voiceChat ~= "" then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_VOICE_CHAT, info.voiceChat), nil, nil, nil, true)
	end
	if
		info.iLvl > 0
		or (info.useHonorLevel and info.HonorLevel > 0)
		or info.voiceChat ~= ""
		or info.DungeonScore > 0
		or info.PvpRating > 0
	then
		GameTooltip:AddLine(" ")
	end

	if info.leaderName then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_LEADER, info.leaderName))
	end
	if info.isRatedPvpActivity and info.leaderPvpRatingInfo then
		GameTooltip_AddNormalLine(
			GameTooltip,
			PVP_RATING_GROUP_FINDER:format(
				info.leaderPvpRatingInfo.activityName,
				info.leaderPvpRatingInfo.rating,
				PVPUtil.GetTierName(info.leaderPvpRatingInfo.tier)
			)
		)
	elseif info.isMythicPlusActivity and info.leaderOverallDungeonScore then
		local color = C_ChallengeMode.GetDungeonScoreRarityColor(info.leaderOverallDungeonScore)
		if not color then
			color = HIGHLIGHT_FONT_COLOR
		end
		GameTooltip:AddLine(
			DUNGEON_SCORE_LEADER:format(color:WrapTextInColorCode(tostring(info.leaderOverallDungeonScore)))
		)
	end
	if info.isMythicPlusActivity and info.leaderDungeonScoreInfo then
		local leaderDungeonScoreInfo = info.leaderDungeonScoreInfo
		local color = C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor(leaderDungeonScoreInfo.mapScore)
		if not color then
			color = HIGHLIGHT_FONT_COLOR
		end
		if leaderDungeonScoreInfo.mapScore == 0 then
			GameTooltip_AddNormalLine(
				GameTooltip,
				DUNGEON_SCORE_PER_DUNGEON_NO_RATING:format(
					leaderDungeonScoreInfo.mapName,
					leaderDungeonScoreInfo.mapScore
				)
			)
		elseif leaderDungeonScoreInfo.finishedSuccess then
			GameTooltip_AddNormalLine(
				GameTooltip,
				DUNGEON_SCORE_DUNGEON_RATING:format(
					leaderDungeonScoreInfo.mapName,
					color:WrapTextInColorCode(tostring(leaderDungeonScoreInfo.mapScore)),
					leaderDungeonScoreInfo.bestRunLevel
				)
			)
		else
			GameTooltip_AddNormalLine(
				GameTooltip,
				DUNGEON_SCORE_DUNGEON_RATING_OVERTIME:format(
					leaderDungeonScoreInfo.mapName,
					color:WrapTextInColorCode(tostring(leaderDungeonScoreInfo.mapScore)),
					leaderDungeonScoreInfo.bestRunLevel
				)
			)
		end
	end
	if info.age > 0 then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_AGE, SecondsToTime(info.age, false, false, 1, false)))
	end

	if info.leaderName or info.age > 0 then
		GameTooltip:AddLine(" ")
	end

	if info.displayType == Enum.LFGListDisplayType.ClassEnumerate then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_MEMBERS_SIMPLE, info.numMembers))

		if info.memberList then
			for _, memberInfo in pairs(info.memberList) do
				GameTooltip:AddLine(
					string.format(LFG_LIST_TOOLTIP_CLASS_ROLE, memberInfo.title, memberInfo.role),
					memberInfo.color.r,
					memberInfo.color.g,
					memberInfo.color.b
				)
			end
		end
	else
		GameTooltip:AddLine(
			string.format(
				LFG_LIST_TOOLTIP_MEMBERS,
				info.numMembers,
				info.memberCounts.TANK,
				info.memberCounts.HEALER,
				info.memberCounts.DAMAGER
			)
		)

		for _, classInfo in pairs(info.classCounts) do
			local counts = {}
			for role, count in pairs(classInfo.counts) do
				table.insert(counts, role .. ": " .. COLOR_ORANGE .. count .. COLOR_GRAY)
			end
			GameTooltip:AddLine(
				string.format("%s " .. COLOR_GRAY .. "(%s)" .. COLOR_RESET, classInfo.title, table.concat(counts, ", ")),
				classInfo.color.r,
				classInfo.color.g,
				classInfo.color.b
			)
		end
	end

	if #info.friendList > 0 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(LFG_LIST_TOOLTIP_FRIENDS_IN_GROUP)
		GameTooltip:AddLine(info.friendList, 1, 1, 1, true)
	end

	if info.completedEncounters and #info.completedEncounters > 0 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(LFG_LIST_BOSSES_DEFEATED)
		for i = 1, #info.completedEncounters do
			GameTooltip:AddLine(info.completedEncounters[i], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
		end
	end

	local autoAcceptOption = nil or LFG_LIST_UTIL_ALLOW_AUTO_ACCEPT_LINE
	if autoAcceptOption == LFG_LIST_UTIL_ALLOW_AUTO_ACCEPT_LINE and info.autoAccept then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(LFG_LIST_TOOLTIP_AUTO_ACCEPT, LIGHTBLUE_FONT_COLOR:GetRGB())
	end

	if info.isDelisted then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(LFG_LIST_ENTRY_DELISTED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true)
	end

	GameTooltip:Show()
end

function LFGListUtil_SortSearchResultsCB(id1, id2)
	if not id1 or not id2 then
		return false
	end
	local searchResultInfo1 = C_LFGList.GetSearchResultInfo(id1)
	local searchResultInfo2 = C_LFGList.GetSearchResultInfo(id2)

	--If one has more friends, do that one first
	local numBNetFriends1 = searchResultInfo1.numBNetFriends
	local numBNetFriends2 = searchResultInfo2.numBNetFriends
	if numBNetFriends1 ~= numBNetFriends2 then
		return numBNetFriends1 > numBNetFriends2
	end
	local numCharFriends1 = searchResultInfo1.numCharFriends
	local numCharFriends2 = searchResultInfo2.numCharFriends
	if numCharFriends1 ~= numCharFriends2 then
		return numCharFriends1 > numCharFriends2
	end
	local numGuildMates1 = searchResultInfo1.numGuildMates
	local numGuildMates2 = searchResultInfo2.numGuildMates
	if numGuildMates1 ~= numGuildMates2 then
		return numGuildMates1 > numGuildMates2
	end

	local age1 = searchResultInfo1.age
	local age2 = searchResultInfo2.age
	if age1 ~= age2 then
		return age1 < age2
	end

	if searchResultInfo1.isWarMode ~= searchResultInfo2.isWarMode then
		return searchResultInfo1.isWarMode == C_PvP.IsWarModeDesired()
	end

	--If we aren't sorting by anything else, just go by ID
	return id1 < id2
end

function PremadeFilter_CheckButtonSound(self)
	if self:GetChecked() then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
	end
end

function PremadeFilter_CheckButton_OnClick(self)
	if self:GetChecked() then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self:GetParent().EditBox:Show()
		self:GetParent().EditBox:SetFocus()
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
		self:GetParent().EditBox:Hide()
		self:GetParent().EditBox:ClearFocus()
		self:GetParent().EditBox:SetText("")
	end
end

function PremadeFilter_PlayStyleCheckButton_OnClick(self)
	if self:GetChecked() then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
	end
	self:GetParent().PlayStyleDropdown:SetShown(self:GetChecked())
end

function PremadeFilter_CheckButton_EntryCreation_VoiceChat_OnClick(self)
	if self:GetChecked() then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self:GetParent().EditBox:Show()
		self:GetParent().EditBox:SetFocus()
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
		self:GetParent().EditBox:Hide()
		self:GetParent().EditBox:ClearFocus()
	end
end

function PremadeFilter_CheckButton_Boss_OnClick(self)
	local bossIndex = self:GetParent().bossIndex
	if not self:GetChecked() then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)

		if not self.CheckedNone then
			self.CheckedNone = true
			self:SetChecked(false)
			self:SetCheckedTexture("Interface\\Buttons\\UI-MultiCheck-Up")
			self:SetChecked(true)

			PremadeFilter_Frame.availableBosses[bossIndex].isChecked = false

			self:GetParent().bossName:SetTextColor(1, 0, 0)
		else
			self.CheckedNone = false

			PremadeFilter_Frame.availableBosses[bossIndex].isChecked = nil

			self:GetParent().bossName:SetTextColor(0.7, 0.7, 0.7)
		end
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self.CheckedNone = false
		self:SetChecked(false)
		self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		self:SetChecked(true)
		
		
		PremadeFilter_Frame.availableBosses[bossIndex].isChecked = true

		self:GetParent().bossName:SetTextColor(0, 1, 0)
	end
end

function PremadeFilter_CheckButton_VoiceChat_OnClick(self)
	if not self:GetChecked() then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)

		if not self.CheckedNone then
			self.CheckedNone = true
			self:SetChecked(false)
			self:SetCheckedTexture("Interface\\Buttons\\UI-MultiCheck-Up")
			self:SetChecked(true)
		else
			self.CheckedNone = false
		end
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self.CheckedNone = false
		self:SetChecked(false)
		self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		self:SetChecked(true)
		
	end
end

function PremadeFilter_StartMonitoring()
	PremadeFilter_Frame.chatNotifications = {}
end

function PremadeFilter_StopMonitoring()
	PremadeFilter_Frame.chatNotifications = {}
end

function PremadeFilter_MinimapButton_OnLoad(self)
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	self:SetFrameLevel(self:GetFrameLevel() + 1)
	self.glowLocks = {}
	self.angerVal = 0
	self.LastUpdate = 0
end

function PremadeFilter_MinimapButton_OnShow(self)
	self.Eye:SetFrameLevel(self:GetFrameLevel() - 1)
	self.Eye:StartInitialAnimation()

	-- local point, anchor, relativePoint, x, y = QueueStatusButton:GetPoint()
	-- self:ClearAllPoints()
	-- self:SetParent(QueueStatusButton:GetParent())
	-- self:SetPoint(point, anchor, relativePoint, x, y)
end

function PremadeFilter_MinimapButton_OnClick()
	PVEFrame_ShowFrame("GroupFinderFrame")
	PremadeFilter_MinimapButton:Hide()
	PremadeFilter_MinimapButton.Eye:StopAnimating()
	PremadeFilter_StopMonitoring()
end

function PremadeFilter_OnUpdate(self, elapsed)
	PremadeFilter_MinimapButton_OnUpdate(PremadeFilter_MinimapButton, elapsed)
end

function PremadeFilter_MinimapButton_OnUpdate(self, elapsed)
	self.LastUpdate = self.LastUpdate + elapsed
	if self.LastUpdate > PremadeFilter_GetSettings("UpdateInterval") then
		self.LastUpdate = 0
	end

	self.Eye.texture:Hide()
	if self:IsInitialEyeAnimFinished() or self:IsPokeEndAnimFinished() then
		self.Eye:StartSearchingAnimation()
	elseif self:IsFoundInitialAnimFinished() then
		self.Eye:StartFoundAnimationLoop()
	elseif self:ShouldStartPokeInitAnim() then
		self.Eye:StartPokeAnimationInitial()
	elseif self:IsPokeInitAnimFinished() then
		self.Eye:StartPokeAnimationLoop()
	elseif self:ShouldStartPokeEndAnim() then
		self.Eye:StartPokeAnimationEnd()
	elseif self:ShouldStartHoverAnim() then
		self.Eye:StartHoverAnimation()
	end
	self.angerVal = self.angerVal - 1
	self.angerVal = Clamp(self.angerVal, 0, 90)
end

function PremadeFilter_QueueStatusButton_SetGlowLock(self, lock, enabled, numPingSounds)
	self.glowLocks[lock] = enabled and (numPingSounds or -1)
	PremadeFilter_QueueStatusButton_UpdateGlow(self)
end

function PremadeFilter_QueueStatusButton_UpdateGlow(self)
	local enabled = false
	for k, v in pairs(self.glowLocks) do
		if v then
			enabled = true
			break
		end
	end

	self.Highlight:SetShown(enabled)
	if enabled then
		self.EyeHighlightAnim:Play()
	else
		self.EyeHighlightAnim:Stop()
	end
end

function PremadeFilter_StartNotification()
	PremadeFilter_QueueStatusButton_SetGlowLock(PremadeFilter_MinimapButton, "lfglist-applicant", true)
end

function PremadeFilter_StopNotification()
	PremadeFilter_QueueStatusButton_SetGlowLock(PremadeFilter_MinimapButton, "lfglist-applicant", false)
end

function PremadeFilter_PrintMessage(frame, str)
	frame:AddMessage(COLOR_GREEN .. "PremadeFilter " .. COLOR_RESET .. str .. COLOR_RESET)
end

function PremadeFilter_GetHyperlink(str, data)
	local linkType = "premade"
	local linkData = {}
	local linkDataStr = ""

	for k, v in pairs(data) do
		table.insert(linkData, k .. ":" .. v)
	end
	linkDataStr = table.concat(linkData, ":")

	if linkDataStr ~= "" then
		linkDataStr = ":" .. linkData
	end

	return COLOR_BLUE .. "|H" .. linkType .. linkDataStr .. "|h[" .. str .. "]|h|r"
end

function PremadeFilter_Hyperlink_OnLeave(self, ...)
	if PremadeFilter_Frame.oldHyperlinkLeave then
		PremadeFilter_Frame.oldHyperlinkLeave(self, ...)
	end
end

function PremadeFilter_Hyperlink_OnEnter(self, link, text, ...)
	local prefix = link:sub(1, 7)

	if prefix == "premade" then
		local data = {}
		local dataStr = link:sub(8)

		local i = 1
		local k, v
		for v in dataStr:gmatch("([^:]+)") do
			if i % 2 == 0 then
				data[k] = v
			else
				k = v
			end
			i = i + 1
		end

		self.infoName = data.infoName

		PremadeFilter_SearchEntry_OnEnter(self)
	elseif PremadeFilter_Frame.oldHyperlinkEnter then
		PremadeFilter_Frame.oldHyperlinkEnter(self, link, text, ...)
	end
end

function PremadeFilter_Hyperlink_OnClick(self, link, text, button)
	local prefix = link:sub(1, 7)
	if prefix == "premade" then
		local name = text:match("%[([^%]]+)%]")
		if name and PremadeFilter_MinimapButton:IsVisible() then
			if button == "LeftButton" then
				PremadeFilter_MinimapButton_OnClick()
			else
				PremadeFilter_StopNotification()
			end
		end
	elseif PremadeFilter_Frame.oldHyperlinkClick then
		PremadeFilter_Frame.oldHyperlinkClick(self, link, text, button)
	end
end

function PremadeFilter_OnApplicantListUpdated(_, _, ...)
	local hasNewPending, hasNewPendingWithData = ...

	if hasNewPending and hasNewPendingWithData then
		local applicants = C_LFGList.GetApplicants()

		for i = 1, #applicants do
			local ApplicantInfo = C_LFGList.GetApplicantInfo(applicants[i])
			local status = ApplicantInfo.applicationStatus
			local grayedOut = not ApplicantInfo.pendingApplicationStatus
				and (
					status == "failed"
					or status == "cancelled"
					or status == "declined"
					or status == "declined_full"
					or status == "declined_delisted"
					or status == "invitedeclined"
					or status == "timedout"
				)
			local noTouchy = (status == "invited" or status == "inviteaccepted" or status == "invitedeclined")

			if ApplicantInfo.isNew and not grayedOut and not noTouchy then
				for i = 1, ApplicantInfo.numMembers do
					local name, class, _, _, itemLevel, tank, healer, damage, _, _ =
						C_LFGList.GetApplicantMemberInfo(ApplicantInfo.applicantID, i)
					local classColor = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR
					local hexColor =
						string.format("|cff%02x%02x%02x", classColor.r * 255, classColor.g * 255, classColor.b * 255)
					local displayName = Ambiguate(name, "short")

					local role1 = tank and "TANK" or (healer and "HEALER" or (damage and "DAMAGER"))
					local role2 = (tank and healer and "HEALER") or ((tank or healer) and damage and "DAMAGER")
					local roles = _G[role1]
					if role2 then
						roles = roles .. ", " .. _G[role2]
					end

					if
						PremadeFilter_GetSettings("NewPlayerChatNotifications")
						and not PremadeFilter_Frame.chatNotifications[name]
					then
						PremadeFilter_Frame.chatNotifications[name] = true
						PremadeFilter_PrintMessage(
							DEFAULT_CHAT_FRAME,
							T("found new player")
								.. " "
								.. hexColor
								.. displayName
								.. COLOR_RESET
								.. " ("
								.. roles
								.. " - "
								.. math.floor(itemLevel)
								.. ")"
						)
					end
				end
			end
		end
	end
end

function PremadeFilter_Options_OnLoad(self)
	self.name = "Premade Filter "

	-- setup localization
	self.NotificationsHeader:SetText(T(self.NotificationsHeader:GetText()))
	self.NewGroupChatNotificationsHeader:SetText(T(self.NewGroupChatNotificationsHeader:GetText()))
	self.NewPlayerChatNotificationsHeader:SetText(T(self.NewPlayerChatNotificationsHeader:GetText()))
	self.MonitoringHeader:SetText(T(self.MonitoringHeader:GetText()))
	self.UpdateIntervalHeader:SetText(T(self.UpdateIntervalHeader:GetText()))

	-- save options
	self.OnCommit = function(self)
		PremadeFilter_SetSettings("NewGroupChatNotifications", self.NewGroupChatNotifications:GetChecked())
		PremadeFilter_SetSettings("NewPlayerChatNotifications", self.NewPlayerChatNotifications:GetChecked())
		PremadeFilter_SetSettings("UpdateInterval", self.UpdateInterval:GetValue())
	end

	-- add panel
	local category = Settings.RegisterCanvasLayoutCategory(self, self.name)
	category.ID = "PremadeFilter"
	Settings.RegisterAddOnCategory(category)
end

function PremadeFilter_MenuTitleItem(text)
	return {
		isTitle = true,
		notCheckable = true,
		text = T(text),
	}
end

function PremadeFilter_MenuSpacerItem()
	return {
		isTitle = true,
		notCheckable = true,
		text = "",
	}
end

function PremadeFilter_MenuActionItem(text, func, disabled)
	return {
		notCheckable = true,
		disabled = disabled,
		text = T(text),
		func = func,
	}
end

function PremadeFilter_MenuRadioItem(text, checked, func, disabled)
	return {
		checked = checked,
		disabled = disabled,
		text = T(text),
		func = func,
	}
end

function PremadeFilter_MenuCheckboxItem(text, checked, func, disabled)
	return {
		isNotRadio = true,
		checked = checked,
		disabled = disabled,
		text = T(text),
		func = func,
	}
end

function PremadeFilter_SubMenuItem(text, menuList)
	return {
		notCheckable = true,
		hasArrow = true,
		text = T(text),
		menuList = menuList,
	}
end

function PremadeFilter_OptionsMenu(self)
	local dropDownList = _G["DropDownList" .. UIDROPDOWNMENU_MENU_LEVEL]
	if dropDownList:IsShown() then
		CloseDropDownMenus()
		return
	end

	local saveDialog = StaticPopup_FindVisible("PREMADEFILTER_SAVE_FILTERSET")
	if saveDialog then
		return
	end

	local menuList = {
		PremadeFilter_MenuTitleItem("Filter set"),
		PremadeFilter_MenuSpacerItem(),
		PremadeFilter_MenuTitleItem("Actions"),
		PremadeFilter_MenuActionItem(SAVE, PremadeFilter_SaveFilterSet),
		PremadeFilter_MenuActionItem(DELETE, PremadeFilter_DeleteFilterSet),
		PremadeFilter_MenuSpacerItem(),
		PremadeFilter_MenuTitleItem(SETTINGS),
		PremadeFilter_MenuCheckboxItem(
			"Notify in chat on new group",
			PremadeFilter_GetSettings("NewGroupChatNotifications"),
			function(self, _, _, checked)
				self.checked = not checked
				PremadeFilter_SetSettings("NewGroupChatNotifications", self.checked)
			end
		),
		PremadeFilter_MenuCheckboxItem(
			"Notify in chat on new player",
			PremadeFilter_GetSettings("NewPlayerChatNotifications"),
			function(self, _, _, checked)
				self.checked = not checked
				PremadeFilter_SetSettings("NewPlayerChatNotifications", self.checked)
			end
		),
		PremadeFilter_MenuActionItem(ADVANCED_OPTIONS, function()
			Settings.OpenToCategory("PremadeFilter")
		end),
		PremadeFilter_MenuActionItem(CANCEL, function()
			CloseDropDownMenus()
		end),
	}

	local recentSets = PremadeFilter_GetRecentFilterSets()
	for index, text in pairs(recentSets) do
		local selectedIndex = #PremadeFilter_Data.FilterSetsOrder - PremadeFilter_Frame.selectedFilterSet + 2
		local checked = (index == selectedIndex)
		table.insert(menuList, index + 1, PremadeFilter_MenuRadioItem(text, checked, PremadeFilter_OnFilterSetSelected))
	end

	local restSets = PremadeFilter_GetRestFilterSets()
	if #restSets > 0 then
		local moreItems = {}
		for _, text in pairs(restSets) do
			table.insert(moreItems, PremadeFilter_MenuRadioItem(text, false, PremadeFilter_OnFilterSetSelected))
		end
		table.insert(menuList, #recentSets + 2, PremadeFilter_SubMenuItem("More", moreItems))
	end

	EasyMenu(menuList, self.Menu, self, 117, 0, "MENU")
end

function PremadeFilter_FixFilterSets()
	if type(PremadeFilter_Data.FilterSets) ~= "table" then
		PremadeFilter_Data.FilterSets = {}
	end

	if type(PremadeFilter_Data.FilterSetsOrder) ~= "table" then
		PremadeFilter_Data.FilterSetsOrder = {}
		for k, v in pairs(PremadeFilter_Data.FilterSets) do
			table.insert(PremadeFilter_Data.FilterSetsOrder, k)
		end
	end

	while #PremadeFilter_Data.FilterSetsOrder > 30 do
		local word = table.remove(PremadeFilter_Data.FilterSetsOrder, 1)
		PremadeFilter_Data.FilterSets[word] = nil
	end

	if
		type(PremadeFilter_Frame.selectedFilterSet) ~= "number"
		or PremadeFilter_Frame.selectedFilterSet < 1
		or PremadeFilter_Frame.selectedFilterSet > #PremadeFilter_Data.FilterSetsOrder
	then
		PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder + 1
	end
end

function PremadeFilter_GetRecentFilterSets()
	PremadeFilter_FixFilterSets()

	local recentSets = { T("New filter set") }
	local index = #PremadeFilter_Data.FilterSetsOrder

	while index > 0 and index > #PremadeFilter_Data.FilterSetsOrder - 5 do
		table.insert(recentSets, PremadeFilter_Data.FilterSetsOrder[index])
		index = index - 1
	end

	return recentSets
end

function PremadeFilter_GetRestFilterSets()
	PremadeFilter_FixFilterSets()

	local restSets = {}
	local index = #PremadeFilter_Data.FilterSetsOrder - 5

	while index > 0 do
		table.insert(restSets, PremadeFilter_Data.FilterSetsOrder[index])
		index = index - 1
	end

	return restSets
end

function PremadeFilter_SaveFilterSet()
	StaticPopup_Show("PREMADEFILTER_SAVE_FILTERSET")
end

function PremadeFilter_DeleteFilterSet()
	local index = PremadeFilter_Frame.selectedFilterSet

	if index <= #PremadeFilter_Data.FilterSetsOrder then
		StaticPopup_Show("PREMADEFILTER_CONFIRM_DELETE")
	end
end

function PremadeFilter_OnFilterSetSelected(self)
	local index = self:GetID()

	if UIDROPDOWNMENU_MENU_LEVEL == 1 then
		PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder - index + 3
	elseif UIDROPDOWNMENU_MENU_LEVEL == 2 then
		local order = #PremadeFilter_Data.FilterSetsOrder - 5 + index - 1
		local text = table.remove(PremadeFilter_Data.FilterSetsOrder, order)
		table.insert(PremadeFilter_Data.FilterSetsOrder, text)
		PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder
	end

	CloseDropDownMenus()

	local setIndex = PremadeFilter_Frame.selectedFilterSet
	local filters

	if setIndex <= #PremadeFilter_Data.FilterSetsOrder then
		local setName = PremadeFilter_Data.FilterSetsOrder[setIndex]
		filters = PremadeFilter_Data.FilterSets[setName]
	else
		filters = {
			category = PremadeFilter_Frame.selectedCategory,
			group = PremadeFilter_Frame.selectedGroup,
			activity = PremadeFilter_Frame.selectedActivity,
		}
	end

	PremadeFilter_SetFilters(filters)
end

function PremadeFilter_UpdateIntervalShortAlert_UpdateVisibility(self)
	if PremadeFilter_UpdateIntervalSlider:GetValue() < 15 then
		self:Show()
	else
		self:Hide()
	end
end

function PremadeFilter_UpdateIntervalSlider_OnValueChanged(self)
	PremadeFilter_UpdateIntervalEditBox:SetText(self:GetValue())
	PremadeFilter_UpdateIntervalShortAlert_UpdateVisibility(PremadeFilter_UpdateIntervalShortAlert)

	if not self._onsetting then -- is single threaded
		self._onsetting = true
		self:SetValue(self:GetValue())
		self._onsetting = false
	else
		return
	end -- ignore recursion for actual event handler
end

function PremadeFilter_UpdateIntervalEditBox_OnLoad(self)
	PremadeFilter_UpdateIntervalEditBox:SetText(PremadeFilter_UpdateIntervalSlider:GetValue())
end

function PremadeFilter_UpdateIntervalEditBox_OnEnterPressed(self)
	self:ClearFocus()

	local v = tonumber(self:GetText())
	if v == nil then
		return
	end

	PremadeFilter_UpdateIntervalSlider:SetValue(v)
	self:SetText(PremadeFilter_UpdateIntervalSlider:GetValue())
end
