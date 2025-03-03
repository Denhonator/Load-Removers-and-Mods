state("ffxvi")
{
	uint load : "ffxvi.exe", 0x2743DC8, 0x88, 0xD60, 0x78, 0x130;
	uint start : "ffxvi.exe", 0x18150C0, 0x640;
	byte victoryTextDisplayed : "ffxvi.exe", 0x27425B8, 0x120, 0x10, 0x48, 0x38, 0xCC;
	string40 victoryText1 : "ffxvi.exe", 0x27425B8, 0x120, 0x10, 0x48, 0x38, 0xD8;
	string40 victoryText2 : "ffxvi.exe", 0x27425B8, 0x120, 0x10, 0x48, 0x38, 0xD8, 0x0;
}

state("ffxvi_demo")
{
	uint load : "ffxvi_demo.exe", 0x26DF570, 0x88, 0xD60, 0x78, 0x130;
	uint start : "ffxvi_demo.exe", 0x179D8C0, 0x640;
	byte victoryTextDisplayed : "ffxvi_demo.exe", 0x26DDD80, 0x120, 0x10, 0x48, 0x38, 0xCC;
	string40 victoryText1 : "ffxvi_demo.exe", 0x26DDD80, 0x120, 0x10, 0x48, 0x38, 0xD8;
	string40 victoryText2 : "ffxvi_demo.exe", 0x26DDD80, 0x120, 0x10, 0x48, 0x38, 0xD8, 0x0;
}

startup
{
	settings.Add("PrologueDemoSplits", true, "Prologue/Demo Splits");
	settings.CurrentDefaultParent = "PrologueDemoSplits";
	settings.Add("SplitGigas", true, "Gigas");
	settings.Add("SplitMorbol", true, "Morbol");
	settings.Add("SplitKnightOfTheBlindingDawn", true, "Knight of the Blinding Dawn");
	settings.Add("SplitEikonOfFire", true, "Eikon of Fire");
	settings.CurrentDefaultParent = null;

	settings.Add("Act1Splits", true, "Act 1 Splits");
	settings.CurrentDefaultParent = "Act1Splits";
	settings.Add("SplitShiva", true, "Shiva");
	settings.Add("SplitTiamat", true, "Tiamat");
	settings.Add("SplitFafnir", true, "Fafnir");
	settings.Add("SplitMidnightRaven", true, "Midnight Raven");
	settings.Add("SplitChirada", true, "Chirada");
	settings.Add("SplitSuparnaChirada", true, "Suparna & Chirada");
	settings.Add("SplitBenedikta", true, "Benedikta Harman");
	settings.Add("SplitGaruda", true, "Garuda I & II (Both Clive & Ifrit Fights)");
	settings.Add("SplitKnightOfTheDyingSun", true, "Knight of the Dying Sun");
	settings.Add("SplitIronGiant", true, "Iron Giant");
	settings.Add("SplitInfernalEikon", true, "Infernal Eikon");
	settings.Add("SplitImperialCannonier", true, "Imperial Cannonier");
	settings.Add("SplitAkashicDragon", true, "Akashic Dragon");
	settings.Add("SplitTyphon", true, "Typhon");
	settings.CurrentDefaultParent = null;

	settings.Add("Act2Splits", true, "Act 2 Splits");
	settings.CurrentDefaultParent = "Act2Splits";
	settings.Add("SplitRepublicanWarPanther", true, "Republican War Panther");
	settings.Add("SplitAkashicMorbol", true, "Akashic Morbol");
	settings.Add("SplitFlameLizard", true, "Flame Lizard");
	settings.Add("SplitLiquidFlame", true, "Liquid Flame");
	settings.Add("SplitCoeurl", true, "Coeurl");
	settings.Add("SplitHugoKupka", true, "Hugo Kupka");
	settings.Add("SplitTheUndertaker", true, "The Undertaker");
	settings.Add("SplitTitan", true, "Titan");
	settings.Add("SplitWhiteDragon", true, "White Dragon");
	settings.Add("SplitNecrophobe", true, "Necrophobe");
	settings.Add("SplitBahamut", true, "Bahamut I & II (Both Ifrit & Ifrit Risen Fights)");
	settings.CurrentDefaultParent = null;

	settings.Add("Act3Splits", true, "Act 3 Splits");
	settings.CurrentDefaultParent = "Act3Splits";
	settings.Add("SplitSleipnir", true, "Sleipnir Harbard");
	settings.Add("SplitEnterprise", true, "Enterprise Escape");
	settings.Add("SplitBarnabas", true, "Barnabas Tharmr");
	settings.Add("SplitAurumGiant", true, "Aurum Giant");
	settings.Add("SplitOdin", true, "Odin");
	settings.Add("SplitBehemoth", true, "Behemoth");
	settings.Add("SplitUltima", true, "Ultima");
	settings.Add("SplitUltimaPrime", true, "Ultima Prime");
	settings.Add("SplitUltimalius", true, "Ultimalius");
	settings.CurrentDefaultParent = null;

	settings.Add("EchoesSplits", false, "Echoes of the Fallen Splits");
	settings.CurrentDefaultParent = "EchoesSplits";
	settings.Add("SplitSigma", true, "Sigma");
	settings.Add("SplitAngraMainyu", true, "Angra Mainyu");
	settings.Add("SplitOmega", true, "Omega");
	settings.CurrentDefaultParent = null;

	settings.Add("RisingTideSplits", false, "The Rising Tide Splits");
	settings.CurrentDefaultParent = "RisingTideSplits";
	settings.Add("SplitPerykos", true, "Perykos");
	settings.Add("SplitHreidmar", true, "Hreidmar");
	settings.Add("SplitTimekeeper", true, "Timekeeper");
	settings.Add("SplitLeviathan", true, "Leviathan");
	settings.CurrentDefaultParent = null;

	settings.Add("KairosGateSplits", false, "Kairos Gate Splits");
	settings.CurrentDefaultParent = "KairosGateSplits";
	settings.Add("SplitFirstCircle", true, "The First Circle");
	settings.Add("SplitSecondCircle", true, "The Second Circle");
	settings.Add("SplitThirdCircle", true, "The Third Circle");
	settings.Add("SplitFourthCircle", true, "The Fourth Circle");
	settings.Add("SplitFifthCircle", true, "The Fifth Circle");
	settings.Add("SplitSixthCircle", true, "The Sixth Circle");
	settings.Add("SplitSeventhCircle", true, "The Seventh Circle");
	settings.Add("SplitEighthCircle", true, "The Eighth Circle");
	settings.Add("SplitNinthCircle", true, "The Ninth Circle");
	settings.Add("SplitTenthCircle", true, "The Tenth Circle");
	settings.Add("SplitEleventhCircle", true, "The Eleventh Circle");
	settings.Add("SplitTwelfthCircle", true, "The Twelfth Circle");
	settings.Add("SplitThirteenthCircle", true, "The Thirteenth Circle");
	settings.Add("SplitFourteenthCircle", true, "The Fourteenth Circle");
	settings.Add("SplitFifteenthCircle", true, "The Fifteenth Circle");
	settings.Add("SplitSixteenthCircle", true, "The Sixteenth Circle");
	settings.Add("SplitSeventeenthCircle", true, "The Seventeenth Circle");
	settings.Add("SplitEighteenthCircle", true, "The Eighteenth Circle");
	settings.Add("SplitNineteenthCircle", true, "The Nineteenth Circle");
	settings.Add("SplitTwentiethCircle", true, "The Twentieth Circle");
	settings.CurrentDefaultParent = null;

	settings.Add("MiscSplits", false, "Miscellaneous Splits");
	settings.CurrentDefaultParent = "MiscSplits";
	settings.Add("SplitSubquests", false, "Subquests & Sidequests");
	settings.Add("SplitMinorEncounters", false, "Minor Encounters (All 'Enemies Slain' result screens)");
	settings.CurrentDefaultParent = null;
}

init
{
	timer.IsGameTimePaused = false;
}

exit
{
	timer.IsGameTimePaused = true;
}

isLoading
{
	return current.load == 1;
}

split
{
	bool textVisible = current.victoryTextDisplayed == 1 && old.victoryTextDisplayed == 0;

	if (!textVisible) return false;

	if (settings["PrologueDemoSplits"]) {
		// Stillwind
		if (settings["SplitGigas"]                    && current.victoryText1 == "Gigas Slain")                       { return true; }
		if (settings["SplitMorbol"]                   && current.victoryText1 == "Morbol Slain")                      { return true; }
		// Phoenix Gate
		if (settings["SplitKnightOfTheBlindingDawn"]  && current.victoryText2 == "Knight of the Blinding Dawn Slain") { return true; }
		if (settings["SplitEikonOfFire"]              && current.victoryText2 == "Eikon of Fire Vanquished")          { return true; }
	}

	if (settings["Act1Splits"]) {
		// The Nysa Defile
		if (settings["SplitShiva"]                    && current.victoryText1 == "Shiva Defeated")                    { return true; }
		if (settings["SplitTiamat"]                   && current.victoryText1 == "Tiamat Bested")                     { return true; }
		// The Greatwood
		if (settings["SplitFafnir"]                   && current.victoryText2 == "Fafnir of the North Slain")         { return true; }
		if (settings["SplitMidnightRaven"]            && current.victoryText2 == "Midnight Raven Slain")              { return true; }
		// Orabelle Downs
		if (settings["SplitChirada"]                  && current.victoryText1 == "Chirada Slain")                     { return true; }
		// Caer Norvent
		if (settings["SplitSuparnaChirada"]           && current.victoryText2 == "Suparna & Chirada Slain")           { return true; }
		if (settings["SplitBenedikta"]                && current.victoryText2 == "Benedikta Defeated")                { return true; }
		// The Eye of the Tempest
		if (settings["SplitGaruda"]                   && current.victoryText1 == "Garuda Slain")                      { return true; }
		// The Kingsfall
		if (settings["SplitKnightOfTheDyingSun"]      && current.victoryText2 == "Knight of the Dying Sun Slain")     { return true; }
		// Phoenix Gate Ruins
		if (settings["SplitIronGiant"]                && current.victoryText2 == "Iron Giant Dismantled")             { return true; }
		if (settings["SplitInfernalEikon"]            && current.victoryText2 == "Shadow Vanquished")                 { return true; }
		// Drake's Head
		if (settings["SplitImperialCannonier"]        && current.victoryText2 == "Imperial Cannonier Slain")          { return true; }
		if (settings["SplitAkashicDragon"]            && current.victoryText2 == "Akashic Dragon Slain")              { return true; }
		if (settings["SplitTyphon"]                   && current.victoryText2 == "Typhon Vanquished")                 { return true; }
	}

	if (settings["Act2Splits"]) {
		// Kostnice
		if (settings["SplitRepublicanWarPanther"]     && current.victoryText2 == "Republican War Panther Slain")      { return true; }
		// Drake's Breath
		if (settings["SplitAkashicMorbol"]            && current.victoryText2 == "Akashic Morbol Slain")              { return true; }
		if (settings["SplitFlameLizard"]              && current.victoryText2 == "Flame Lizard Slain")                { return true; }
		if (settings["SplitLiquidFlame"]              && current.victoryText2 == "Liquid Flame Extinguished")         { return true; }
		// Rosalith
		if (settings["SplitCoeurl"]                   && current.victoryText1 == "Coeurl Slain")                      { return true; }
		if (settings["SplitHugoKupka"]                && current.victoryText2 == "Hugo Kupka Defeated")               { return true; }
		// Drake's Fang
		if (settings["SplitTheUndertaker"]            && current.victoryText2 == "The Undertaker Vanquished")         { return true; }
		if (settings["SplitTitan"]                    && current.victoryText1 == "Titan Slain")                       { return true; }
		// The Crystalline Dominion
		if (settings["SplitWhiteDragon"]              && current.victoryText2 == "White Dragon Slain")                { return true; }
		if (settings["SplitNecrophobe"]               && current.victoryText2 == "Necrophobe Vanquished")             { return true; }
		if (settings["SplitBahamut"]                  && current.victoryText2 == "Bahamut Defeated")                  { return true; }
	}

	if (settings["Act3Splits"]) {
		// The Free Cities of Kanver
		if (settings["SplitSleipnir"]                 && current.victoryText1 == "Sleipnir Slain")                    { return true; }
		// The Ironworks
		if (settings["SplitEnterprise"]               && current.victoryText2 == "Enterprise Escaped")                { return true; }
		// The Naldia Narrow
		if (settings["SplitBarnabas"]                 && current.victoryText1 == "Clive Bested")                      { return true; }
		// Reverie
		if (settings["SplitAurumGiant"]               && current.victoryText2 == "Aurum Giant Dismantled")            { return true; }
		if (settings["SplitOdin"]                     && current.victoryText1 == "Barnabas Slain")                    { return true; }
		// Drake's Spine
		if (settings["SplitBehemoth"]                 && current.victoryText1 == "Behemoth Slain")                    { return true; }
		if (settings["SplitUltima"]                   && current.victoryText2 == "Ultima Vanquished")                 { return true; }
		// Origin
		if (settings["SplitUltimaPrime"]              && current.victoryText2 == "Ultima Prime Thwarted")             { return true; }
		if (settings["SplitUltimalius"]               && current.victoryText2 == "Ultimalius Slain")                  { return true; }
	}

	if (settings["EchoesSplits"]) {
		// The Sagespire
		if (settings["SplitSigma"]                    && current.victoryText1 == "Sigma Defeated")                    { return true; }
		if (settings["SplitAngraMainyu"]              && current.victoryText2 == "Angra Mainyu Slain")                { return true; }
		if (settings["SplitOmega"]                    && current.victoryText1 == "Omega Defeated")                    { return true; }
	}

	if (settings["RisingTideSplits"]) {
		// The Surge
		if (settings["SplitPerykos"]                  && current.victoryText1 == "Perykos Slain")                     { return true; }
		// The Aire of Hours
		if (settings["SplitHreidmar"]                 && current.victoryText1 == "Hreidmar Slain")                    { return true; }
		if (settings["SplitTimekeeper"]               && current.victoryText2 == "Timekeeper Slain")                  { return true; }
		// The Surge
		if (settings["SplitLeviathan"]                && current.victoryText1 == "Leviathan Tamed")                   { return true; }
	}

	// Kairos Gate
	if (settings["KairosGateSplits"]) {
		if (settings["SplitFirstCircle"]              && current.victoryText2 == "The First Circle Cleared")          { return true; }
		if (settings["SplitSecondCircle"]             && current.victoryText2 == "The Second Circle Cleared")         { return true; }
		if (settings["SplitThirdCircle"]              && current.victoryText2 == "The Third Circle Cleared")          { return true; }
		if (settings["SplitFourthCircle"]             && current.victoryText2 == "The Fourth Circle Cleared")         { return true; }
		if (settings["SplitFifthCircle"]              && current.victoryText2 == "Infernal Ifrit Slain")              { return true; }
		if (settings["SplitSixthCircle"]              && current.victoryText2 == "The Sixth Circle Cleared")          { return true; }
		if (settings["SplitSeventhCircle"]            && current.victoryText2 == "The Seventh Circle Cleared")        { return true; }
		if (settings["SplitEighthCircle"]             && current.victoryText2 == "The Eighth Circle Cleared")         { return true; }
		if (settings["SplitNinthCircle"]              && current.victoryText2 == "The Ninth Circle Cleared")          { return true; }
		if (settings["SplitTenthCircle"]              && current.victoryText2 == "The Warden of Wind Slain")          { return true; }
		if (settings["SplitEleventhCircle"]           && current.victoryText2 == "The Eleventh Circle Cleared")       { return true; }
		if (settings["SplitTwelfthCircle"]            && current.victoryText2 == "The Twelfth Circle Cleared")        { return true; }
		if (settings["SplitThirteenthCircle"]         && current.victoryText2 == "The Thirteenth Circle Cleared")     { return true; }
		if (settings["SplitFourteenthCircle"]         && current.victoryText2 == "The Fourteenth Circle Cleared")     { return true; }
		if (settings["SplitFifteenthCircle"]          && current.victoryText2 == "The Warden of Stone Slain")         { return true; }
		if (settings["SplitSixteenthCircle"]          && current.victoryText2 == "The Sixteenth Circle Cleared")      { return true; }
		if (settings["SplitSeventeenthCircle"]        && current.victoryText2 == "The Seventeenth Circle Cleared")    { return true; }
		if (settings["SplitEighteenthCircle"]         && current.victoryText2 == "The Eighteenth Circle Cleared")     { return true; }
		if (settings["SplitNineteenthCircle"]         && current.victoryText2 == "The Nineteenth Circle Cleared")     { return true; }
		if (settings["SplitTwentiethCircle"]          && current.victoryText2 == "The Warden of Darkness Slain")      { return true; }
	}

	// Miscellaneous Splits
	if (settings["MiscSplits"]) {
		if (settings["SplitSubquests"]                && current.victoryText1 == "Quest Complete")                    { return true; }
		if (settings["SplitMinorEncounters"]          && current.victoryText1 == "Enemy Slain")                       { return true; }
		if (settings["SplitMinorEncounters"]          && current.victoryText1 == "Enemies Slain")                     { return true; }
		if (settings["SplitMinorEncounters"]          && current.victoryText1 == "Enemy Bested")                      { return true; }
		if (settings["SplitMinorEncounters"]          && current.victoryText1 == "Enemies Bested")                    { return true; }
		if (settings["SplitMinorEncounters"]          && current.victoryText1 == "Soldiers Bested")                   { return true; }
	}
}

start
{
	// Autostart relevant to NG and NG+ categories only.
  	return current.start == 0 && old.start == 1;
}