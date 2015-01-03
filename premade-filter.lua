local _, L = ...;

MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES = 1000;
LFG_LIST_FRESH_FONT_COLOR = {r=0.3, g=0.9, b=0.3};


local PremadeFilter_RealmChapters = {
	-- US
	{ "Oceania", "Pacific", "Mountain", "Central", "Eastern", "Latin America", "Brazil" },
	
	-- Korea
	{ "격노의 전장", "징벌의 전장" },
	
	-- EU
	{ "English", "French", "German", "Russian", "Spanish", "Portuguese", "Italian" },
	  
	-- Taiwan
	{ "殺戮", "嗜血", "暴怒" },
	
	-- China
	{ "Battle Group 1",  "Battle Group 2",  "Battle Group 3",  "Battle Group 4",  "Battle Group 5",  "Battle Group 6",  "Battle Group 7",  "Battle Group 8",  "Battle Group 9",  "Battle Group 10",
	  "Battle Group 11", "Battle Group 12", "Battle Group 13", "Battle Group 14", "Battle Group 15", "Battle Group 16", "Battle Group 17", "Battle Group 18", "Battle Group 19", "Battle Group 20",
	  "Battle Group 21" },
};

local PremadeFilter_Relams = {
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
		{ name = "Antonidas", region = 1, chapter = 2 },
		{ name = "Anvilmar", region = 1, chapter = 2 },
		{ name = "Arathor", region = 1, chapter = 2 },
		{ name = "Azuremyst", region = 1, chapter = 2 },
		{ name = "Baelgun", region = 1, chapter = 2 },
		{ name = "Blackrock", region = 1, chapter = 2 },
		{ name = "Blackwing Lair", region = 1, chapter = 2 },
		{ name = "Blade's Edge", region = 1, chapter = 2 },
		{ name = "Bladefist", region = 1, chapter = 2 },
		{ name = "Blackwater Raiders", region = 1, chapter = 2 },
		{ name = "Bonechewer", region = 1, chapter = 2 },
		{ name = "Boulderfist", region = 1, chapter = 2 },
		{ name = "Bronzebeard", region = 1, chapter = 2 },
		{ name = "Cenarius", region = 1, chapter = 2 },
		{ name = "Cenarion Circle", region = 1, chapter = 2 },
		{ name = "Coilfang", region = 1, chapter = 2 },
		{ name = "Crushridge", region = 1, chapter = 2 },
		{ name = "Daggerspine", region = 1, chapter = 2 },
		{ name = "Dark Iron", region = 1, chapter = 2 },
		{ name = "Darrowmere", region = 1, chapter = 2 },
		{ name = "Destromath", region = 1, chapter = 2 },
		{ name = "Dethecus", region = 1, chapter = 2 },
		{ name = "Draenor", region = 1, chapter = 2 },
		{ name = "Dragonblight", region = 1, chapter = 2 },
		{ name = "Dragonmaw", region = 1, chapter = 2 },
		{ name = "Dunemaul", region = 1, chapter = 2 },
		{ name = "Echo Isles", region = 1, chapter = 2 },
		{ name = "Feathermoon", region = 1, chapter = 2 },
		{ name = "Frostwolf", region = 1, chapter = 2 },
		{ name = "Galakrond", region = 1, chapter = 2 },
		{ name = "Gnomeregan", region = 1, chapter = 2 },
		{ name = "Gorgonnash", region = 1, chapter = 2 },
		{ name = "Gurubashi", region = 1, chapter = 2 },
		{ name = "Hyjal", region = 1, chapter = 2 },
		{ name = "Kalecgos", region = 1, chapter = 2 },
		{ name = "Kil'Jaeden", region = 1, chapter = 2 },
		{ name = "Kilrogg", region = 1, chapter = 2 },
		{ name = "Korialstrasz", region = 1, chapter = 2 },
		{ name = "Lethon", region = 1, chapter = 2 },
		{ name = "Lightbringer", region = 1, chapter = 2 },
		{ name = "Maiev", region = 1, chapter = 2 },
		{ name = "Misha", region = 1, chapter = 2 },
		{ name = "Moonrunner", region = 1, chapter = 2 },
		{ name = "Nazjatar", region = 1, chapter = 2 },
		{ name = "Ner'zhul", region = 1, chapter = 2 },
		{ name = "Nordrassil", region = 1, chapter = 2 },
		{ name = "Onyxia", region = 1, chapter = 2 },
		{ name = "Proudmoore", region = 1, chapter = 2 },
		{ name = "Rivendare", region = 1, chapter = 2 },
		{ name = "Sentinels", region = 1, chapter = 2 },
		{ name = "Shadowsong", region = 1, chapter = 2 },
		{ name = "Shattered Halls", region = 1, chapter = 2 },
		{ name = "Shu'Halo", region = 1, chapter = 2 },
		{ name = "Silver Hand", region = 1, chapter = 2 },
		{ name = "Silvermoon", region = 1, chapter = 2 },
		{ name = "Skywall", region = 1, chapter = 2 },
		{ name = "Spinebreaker", region = 1, chapter = 2 },
		{ name = "Spirestone", region = 1, chapter = 2 },
		{ name = "Stonemaul", region = 1, chapter = 2 },
		{ name = "Stormscale", region = 1, chapter = 2 },
		{ name = "Suramar", region = 1, chapter = 2 },
		{ name = "The Scryers", region = 1, chapter = 2 },
		{ name = "The Venture Co US", region = 1, chapter = 2 },
		{ name = "Tichondrius", region = 1, chapter = 2 },
		{ name = "Uldum", region = 1, chapter = 2 },
		{ name = "Ursin", region = 1, chapter = 2 },
		{ name = "Uther", region = 1, chapter = 2 },
		{ name = "Vashj", region = 1, chapter = 2 },
		{ name = "Velen", region = 1, chapter = 2 },
		{ name = "Windrunner", region = 1, chapter = 2 },
		{ name = "Wyrmrest Accord", region = 1, chapter = 2 },
		
		-- Mountain
		{ name = "Azjol-Nerub", region = 1, chapter = 3 },
		{ name = "Bloodscalp", region = 1, chapter = 3 },
		{ name = "Darkspear", region = 1, chapter = 3 },
		{ name = "Deathwing", region = 1, chapter = 3 },
		{ name = "Doomhammer", region = 1, chapter = 3 },
		{ name = "Icecrown", region = 1, chapter = 3 },
		{ name = "Kel'Thuzad", region = 1, chapter = 3 },
		{ name = "Nathrezim", region = 1, chapter = 3 },
		{ name = "Perenolde", region = 1, chapter = 3 },
		{ name = "Shadow Council", region = 1, chapter = 3 },
		{ name = "Terenas", region = 1, chapter = 3 },
		{ name = "Zangarmarsh", region = 1, chapter = 3 },
		
		-- Central
		{ name = "Aegwynn", region = 1, chapter = 4 },
		{ name = "Agamaggan", region = 1, chapter = 4 },
		{ name = "Aggramar", region = 1, chapter = 4 },
		{ name = "Akama", region = 1, chapter = 4 },
		{ name = "Alexstrasza", region = 1, chapter = 4 },
		{ name = "Alleria", region = 1, chapter = 4 },
		{ name = "Archimonde", region = 1, chapter = 4 },
		{ name = "Azgalor", region = 1, chapter = 4 },
		{ name = "Azshara", region = 1, chapter = 4 },
		{ name = "Balnazzar", region = 1, chapter = 4 },
		{ name = "Blackhand", region = 1, chapter = 4 },
		{ name = "Blood Furnace", region = 1, chapter = 4 },
		{ name = "Borean Tundra", region = 1, chapter = 4 },
		{ name = "Burning Legion", region = 1, chapter = 4 },
		{ name = "Cairne", region = 1, chapter = 4 },
		{ name = "Cho'gall", region = 1, chapter = 4 },
		{ name = "Chromaggus", region = 1, chapter = 4 },
		{ name = "Dawnbringer", region = 1, chapter = 4 },
		{ name = "Detheroc", region = 1, chapter = 4 },
		{ name = "Drak'tharon", region = 1, chapter = 4 },
		{ name = "Drak'thul", region = 1, chapter = 4 },
		{ name = "Draka", region = 1, chapter = 4 },
		{ name = "Eitrigg", region = 1, chapter = 4 },
		{ name = "Emerald Dream", region = 1, chapter = 4 },
		{ name = "Farstriders", region = 1, chapter = 4 },
		{ name = "Fizzcrank", region = 1, chapter = 4 },
		{ name = "Frostmane", region = 1, chapter = 4 },
		{ name = "Garithos", region = 1, chapter = 4 },
		{ name = "Garona", region = 1, chapter = 4 },
		{ name = "Ghostlands", region = 1, chapter = 4 },
		{ name = "Greymane", region = 1, chapter = 4 },
		{ name = "Grizzly Hills", region = 1, chapter = 4 },
		{ name = "Gul'dan", region = 1, chapter = 4 },
		{ name = "Hakkar", region = 1, chapter = 4 },
		{ name = "Hellscream", region = 1, chapter = 4 },
		{ name = "Hydraxis", region = 1, chapter = 4 },
		{ name = "Illidan", region = 1, chapter = 4 },
		{ name = "Kael'thas", region = 1, chapter = 4 },
		{ name = "Khaz Modan", region = 1, chapter = 4 },
		{ name = "Kirin Tor", region = 1, chapter = 4 },
		{ name = "Korgath", region = 1, chapter = 4 },
		{ name = "Kul Tiras", region = 1, chapter = 4 },
		{ name = "Laughing Skull", region = 1, chapter = 4 },
		{ name = "Lightninghoof", region = 1, chapter = 4 },
		{ name = "Madoran", region = 1, chapter = 4 },
		{ name = "Maelstrom", region = 1, chapter = 4 },
		{ name = "Mal'Ganis", region = 1, chapter = 4 },
		{ name = "Malfurion", region = 1, chapter = 4 },
		{ name = "Malorne", region = 1, chapter = 4 },
		{ name = "Malygos", region = 1, chapter = 4 },
		{ name = "Moon Guard", region = 1, chapter = 4 },
		{ name = "Mug'thol", region = 1, chapter = 4 },
		{ name = "Muradin", region = 1, chapter = 4 },
		{ name = "Nesingwary", region = 1, chapter = 4 },
		{ name = "Quel'Dorei", region = 1, chapter = 4 },
		{ name = "Ravencrest", region = 1, chapter = 4 },
		{ name = "Rexxar", region = 1, chapter = 4 },
		{ name = "Runetotem", region = 1, chapter = 4 },
		{ name = "Sargeras", region = 1, chapter = 4 },
		{ name = "Scarlet Crusade", region = 1, chapter = 4 },
		{ name = "Sen'Jin", region = 1, chapter = 4 },
		{ name = "Sisters of Elune", region = 1, chapter = 4 },
		{ name = "Staghelm", region = 1, chapter = 4 },
		{ name = "Stormreaver", region = 1, chapter = 4 },
		{ name = "Terokkar", region = 1, chapter = 4 },
		{ name = "The Underbog", region = 1, chapter = 4 },
		{ name = "Thorium Brotherhood", region = 1, chapter = 4 },
		{ name = "Thunderhorn", region = 1, chapter = 4 },
		{ name = "Thunderlord", region = 1, chapter = 4 },
		{ name = "Twisting Nether", region = 1, chapter = 4 },
		{ name = "Vek'nilash", region = 1, chapter = 4 },
		{ name = "Whisperwind", region = 1, chapter = 4 },
		{ name = "Wildhammer", region = 1, chapter = 4 },
		{ name = "Winterhoof", region = 1, chapter = 4 },
		
		-- Eastern
		{ name = "Altar of Storms", region = 1, chapter = 5 },
		{ name = "Alterac Mountains", region = 1, chapter = 5 },
		{ name = "Andorhal", region = 1, chapter = 5 },
		{ name = "Anetheron", region = 1, chapter = 5 },
		{ name = "Anub'arak", region = 1, chapter = 5 },
		{ name = "Area 52", region = 1, chapter = 5 },
		{ name = "Argent Dawn", region = 1, chapter = 5 },
		{ name = "Arthas", region = 1, chapter = 5 },
		{ name = "Arygos", region = 1, chapter = 5 },
		{ name = "Auchindoun", region = 1, chapter = 5 },
		{ name = "Black Dragonflight", region = 1, chapter = 5 },
		{ name = "Bleeding Hollow", region = 1, chapter = 5 },
		{ name = "Bloodhoof", region = 1, chapter = 5 },
		{ name = "Burning Blade", region = 1, chapter = 5 },
		{ name = "Dalaran", region = 1, chapter = 5 },
		{ name = "Dalvengyr", region = 1, chapter = 5 },
		{ name = "Demon Soul", region = 1, chapter = 5 },
		{ name = "Dentarg", region = 1, chapter = 5 },
		{ name = "Drenden", region = 1, chapter = 5 },
		{ name = "Durotan", region = 1, chapter = 5 },
		{ name = "Duskwood", region = 1, chapter = 5 },
		{ name = "Earthen Ring", region = 1, chapter = 5 },
		{ name = "Eldre'Thalas", region = 1, chapter = 5 },
		{ name = "Elune", region = 1, chapter = 5 },
		{ name = "Eonar", region = 1, chapter = 5 },
		{ name = "Eredar", region = 1, chapter = 5 },
		{ name = "Executus", region = 1, chapter = 5 },
		{ name = "Exodar", region = 1, chapter = 5 },
		{ name = "Fenris", region = 1, chapter = 5 },
		{ name = "Firetree", region = 1, chapter = 5 },
		{ name = "Garrosh", region = 1, chapter = 5 },
		{ name = "Gilneas", region = 1, chapter = 5 },
		{ name = "Gorefiend", region = 1, chapter = 5 },
		{ name = "Grizzly Hills", region = 1, chapter = 5 },
		{ name = "Haomarush", region = 1, chapter = 5 },
		{ name = "Jaedenar", region = 1, chapter = 5 },
		{ name = "Kargath", region = 1, chapter = 5 },
		{ name = "Khadgar", region = 1, chapter = 5 },
		{ name = "Lightning's Blade", region = 1, chapter = 5 },
		{ name = "Llane", region = 1, chapter = 5 },
		{ name = "Lothar", region = 1, chapter = 5 },
		{ name = "Magtheridon", region = 1, chapter = 5 },
		{ name = "Mannoroth", region = 1, chapter = 5 },
		{ name = "Medivh", region = 1, chapter = 5 },
		{ name = "Nazgrel", region = 1, chapter = 5 },
		{ name = "Norgannon", region = 1, chapter = 5 },
		{ name = "Ravenholdt", region = 1, chapter = 5 },
		{ name = "Scilla", region = 1, chapter = 5 },
		{ name = "Shadowmoon", region = 1, chapter = 5 },
		{ name = "Shandris", region = 1, chapter = 5 },
		{ name = "Shattered Hand", region = 1, chapter = 5 },
		{ name = "Skullcrusher", region = 1, chapter = 5 },
		{ name = "Smolderthorn", region = 1, chapter = 5 },
		{ name = "Steamwheedle Cartel", region = 1, chapter = 5 },
		{ name = "Stormrage", region = 1, chapter = 5 },
		{ name = "Tanaris", region = 1, chapter = 5 },
		{ name = "The Forgotten Coast", region = 1, chapter = 5 },
		{ name = "Thrall", region = 1, chapter = 5 },
		{ name = "Tortheldrin", region = 1, chapter = 5 },
		{ name = "Trollbane", region = 1, chapter = 5 },
		{ name = "Turalyon", region = 1, chapter = 5 },
		{ name = "Uldaman", region = 1, chapter = 5 },
		{ name = "Undermine", region = 1, chapter = 5 },
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
		{ name = "Goldrinn", region = 1, chapter = 7 },
		{ name = "Gallywix", region = 1, chapter = 7 },
		{ name = "Nemesis", region = 1, chapter = 7 },
		{ name = "Tol Barad", region = 1, chapter = 7 },
	
	-- Korea
		-- 격노의 전장
		{ name = "렉사르", region = 2, chapter = 1 },
		{ name = "불타는 군단", region = 2, chapter = 1 },
		{ name = "와일드해머", region = 2, chapter = 1 },
		{ name = "가로나", region = 2, chapter = 1 },
		{ name = "달라란", region = 2, chapter = 1 },
		{ name = "데스윙", region = 2, chapter = 1 },
		{ name = "라그나로스", region = 2, chapter = 1 },
		{ name = "말퓨리온", region = 2, chapter = 1 },
		{ name = "세나리우스", region = 2, chapter = 1 },
		{ name = "알렉스트라자", region = 2, chapter = 1 },
		{ name = "카르가스", region = 2, chapter = 1 },
		{ name = "하이잘", region = 2, chapter = 1 },
		{ name = "헬스크림", region = 2, chapter = 1 },		
		
		-- 징벌의 전장
		{ name = "스톰레이지", region = 2, chapter = 2 },
		{ name = "윈드러너", region = 2, chapter = 2 },
		{ name = "굴단 (Gul'dan)", region = 2, chapter = 2 },
		{ name = "노르간논", region = 2, chapter = 2 },
		{ name = "듀로탄", region = 2, chapter = 2 },
		{ name = "아즈샤라", region = 2, chapter = 2 },
		{ name = "에이그윈", region = 2, chapter = 2 },
		{ name = "엘룬", region = 2, chapter = 2 },
		{ name = "이오나", region = 2, chapter = 2 },
		{ name = "줄진 (Zul'jin)", region = 2, chapter = 2 },
		
	-- EU
		-- English
		{ name = "Aerie Peak", region = 3, chapter = 1 },
		{ name = "Agamaggan", region = 3, chapter = 1 },
		{ name = "Aggra(Português)", region = 3, chapter = 1 },
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
		{ name = "Molten Core", region = 3, chapter = 1 },
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
		{ name = "Shadowmoon", region = 3, chapter = 1 },
		{ name = "Shadowsong", region = 3, chapter = 1 },
		{ name = "Shattered Halls", region = 3, chapter = 1 },
		{ name = "Shattered Hand", region = 3, chapter = 1 },
		{ name = "Silvermoon", region = 3, chapter = 1 },
		{ name = "Skullcrusher", region = 3, chapter = 1 },
		{ name = "Spinebreaker", region = 3, chapter = 1 },
		{ name = "Sporeggar", region = 3, chapter = 1 },
		{ name = "Steamwheedle Cartel", region = 3, chapter = 1 },
		{ name = "Stonemaul", region = 3, chapter = 1 },
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
		{ name = "The Venture Co EU", region = 3, chapter = 1 },
		{ name = "Thunderhorn", region = 3, chapter = 1 },
		{ name = "Trollbane", region = 3, chapter = 1 },
		{ name = "Turalyon", region = 3, chapter = 1 },
		{ name = "Twilight's Hammer", region = 3, chapter = 1 },
		{ name = "Twisting Nether", region = 3, chapter = 1 },
		{ name = "Vashj", region = 3, chapter = 1 },
		{ name = "Vek'nilash", region = 3, chapter = 1 },
		{ name = "Warsong", region = 3, chapter = 1 },
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
		{ name = "Culte de la Rive Noire", region = 3, chapter = 2 },
		{ name = "Dalaran", region = 3, chapter = 2 },
		{ name = "Drek'Thar", region = 3, chapter = 2 },
		{ name = "Eitrigg", region = 3, chapter = 2 },
		{ name = "Eldre'Thalas", region = 3, chapter = 2 },
		{ name = "Elune", region = 3, chapter = 2 },
		{ name = "Garona", region = 3, chapter = 2 },
		{ name = "Hyjal", region = 3, chapter = 2 },
		{ name = "Illidan", region = 3, chapter = 2 },
		{ name = "Kael'Thas", region = 3, chapter = 2 },
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
		{ name = "Aman'Thul", region = 3, chapter = 3 },
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
		{ name = "Der Mithrilorden", region = 3, chapter = 3 },
		{ name = "Der Rat von Dalaran", region = 3, chapter = 3 },
		{ name = "Der abyssische Rat", region = 3, chapter = 3 },
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
		{ name = "Kil'Jaeden", region = 3, chapter = 3 },
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
		{ name = "Aggra", region = 3, chapter = 6 },
		
		-- Italian
		{ name = "Nemesis", region = 3, chapter = 7 },
		{ name = "Pozzo dell’Eternità", region = 3, chapter = 7 },
		
	-- Taiwan
		-- 殺戮
		{ name = "狼狂索斯", region = 4, chapter = 1 },
		
		-- 嗜血
		{ name = "世界之樹", region = 4, chapter = 2 },
		{ name = "暗影之月", region = 4, chapter = 2 },
		{ name = "天空之牆", region = 4, chapter = 2 },
		{ name = "巴納札爾", region = 4, chapter = 2 },
		{ name = "巨龍之喉", region = 4, chapter = 2 },
		{ name = "狂熱之刃", region = 4, chapter = 2 },
		{ name = "冬握湖", region = 4, chapter = 2 },
		{ name = "雷鱗", region = 4, chapter = 2 },
		{ name = "凜風峽灣", region = 4, chapter = 2 },
		{ name = "米奈希爾", region = 4, chapter = 2 },
		{ name = "死亡之翼", region = 4, chapter = 2 },
		{ name = "水晶之刺", region = 4, chapter = 2 },
		{ name = "艾奧那斯", region = 4, chapter = 2 },
		{ name = "遠祖灘頭", region = 4, chapter = 2 },
		{ name = "日落沼澤", region = 4, chapter = 2 },
		{ name = "戰歌", region = 4, chapter = 2 },
		{ name = "提克迪奧斯", region = 4, chapter = 2 },
		{ name = "地獄吼", region = 4, chapter = 2 },
		{ name = "尖石", region = 4, chapter = 2 },
		{ name = "風暴群山", region = 4, chapter = 2 },
		{ name = "火焰之樹", region = 4, chapter = 2 },
		{ name = "冰霜之刺", region = 4, chapter = 2 },
		{ name = "冰風崗哨", region = 4, chapter = 2 },
		
		-- 暴怒
		{ name = "聖光之願 (Light's Hope)", region = 4, chapter = 3 },
		{ name = "亞雷戈斯", region = 4, chapter = 3 },
		{ name = "語風", region = 4, chapter = 3 },
		{ name = "奧妮克希亞", region = 4, chapter = 3 },
		{ name = "暴風祭壇", region = 4, chapter = 3 },
		{ name = "眾星之子 (Quel'dorei)", region = 4, chapter = 3 },
		{ name = "科爾蘇加德 (Kel’Thuzad)", region = 4, chapter = 3 },
		{ name = "狂心", region = 4, chapter = 3 },
		{ name = "鬼霧峰", region = 4, chapter = 3 },
		{ name = "奎爾達納斯 (Quel'Danas)", region = 4, chapter = 3 },
		{ name = "奈辛瓦里", region = 4, chapter = 3 },
		{ name = "屠魔山谷", region = 4, chapter = 3 },
		{ name = "諾姆瑞根", region = 4, chapter = 3 },
		{ name = "憤怒使者", region = 4, chapter = 3 },
		{ name = "撒爾薩里安", region = 4, chapter = 3 },
		{ name = "阿薩斯", region = 4, chapter = 3 },
		{ name = "夜空之歌", region = 4, chapter = 3 },
		{ name = "惡魔之魂", region = 4, chapter = 3 },
		{ name = "銀翼要塞", region = 4, chapter = 3 },
		{ name = "寒冰皇冠", region = 4, chapter = 3 },
		{ name = "血之谷", region = 4, chapter = 3 },
		{ name = "黑龍軍團", region = 4, chapter = 3 },
		
};

function PremadeFilter_GetMessage(str)
	return L[str];
end

function PremadeFilter_GetRegionRealms(realmInfo)
	local realmList = {};
	local chapter = nil;
	local currentChapterIndex = nil;
	
	for index, info in pairs(PremadeFilter_Relams) do
		if info.region == realmInfo.region then
			if info.chapter ~= chapter then
				chapter = info.chapter;
				currentChapterIndex = #realmList + 1;
				
				-- add chapter
				table.insert(realmList, {
					isChapter = true,
					isCollapsed = true,
					name = PremadeFilter_RealmChapters[info.region][info.chapter],
					region = info.region,
					chapter = info.chapter,
					index = currentChapterIndex,
					isChecked = true
				});
			end
			
			-- add realm
			info.index = #realmList + 1;
			info.chapterIndex = currentChapterIndex;
			info.isChecked = true;
			table.insert(realmList, info);
		end
	end
	
	return realmList;
end

function PremadeFilter_GetRealmInfo(region, realmName)
	for index, info in pairs(PremadeFilter_Relams) do
		if info.region == region and info.name == realmName then
			return info;
		end
	end
	
	return nil;
end

function PremadeFilter_Frame_OnLoad(self)
	LFGListFrame.SearchPanel.SearchBox:SetSize(205, 18);
	LFGListFrame.SearchPanel.SearchBox:SetMaxLetters(1023);
	LFGListFrame.SearchPanel.SearchBox:SetScript("OnEditFocusGained", nop);
	LFGListFrame.SearchPanel.SearchBox:SetScript("OnEditFocusLost", nop);
	LFGListFrame.SearchPanel.SearchBox:SetScript("OnTextChanged", LFGListFrameSearchBox_OnTextChanged);
	LFGListFrame.SearchPanel.AutoCompleteFrame:Hide();
	
	LFGListFrame.EntryCreation.Description:SetSize(283, 22);
	LFGListFrame.EntryCreation.Description.EditBox:SetMaxLetters(LFGListFrame.EntryCreation.Description.EditBox:GetMaxLetters()-2);
	
	LFGListFrame.EntryCreation.Name:SetScript("OnTabPressed", LFGListEditBox_OnTabPressed);
	LFGListFrame.EntryCreation.Description.EditBox:SetScript("OnTabPressed", LFGListEditBox_OnTabPressed);
	LFGListFrame.EntryCreation.ItemLevel.EditBox:SetScript("OnTabPressed", LFGListEditBox_OnTabPressed);
	LFGListFrame.EntryCreation.VoiceChat.EditBox:SetScript("OnTabPressed", LFGListEditBox_OnTabPressed);
	
	LFGListFrame.EntryCreation.ItemLevel.CheckButton:SetScript("OnClick", PremadeFilter_CheckButton_OnClick);
	LFGListFrame.EntryCreation.ItemLevel.EditBox:SetScript("OnEditFocusLost", nop);
	LFGListFrame.EntryCreation.ItemLevel.EditBox:Hide();
	
	LFGListFrame.EntryCreation.VoiceChat.CheckButton:SetScript("OnClick", PremadeFilter_CheckButton_OnClick);
	LFGListFrame.EntryCreation.VoiceChat.EditBox:SetScript("OnEditFocusLost", nop);
	LFGListFrame.EntryCreation.VoiceChat.EditBox:Hide();
	
	PremadeFilter_Roles:SetParent(LFGListFrame.EntryCreation);
	PremadeFilter_Roles:SetPoint("TOPLEFT", LFGListFrame.EntryCreation, "TOPLEFT", -10, -20);
	
	self.AdvancedButton:SetParent(LFGListFrame.SearchPanel);
	self.AdvancedButton:SetPoint("TOPRIGHT", LFGListFrame.SearchPanel, "TOPRIGHT", -10, -55);
	
	self:SetParent(LFGListFrame.SearchPanel);
	self:SetPoint("TOPLEFT", LFGListFrame.SearchPanel, "TOPRIGHT", 10, -20);
	
	self.Name.Instructions:SetText(LFG_LIST_ENTER_NAME);
	self.Description.EditBox:SetScript("OnEnterPressed", nop);
	
	LFGListUtil_SetUpDropDown(self, self.CategoryDropDown, LFGListEntryCreation_PopulateCategories, PremadeFilter_OnCategorySelected);
	LFGListUtil_SetUpDropDown(self, self.GroupDropDown, LFGListEntryCreation_PopulateGroups, PremadeFilter_OnGroupSelected);
	LFGListUtil_SetUpDropDown(self, self.ActivityDropDown, LFGListEntryCreation_PopulateActivities, PremadeFilter_OnActivitySelected);
	LFGListEntryCreation_SetBaseFilters(self, 0);
	
	PremadeFilter_OnHide(self);
	
	self.baseFilters = LE_LFG_LIST_FILTER_PVE;
	self.selectedFilters = LE_LFG_LIST_FILTER_PVE;
	self.results = {};
	self.realmName = GetRealmName();
	self.realmInfo = PremadeFilter_GetRealmInfo(GetCurrentRegion(), self.realmName);
	self.realmList = PremadeFilter_GetRegionRealms(self.realmInfo);
	self.visibleRealms = PremadeFilter_GetVisibleRealms();
	
	PremadeFilter_RealmList_Update();
end

function PremadeFilter_OnShow(self)
	local categoryID = LFGListFrame.categoryID
	local baseFilters = LFGListFrame.baseFilters;
	
	self.categoryID = categoryID;
	self.baseFilters = baseFilters;

	local selectedCategory = LFGListFrame.CategorySelection.selectedCategory;
	local selectedFilters = LFGListFrame.CategorySelection.selectedFilters;
	
	LFGListEntryCreation_Select(self, selectedFilters, selectedCategory, nil, nil);

	self.QueryBuilder:SetParent(self);
	self.QueryBuilder:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
	self.QueryBuilder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, 5);
	
	self.Name.BuildButton:SetParent(self.Name);
	self.Name.BuildButton:SetPoint("TOPRIGHT", self.Name, "TOPRIGHT", 0, -1);
	
	LFGListFrameSearchBox_OnTextChanged(LFGListFrame.SearchPanel.SearchBox);
end

function PremadeFilter_OnHide(self)
	PremadeFilter_Frame.QueryBuilder:SetParent(LFGListFrame);
	PremadeFilter_Frame.QueryBuilder:SetPoint("TOPLEFT", LFGListFrame, "TOPLEFT", -5, -21);
	PremadeFilter_Frame.QueryBuilder:SetPoint("BOTTOMRIGHT", LFGListFrame, "BOTTOMRIGHT", -2, 2);
	
	self.Name.BuildButton:SetParent(LFGListFrame.SearchPanel.SearchBox);
	self.Name.BuildButton:SetPoint("TOPRIGHT", LFGListFrame.SearchPanel.SearchBox, "TOPRIGHT", -1, 1);
end

function LFGListFrameSearchBox_OnTextChanged(self)
	local text = self:GetText();
	PremadeFilter_Frame.Name:SetText(text);
	InputBoxInstructions_OnTextChanged(self);
end

function LFGListEditBox_OnTabPressed(self)
	if ( self.tabCategory ) then
		local step = IsShiftKeyDown() and -1 or 1;
		local offset = step;
		local cat = LFG_LIST_EDIT_BOX_TAB_CATEGORIES[self.tabCategory];
		if ( cat ) then
			--It's times like this when I wish Lua was 0-based...
			repeat
				local index = ((self.tabCategoryIndex - 1 + offset + #cat) % #cat) + 1;
				local input = cat[index];
				if input:IsVisible() then
					input:SetFocus();
				else
					offset = offset + step;
				end
			until input:IsVisible();
		end
	end
end

function PremadeFilter_FilterButton_OnClick(self)
	LFGListSearchPanel_SetCategory(LFGListFrame.SearchPanel, PremadeFilter_Frame.selectedCategory, PremadeFilter_Frame.selectedFilters, PremadeFilter_Frame.selectedFilters);
	LFGListSearchPanel_DoSearch(self:GetParent():GetParent());
end

function PremadeFilter_GetVisibleRealms()
	local visibleRealms = {};
	
	for i=1, #PremadeFilter_Frame.realmList do
		local info = PremadeFilter_Frame.realmList[i];
		if info.isChapter or not PremadeFilter_Frame.realmList[info.chapterIndex].isCollapsed then
			table.insert(visibleRealms, info);
		end
	end
	
	return visibleRealms;
end

function PremadeFilter_GetSelectedRealms()
	local selectedRealms = {""};
	
	for i=1, #PremadeFilter_Frame.realmList do
		local info = PremadeFilter_Frame.realmList[i];
		if not info.isChapter and info.isChecked then
			local name = info.name:gsub("[%s]+", "");
			table.insert(selectedRealms, name:lower());
		end
	end
	
	return selectedRealms;
end

function PremadeFilter_ExpandOrCollapseButton_OnClick(self, button)
	local info = self:GetParent().info;
	
	PremadeFilter_Frame.realmList[info.index].isCollapsed = not info.isCollapsed;
	PremadeFilter_Frame.visibleRealms = PremadeFilter_GetVisibleRealms();
	
	PremadeFilter_RealmList_Update();
end

function PremadeFilter_RealmListCheckButton_OnClick(button, category, dungeonList, hiddenByCollapseList)
	local info = button:GetParent().info;
	local update = info.isChapter and not info.isCollapsed;
	local isChecked = button:GetChecked();
	
	if info.isChapter then
		local chapter = info.chapter;
		local index = info.index;
		repeat
			PremadeFilter_Frame.realmList[info.index].isChecked = isChecked;
			info = PremadeFilter_Frame.realmList[info.index+1];
		until not info or info.isChapter;
	else
		PremadeFilter_Frame.realmList[info.index].isChecked = isChecked;
		
		local chapterInfo = PremadeFilter_Frame.realmList[info.chapterIndex];
		local chapterChecked = true;
		info = PremadeFilter_Frame.realmList[chapterInfo.index + 1];
		repeat
			chapterChecked = chapterChecked and info.isChecked;
			info = PremadeFilter_Frame.realmList[info.index+1];
		until not chapterChecked or not info or info.isChapter;
		
		if chapterChecked ~= chapterInfo.isChecked then
			PremadeFilter_Frame.realmList[chapterInfo.index].isChecked = chapterChecked;
			update = true;
		end
	end
	
	if update then
		PremadeFilter_RealmList_Update();
	end
	
	PlaySound(isChecked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff");
end

function PremadeFilter_RealmList_Update()
	FauxScrollFrame_Update(PremadeFilter_Frame_RealmListScrollFrame, #PremadeFilter_Frame.visibleRealms, 12, 16);
	
	local offset = FauxScrollFrame_GetOffset(PremadeFilter_Frame_RealmListScrollFrame);
	
	local enabled, queued = LFGDungeonList_EvaluateListState(LE_LFG_CATEGORY_LFD);
	
	checkedList = LFGEnabledList;
	
	for i = 1, 12 do
		local button = _G["PremadeFilter_Frame_RealmListButton"..i];
		local info = PremadeFilter_Frame.visibleRealms[i+offset];
		if info then
			button.info = info;
			button.instanceName:SetText(info.name);
			button.instanceName:SetFontObject(QuestDifficulty_Header);
			button.instanceName:SetPoint("RIGHT", button, "RIGHT", 0, 0);
			
			if info.isChapter then
				if info.isCollapsed then
					button.expandOrCollapseButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP");
				else
					button.expandOrCollapseButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP");
				end
				button.expandOrCollapseButton:Show();
			else
				button.expandOrCollapseButton:Hide();
			end
			
			button.enableButton:SetChecked(info.isChecked);
			
			button:SetWidth(295);
			button:Show();
		else
			button:Hide();
		end
	end
end

function PremadeFilter_OnCategorySelected(self, id, filters)
	self.selectedCategory = id;
	self.selectedFilters = filters;
	
	LFGListCategorySelection_SelectCategory(LFGListFrame.CategorySelection, id, filters);
	LFGListEntryCreation_OnCategorySelected(self, id, filters)
end

function PremadeFilter_OnGroupSelected(self, id, buttonType)
	self.selectedGroup = id;
	
	LFGListEntryCreation_OnGroupSelected(self, id, buttonType);
end

function PremadeFilter_OnActivitySelected(self, id, buttonType)
	self.selectedActivity = id;
	
	LFGListEntryCreation_OnActivitySelected(self, id, buttonType);
end

function LFGListEntryCreation_PopulateGroups(self, dropDown, info)
	if ( not self.selectedCategory ) then
		--We don't have a category, so we can't fill out groups.
		return;
	end
	
	--Start out displaying everything
	local groups = C_LFGList.GetAvailableActivityGroups(self.selectedCategory, bit.bor(self.baseFilters, self.selectedFilters));
	local activities = C_LFGList.GetAvailableActivities(self.selectedCategory, 0, bit.bor(self.baseFilters, self.selectedFilters));
	
	local groupOrder = groups[1] and select(2, C_LFGList.GetActivityGroupInfo(groups[1]));
	local activityOrder = activities[1] and select(10, C_LFGList.GetActivityInfo(activities[1]));

	local groupIndex, activityIndex = 1, 1;

	--Start merging
	for i=1, MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES do
		if ( not groupOrder and not activityOrder ) then
			break;
		end

		if ( activityOrder and (not groupOrder or activityOrder < groupOrder) ) then
			local activityID = activities[activityIndex];
			local name = select(ACTIVITY_RETURN_VALUES.shortName, C_LFGList.GetActivityInfo(activityID));

			info.text = name;
			info.value = activityID;
			info.arg1 = "activity";
			info.checked = (self.selectedActivity == activityID);
			info.isRadio = true;
			UIDropDownMenu_AddButton(info);

			activityIndex = activityIndex + 1;
			activityOrder = activities[activityIndex] and select(10, C_LFGList.GetActivityInfo(activities[activityIndex]));
		else
			local groupID = groups[groupIndex];
			local name = C_LFGList.GetActivityGroupInfo(groupID);

			info.text = name;
			info.value = groupID;
			info.arg1 = "group";
			info.checked = (self.selectedGroup == groupID);
			info.isRadio = true;
			UIDropDownMenu_AddButton(info);

			groupIndex = groupIndex + 1;
			groupOrder = groups[groupIndex] and select(2, C_LFGList.GetActivityGroupInfo(groups[groupIndex]));
		end
	end
end

function LFGListSearchPanel_DoSearch(self)
	local category = PremadeFilter_Frame.selectedCategory;
	
	--if visible and category then
	if category then
		C_LFGList.Search(category, "", self.filters, self.preferredFilters);
	else
		local searchText = self.SearchBox:GetText();
		C_LFGList.Search(self.categoryID, searchText, self.filters, self.preferredFilters);
	end
	
	self.searching = true;
	self.searchFailed = false;
	self.selectedResult = nil;
	
	local totalResults, results = C_LFGList.GetSearchResults();
	local ageMin = nil;
	
	for i=1, #results do
		local id, activityID, name, comment, voiceChat, iLvl, age = C_LFGList.GetSearchResultInfo(results[i]);
		if not ageMin or age < ageMin then
			ageMin = age;
		end
	end
	
	if not ageMin then
		ageMin = 0;
	end
	PremadeFilter_Frame.updated = time() - ageMin + 1;
	
	LFGListSearchPanel_UpdateResultList(self);
	LFGListSearchPanel_UpdateResults(self);
end

function LFGListSearchPanel_UpdateResultList(self)
	self.totalResults, self.results = C_LFGList.GetSearchResults();
	self.applications = C_LFGList.GetApplications();
	
	local searchText = self.SearchBox:GetText():lower();
	local include, exclude, possible = PremadeFilter_ParseQuery(searchText);

	local numResults = 0;
	local newResults = {};
	
	for i=1, #self.results do
		local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers = C_LFGList.GetSearchResultInfo(self.results[i]);
		local activityName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
		
		local matches = PremadeFilter_IsStringMatched(name:lower(), include, exclude, possible);
		
		-- check additional filters
		if PremadeFilter_Frame:IsVisible() then
			-- description
			local descrText = PremadeFilter_Frame.Description.EditBox:GetText();
			if descrText ~= "" then
				local descrInclude, descrExclude, descrPossible = PremadeFilter_ParseQuery(descrText);
				local descrMatches = PremadeFilter_IsStringMatched(comment:lower(), descrInclude, descrExclude, descrPossible);
				matches = matches and descrMatches;
			end
			
			-- item level
			if PremadeFilter_Frame.ItemLevel.CheckButton:GetChecked() then
				local ilvlText = tonumber(PremadeFilter_Frame.ItemLevel.EditBox:GetText());
				if ilvlText then
					local ilvlMatches = (iLvl >= ilvlText);
					matches = matches and ilvlMatches;
				end
			end
			
			-- voice chat
			if PremadeFilter_Frame.VoiceChat.CheckButton:GetChecked() then
				local vcText = PremadeFilter_Frame.VoiceChat.EditBox:GetText();
				local vcMatches = false;
				
				if PremadeFilter_Frame.VoiceChat.CheckButton.CheckedNone then
					vcMatches = (voiceChat == "");
				else
					if vcText ~= "" then
						vcMatches = (voiceChat:lower() == vcText:lower());
					else
						vcMatches = (voiceChat ~= "");
					end
				end;
				
				matches = matches and vcMatches;
			end
			
			-- category
			local category = PremadeFilter_Frame.selectedCategory;
			if category then
				local categoryMatches = (categoryID == category);
				matches = matches and categoryMatches;
				
			end
			
			-- group
			local group = PremadeFilter_Frame.selectedGroup;
			if group then
				local groupMatches = (groupID == group);
				matches = matches and groupMatches;
				
			end
			
			-- activity
			local activity = PremadeFilter_Frame.selectedActivity;
			if activity then
				local activityMatches = (activityID == activity);
				matches = matches and activityMatches;
			end
			
			-- roles
			local tank = PremadeFilter_Frame.TankCheckButton:GetChecked();
			local heal = PremadeFilter_Frame.HealerCheckButton:GetChecked();
			local dps  = PremadeFilter_Frame.DamagerCheckButton:GetChecked();
			local roles = 0;
			
			if tank or heal or dps then
				if tank then roles = roles+4 end
				if heal then roles = roles+2 end
				if dps  then roles = roles+1 end
				
				-- check if premade has role bit mask
				local lastWord = string.sub(comment, comment:len()-1);
				local byte1 = string.byte(lastWord, 1, 1);
				local byte2 = string.byte(lastWord, 2, 2);
				
				if byte1 == 194 and byte2 >=128 and byte2 <= 135 then
					local roleMatches = bit.band(roles, byte2-128) ~= 0;
					matches = matches and roleMatches;
				end
			end
			
			-- realm
			local realms = PremadeFilter_GetSelectedRealms();
			local realmStr = table.concat(realms, "-");
			if leaderName then
				local leaderRealm = leaderName:gmatch("-.+$")();
				matches = matches and realmStr:match(leaderRealm:lower());
			end
		end
		
		-- RESULT
		if matches then
			numResults = numResults + 1
			newResults[numResults] = self.results[i];
		end
	end

	self.totalResults = numResults;
	self.results = newResults;
	
	LFGListUtil_SortSearchResults(self.results);
end

function LFGListSearchPanel_UpdateResults(self)
	local offset = HybridScrollFrame_GetOffset(self.ScrollFrame);
	local buttons = self.ScrollFrame.buttons;

	--If we have an application selected, deselect it.
	LFGListSearchPanel_ValidateSelected(self);

	if ( self.searching ) then
		self.SearchingSpinner:Show();
		self.ScrollFrame.NoResultsFound:Hide();
		self.ScrollFrame.StartGroupButton:Hide();
		for i=1, #buttons do
			buttons[i]:Hide();
		end
	else
		self.SearchingSpinner:Hide();
		local results = self.results;
		local apps = self.applications;

		for i=1, #buttons do
			local button = buttons[i];
			local idx = i + offset;
			local result = (idx <= #apps) and apps[idx] or results[idx - #apps];

			if ( result ) then
				button.resultID = result;
				LFGListSearchEntry_Update(button);
				button:Show();
			else
				button.created = 0;
				button.resultID = nil;
				button:Hide();
			end
		end

		local totalHeight = buttons[1]:GetHeight() * (#results + #apps);

		--Reanchor the errors to not overlap applications
		if ( totalHeight < self.ScrollFrame:GetHeight() ) then
			self.ScrollFrame.NoResultsFound:SetPoint("TOP", self.ScrollFrame, "TOP", 0, -totalHeight - 27);
		end
		self.ScrollFrame.NoResultsFound:SetShown(self.totalResults == 0);
		self.ScrollFrame.StartGroupButton:SetShown(self.totalResults == 0 and not self.searchFailed);
		self.ScrollFrame.NoResultsFound:SetText(self.searchFailed and LFG_LIST_SEARCH_FAILED or LFG_LIST_NO_RESULTS_FOUND);

		HybridScrollFrame_Update(self.ScrollFrame, totalHeight, self.ScrollFrame:GetHeight());
	end
	LFGListSearchPanel_UpdateButtonStatus(self);
end

function LFGListSearchEntry_Update(self)
	local resultID = self.resultID;
	local _, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(resultID);
	local isApplication = (appStatus ~= "none" or pendingStatus);
	local isAppFinished = LFGListUtil_IsStatusInactive(appStatus) or LFGListUtil_IsStatusInactive(pendingStatus);

	--Update visibility based on whether we're an application or not
	self.isApplication = isApplication;
	self.ApplicationBG:SetShown(isApplication and not isAppFinished);
	self.ResultBG:SetShown(not isApplication or isAppFinished);
	self.DataDisplay:SetShown(not isApplication);
	self.CancelButton:SetShown(isApplication and pendingStatus ~= "applied");
	self.CancelButton:SetEnabled(LFGListUtil_IsAppEmpowered());
	self.CancelButton.Icon:SetDesaturated(not LFGListUtil_IsAppEmpowered());
	self.CancelButton.tooltip = (not LFGListUtil_IsAppEmpowered()) and LFG_LIST_APP_UNEMPOWERED;
	self.Spinner:SetShown(pendingStatus == "applied");
	
	if ( pendingStatus == "applied" and C_LFGList.GetRoleCheckInfo() ) then
		self.PendingLabel:SetText(LFG_LIST_ROLE_CHECK);
		self.PendingLabel:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( pendingStatus == "cancelled" or appStatus == "cancelled" or appStatus == "failed" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_CANCELLED);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "declined" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_DECLINED);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "timedout" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_TIMED_OUT);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "invited" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITED);
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "inviteaccepted" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITE_ACCEPTED);
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "invitedeclined" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITE_DECLINED);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( isApplication and pendingStatus ~= "applied" ) then
		self.PendingLabel:SetText(LFG_LIST_PENDING);
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Show();
		self.CancelButton:Show();
	else
		self.PendingLabel:Hide();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	end

	--Center justify if we're on more than one line
	if ( self.PendingLabel:GetHeight() > 15 ) then
		self.PendingLabel:SetJustifyH("CENTER");
	else
		self.PendingLabel:SetJustifyH("RIGHT");
	end

	--Change the anchor of the label depending on whether we have the expiration time
	if ( self.ExpirationTime:IsShown() ) then
		self.PendingLabel:SetPoint("RIGHT", self.ExpirationTime, "LEFT", -3, 0);
	else
		self.PendingLabel:SetPoint("RIGHT", self.ExpirationTime, "RIGHT", -3, 0);
	end

	self.expiration = GetTime() + appDuration;

	local panel = self:GetParent():GetParent():GetParent();

	local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(resultID);
	local activityName = C_LFGList.GetActivityInfo(activityID);

	self.resultID = resultID;
	self.Selected:SetShown(panel.selectedResult == resultID and not isApplication and not isDelisted);
	self.Highlight:SetShown(panel.selectedResult ~= resultID and not isApplication and not isDelisted);
	local nameColor = NORMAL_FONT_COLOR;
	local activityColor = GRAY_FONT_COLOR;
	if ( isDelisted or isAppFinished ) then
		nameColor = LFG_LIST_DELISTED_FONT_COLOR;
		activityColor = LFG_LIST_DELISTED_FONT_COLOR;
	elseif ( numBNetFriends > 0 or numCharFriends > 0 or numGuildMates > 0 ) then
		nameColor = BATTLENET_FONT_COLOR;
	elseif time() - age > PremadeFilter_Frame.updated then
		nameColor = LFG_LIST_FRESH_FONT_COLOR;
	end
	
	self.Name:SetWidth(0);
	self.Name:SetText(name);
	self.Name:SetTextColor(nameColor.r, nameColor.g, nameColor.b);
	self.ActivityName:SetText(activityName);
	self.ActivityName:SetTextColor(activityColor.r, activityColor.g, activityColor.b);
	self.VoiceChat:SetShown(voiceChat ~= "");
	self.VoiceChat.tooltip = voiceChat;

	local displayData = C_LFGList.GetSearchResultMemberCounts(resultID);
	LFGListGroupDataDisplay_Update(self.DataDisplay, activityID, displayData, isDelisted);

	local nameWidth = isApplication and 165 or 176;
	if ( voiceChat ~= "" ) then
		nameWidth = nameWidth - 22;
	end
	if ( self.Name:GetWidth() > nameWidth ) then
		self.Name:SetWidth(nameWidth);
	end
	self.ActivityName:SetWidth(nameWidth);

	local mouseFocus = GetMouseFocus();
	if ( mouseFocus == self ) then
		LFGListSearchEntry_OnEnter(self);
	end
	if ( mouseFocus == self.VoiceChat ) then
		mouseFocus:GetScript("OnEnter")(mouseFocus);
	end

	if ( isApplication ) then
		self:SetScript("OnUpdate", LFGListSearchEntry_UpdateExpiration);
		LFGListSearchEntry_UpdateExpiration(self);
	else
		self:SetScript("OnUpdate", nil);
	end
end

function LFGListUtil_SortSearchResultsCB(id1, id2)
	local id1, activityID1, name1, comment1, voiceChat1, iLvl1, age1, numBNetFriends1, numCharFriends1, numGuildMates1, isDelisted1, leaderName1, numMembers1 = C_LFGList.GetSearchResultInfo(id1);
	local id2, activityID2, name2, comment2, voiceChat2, iLvl2, age2, numBNetFriends2, numCharFriends2, numGuildMates2, isDelisted2, leaderName2, numMembers2 = C_LFGList.GetSearchResultInfo(id2);
	
	--If one has more friends, do that one first
	if ( numBNetFriends1 ~= numBNetFriends2 ) then
		return numBNetFriends1 > numBNetFriends2;
	end

	if ( numCharFriends1 ~= numCharFriends2 ) then
		return numCharFriends1 > numCharFriends2;
	end

	if ( numGuildMates1 ~= numGuildMates2 ) then
		return numGuildMates1 > numGuildMates2;
	end
	
	return age1 < age2;
end

function PremadeFilter_BuildQuery()
	local include  = PremadeFilter_BuildQueryPrefix(PremadeFilter_Frame.QueryBuilder.Dialog.Include:GetText(),  "");
	local exclude  = PremadeFilter_BuildQueryPrefix(PremadeFilter_Frame.QueryBuilder.Dialog.Exclude:GetText(),  "-");
	local possible = PremadeFilter_BuildQueryPrefix(PremadeFilter_Frame.QueryBuilder.Dialog.Possible:GetText(), "?");
	
	--PremadeFilter_Frame.Name:SetText(include.." "..exclude.." "..possible);
	LFGListFrame.SearchPanel.SearchBox:SetText(include.." "..exclude.." "..possible);
end

function PremadeFilter_BuildQueryPrefix(text, prefix)
	local words = {};
	local len = 0;
	
	text = text:gsub("[%+%-%?]+", "");
	for w in text:gmatch("%S+") do table.insert(words, w); len = len + 1; end
	if len > 0 then
		return prefix..table.concat(words, " "..prefix);
	end
	
	return "";
end

function PremadeFilter_ParseQuery(searchText)
	local include = {};
	local exclude = {};
	local possible = {};
	
	if searchText ~= "" then
		local words = {}
		for w in searchText:gmatch("%S+") do table.insert(words, w) end
		
		for i,w in pairs(words) do
			local firstChar = w:sub(1,1);
			if firstChar == "+" then
				w = w:sub(2, w:len());
				if w ~= "" then
					table.insert(include, w);
				end
			elseif firstChar == "-" then
				w = w:sub(2, w:len());
				if w ~= "" then
					table.insert(exclude, w);
				end
			elseif firstChar == "?" then
				w = w:sub(2, w:len());
				if w ~= "" then
					table.insert(possible, w);
				end
			else
				table.insert(include, w);
			end
		end
	end
	
	return include, exclude, possible;
end

function PremadeFilter_IsStringMatched(str, include, exclude, possible)
	local matches = true;
	
	if next(include) ~= nil then
		for i,w in pairs(include) do
			local strMatch = str:find(w);
			if strMatch == nil then
				matches = false;
				break
			end
		end
	end
	
	if matches and next(exclude) ~= nil then
		for i,w in pairs(exclude) do
			local strMatch = str:find(w);
			if strMatch ~= nil then
				matches = false;
				break
			end
		end
	end
	
	if matches and next(possible) ~= nil then
		local strMatch = false;
		for i,w in pairs(possible) do
			local possibleMatch = str:find(w);
			if possibleMatch ~= nil then
				strMatch = true;
				break
			end
		end
		matches = matches and strMatch;
	end
	
	return matches;
end

function LFGListEntryCreation_ListGroup(self)
	local name = LFGListEntryCreation_GetSanitizedName(self);
	if ( LFGListEntryCreation_IsEditMode(self) ) then
		C_LFGList.UpdateListing(self.selectedActivity, name, tonumber(self.ItemLevel.EditBox:GetText()) or 0, self.VoiceChat.EditBox:GetText(), self.Description.EditBox:GetText());
		LFGListFrame_SetActivePanel(self:GetParent(), self:GetParent().ApplicationViewer);
	else
		local description = self.Description.EditBox:GetText();
		
		local tank = PremadeFilter_Roles.TankCheckButton:GetChecked();
		local heal = PremadeFilter_Roles.HealerCheckButton:GetChecked();
		local dps  = PremadeFilter_Roles.DamagerCheckButton:GetChecked();
		local roles = 0;
		
		if tank or heal or dps then
			if tank then roles = roles+4 end
			if heal then roles = roles+2 end
			if dps  then roles = roles+1 end
			
			description = description..string.char(194, 128+roles);
		end
		
		if(C_LFGList.CreateListing(self.selectedActivity, name, tonumber(self.ItemLevel.EditBox:GetText()) or 0, self.VoiceChat.EditBox:GetText(), description)) then
			self.WorkingCover:Show();
			LFGListEntryCreation_ClearFocus(self);
		end
	end
end

function PremadeFilter_CheckButtonSound(self)
	if ( self:GetChecked() ) then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
end

function PremadeFilter_CheckButton_OnClick(self)
	if ( self:GetChecked() ) then
		PlaySound("igMainMenuOptionCheckBoxOn");
		self:GetParent().EditBox:Show();
		self:GetParent().EditBox:SetFocus();
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
		self:GetParent().EditBox:Hide();
		self:GetParent().EditBox:ClearFocus();
		self:GetParent().EditBox:SetText("");
	end
end

function PremadeFilter_CheckButton_VoiceChat_OnClick(self)
	if not self:GetChecked() then
		PlaySound("igMainMenuOptionCheckBoxOff");
		
		if not self.CheckedNone then
			self.CheckedNone = true;
			self:SetCheckedTexture("Interface\\Buttons\\UI-MultiCheck-Up");
			self:SetChecked(true);
		else
			self.CheckedNone = false;
		end
		
		self:GetParent().EditBox:Hide();
		self:GetParent().EditBox:ClearFocus();
		self:GetParent().EditBox:SetText("");
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
		self:SetChecked(true);
		self.CheckedNone = false;
		
		self:GetParent().EditBox:Show();
		self:GetParent().EditBox:SetFocus();
	end
end

function PremadeFilter_Experimental(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
	GameTooltip:SetText(PremadeFilter_GetMessage("EXPERIMENTAL:\nWorks only on premades created with Premade Filter addon"), nil, nil, nil, nil, true);
	GameTooltip:Show();
end
