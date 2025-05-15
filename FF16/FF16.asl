state("ffxvi") {}
state("ffxvi_demo") {}

startup
{
	refreshRate = 30;

	// Define the identifiers and descriptions of split toggles that need to be populated in the settings.
	vars.prologueSettings = new Dictionary<String,String>()	{
		{"gigas","Gigas"},{"morbol","Morbol"},{"blindingDawn","Knight of the Blinding Dawn"},{"eikonOfFire","Eikon of Fire"}
	};

	vars.act1Settings = new Dictionary<String,String>()	{
		{"shiva","Shiva"},{"tiamat","Tiamat"},{"fafnir","Fafnir"},{"midnightRaven","Midnight Raven"}, 
		{"chirada","Chirada"},{"suparnaChirada","Suparna & Chirada"},{"benedikta","Benedikta Harman"}, 
		{"garuda1","Garuda I (As Clive)"},{"garuda2","Garuda II (As Ifrit)"},{"dyingSun","Knight of the Dying Sun"}, 
		{"ironGiant","Iron Giant"},{"infernalEikon","Infernal Eikon"},{"cannonier","Imperial Cannonier"}, 
		{"akashicDragon","Akashic Dragon"},{"typhon","Typhon"}
	};

	vars.act2Settings = new Dictionary<String,String>()	{
		{"warPanther","Republican War Panther"},{"akashicMorbol","Akashic Morbol"},{"flameLizard","Flame Lizard"},
		{"liquidFlame","Liquid Flame"},{"coeurl","Coeurl"},{"kupka","Hugo Kupka"},{"undertaker","The Undertaker"}, 
		{"titan","Titan"},{"whiteDragon","White Dragon"},{"necrophobe","Necrophobe"}, 
		{"bahamut1","Bahamut I (As Ifrit)"},{"bahamut2","Bahamut II (As Ifrit Risen)"}
	};

	vars.act3Settings = new Dictionary<String,String>()	{
		{"sleipnir","Sleipnir Harbard"},{"enterpriseEscape","Enterprise Escape"},{"barnabas","Barnabas Tharmr"}, 
		{"aurumGiant","Aurum Giant"},{"odin","Odin"},{"behemoth","Behemoth"},{"ultima","Ultima"}, 
		{"ultimaPrime","Ultima Prime"},{"ultimalius","Ultimalius"}
	};

	vars.echoesSettings = new Dictionary<String,String>() {
		{"sigma","Sigma"},{"angraMainyu","Angra Mainyu"},{"omega","Omega"}
	};

	vars.risingTideSettings = new Dictionary<String,String>() {
		{"perykos","Perykos"},{"hreidmar","Hreidmar"},{"timekeeper","Timekeeper"},{"leviathan","Leviathan"}
	};

	vars.kairosGateSettings = new Dictionary<String,String>() {
		{"circle1","The First Circle"},{"circle2","The Second Circle"},{"circle3","The Third Circle"}, 
		{"circle4","The Fourth Circle"},{"circle5","The Fifth Circle"},{"circle6","The Sixth Circle"}, 
		{"circle7","The Seventh Circle"},{"circle8","The Eighth Circle"},{"circle9","The Ninth Circle"}, 
		{"circle10","The Tenth Circle"},{"circle11","The Eleventh Circle"},{"circle12","The Twelfth Circle"}, 
		{"circle13","The Thirteenth Circle"},{"circle14","The Fourteenth Circle"},{"circle15","The Fifteenth Circle"},
		{"circle16","The Sixteenth Circle"},{"circle17","The Seventeenth Circle"},{"circle18","The Eighteenth Circle"}, 
		{"circle19","The Nineteenth Circle"},{"circle20","The Twentieth Circle"},{"kairosBoss","The Shadow Within"},
	};

	vars.miscSettings = new Dictionary<String,String>()	{
		{"subquests","Subquests & Sidequests"},{"minorEncounters","Minor Encounters (All generic result screens)"}
	};

	// Create settings categories.
	settings.Add("Options", true, "Advanced Options");
	settings.Add("PrologueDemoSplits", true, "Prologue/Demo Splits");
	settings.Add("Act1Splits", true, "Act 1 Splits");
	settings.Add("Act2Splits", true, "Act 2 Splits");
	settings.Add("Act3Splits", true, "Act 3 Splits");
	settings.Add("EchoesSplits", false, "Echoes of the Fallen Splits");
	settings.Add("RisingTideSplits", false, "The Rising Tide Splits");
	settings.Add("KairosGateSplits", false, "Kairos Gate Splits");
	settings.Add("MiscSplits", false, "Miscellaneous Splits");

	// Populate each category with its child settings.
	foreach (var item in vars.prologueSettings)		settings.Add(item.Key, true, item.Value, "PrologueDemoSplits");
	foreach (var item in vars.act1Settings)			settings.Add(item.Key, true, item.Value, "Act1Splits");
	foreach (var item in vars.act2Settings) 		settings.Add(item.Key, true, item.Value, "Act2Splits");
	foreach (var item in vars.act3Settings)			settings.Add(item.Key, true, item.Value, "Act3Splits");
	foreach (var item in vars.echoesSettings) 		settings.Add(item.Key, true, item.Value, "EchoesSplits");
	foreach (var item in vars.risingTideSettings) 	settings.Add(item.Key, true, item.Value, "RisingTideSplits");
	foreach (var item in vars.kairosGateSettings) 	settings.Add(item.Key, true, item.Value, "KairosGateSplits");
	foreach (var item in vars.miscSettings) 		settings.Add(item.Key, false, item.Value, "MiscSplits");

	// Advanced options settings.
	settings.Add("debug_file", false, "Save debug logging to LiveSplit program directory", "Options");

	/*
	 * Mapping of each victory text to the corresponding settings identifier for tracking whether or not the 
	 * split is enabled. Any language supported by the game may be included in the dictionary in this way to
	 * enable autosplitting for that language.
	 *
	 * Support for non-English autosplitting is best-effort, and may need review from a speaker of that language
	 * to ensure that each text is correctly assigned to its corresponding key.
	 *
	 * NOTE: German and French (and potentially other yet-to-be-implemented langauges) have more specific victory
	 *	 texts for minor encounters which English simply utilizes generic "Enemies Slain" texts for. These extra texts
	 *   will need to be mapped to the "minorEncounters" key for proper support, and are currently not included here.
	 */
	vars.victoryTextMap = new Dictionary<String,String>(StringComparer.OrdinalIgnoreCase) {
		// English + Japanese
		{"Gigas Slain","gigas"},{"Morbol Slain","morbol"},
		{"Knight of the Blinding Dawn Slain","blindingDawn"},{"Eikon of Fire Vanquished","eikonOfFire"},

		{"Shiva Defeated","shiva"},{"Tiamat Bested","tiamat"},
		{"Fafnir of the North Slain","fafnir"},{"Midnight Raven Slain","midnightRaven"},
		{"Chirada Slain","chirada"},
		{"Suparna & Chirada Slain","suparnaChirada"},{"Benedikta Defeated","benedikta"},
		{"Garuda Slain","garuda"},
		{"Knight of the Dying Sun Slain","dyingSun"},
		{"Iron Giant Dismantled","ironGiant"},{"Shadow Vanquished","infernalEikon"},
		{"Imperial Cannonier Slain","cannonier"},{"Akashic Dragon Slain","akashicDragon"},{"Typhon Vanquished","typhon"},

		{"Republican War Panther Slain","warPanther"},
		{"Akashic Morbol Slain","akashicMorbol"},{"Flame Lizard Slain","flameLizard"},{"Liquid Flame Extinguished","liquidFlame"},
		{"Coeurl Slain","coeurl"},{"Hugo Kupka Defeated","kupka"},
		{"The Undertaker Vanquished","undertaker"},{"Titan Slain","titan"},
		{"White Dragon Slain","whiteDragon"},{"Necrophobe Vanquished","necrophobe"},{"Bahamut Defeated","bahamut"},

		{"Sleipnir Slain","sleipnir"},
		{"Enterprise Escaped","enterpriseEscape"},
		{"Clive Bested","barnabas"},
		{"Aurum Giant Dismantled","aurumGiant"},{"Barnabas Slain","odin"},
		{"Behemoth Slain","behemoth"},{"Ultima Vanquished","ultima"},
		{"Ultima Prime Thwarted","ultimaPrime"},{"Ultimalius Slain","ultimalius"},

		{"Sigma Defeated","sigma"},{"Angra Mainyu Slain","angraMainyu"},{"Omega Defeated","omega"},

		{"Perykos Slain","perykos"},{"Hreidmar Slain","hreidmar"},{"Timekeeper Slain","timekeeper"},{"Leviathan Tamed","leviathan"},

		{"The First Circle Cleared","circle1"},{"The Second Circle Cleared","circle2"},{"The Third Circle Cleared","circle3"},
		{"The Fourth Circle Cleared","circle4"},{"Infernal Ifrit Slain","circle5"},{"The Sixth Circle Cleared","circle6"},
		{"The Seventh Circle Cleared","circle7"},{"The Eighth Circle Cleared","circle8"},{"The Ninth Circle Cleared","circle9"},
		{"The Warden of Wind Slain","circle10"},{"The Eleventh Circle Cleared","circle11"},{"The Twelfth Circle Cleared","circle12"},
		{"The Thirteenth Circle Cleared","circle13"},{"The Fourteenth Circle Cleared","circle14"},{"The Warden of Stone Slain","circle15"},
		{"The Sixteenth Circle Cleared","circle16"},{"The Seventeenth Circle Cleared","circle17"},{"The Eighteenth Circle Cleared","circle18"},
		{"The Nineteenth Circle Cleared","circle19"},{"The Warden of Darkness Slain","circle20"},{"The Shadow Within Dispelled","kairosBoss"},

		{"Quest Complete","subquests"},
		{"Enemy Slain","minorEncounters"},{"Enemies Slain","minorEncounters"},{"Enemy Bested","minorEncounters"},
		{"Enemies Bested","minorEncounters"},{"Soldiers Bested","minorEncounters"},

		// Japanese Variants
		{"HUGO DEFEATED","kupka"},{"THE 1st CIRCLE CLEARED","circle1"},{"THE 2nd CIRCLE CLEARED","circle2"},
		{"THE 3rd CIRCLE CLEARED","circle3"},{"THE 4th CIRCLE CLEARED","circle4"},{"THE 6th CIRCLE CLEARED","circle6"},
		{"THE 7th CIRCLE CLEARED","circle7"},{"THE 8th CIRCLE CLEARED","circle8"},{"THE 9th CIRCLE CLEARED","circle9"},
		{"THE 11th CIRCLE CLEARED","circle11"},{"THE 12th CIRCLE CLEARED","circle12"},{"THE 13th CIRCLE CLEARED","circle13"},
		{"THE 14th CIRCLE CLEARED","circle14"},{"THE 16th CIRCLE CLEARED","circle16"},{"THE 17th CIRCLE CLEARED","circle17"},
		{"THE 18th CIRCLE CLEARED","circle18"},{"THE 19th CIRCLE CLEARED","circle19"},

		// French
		{"Gigas vaincu","gigas"},{"Morbol vaincu","morbol"},
		{"Chevalier dragon vaincu","blindingDawn"},{"Primordial mystérieux vaincu","eikonOfFire"},

		{"Shiva vaincue","shiva"},{"Tiamat vaincu","tiamat"},
		{"Fafnir neutralisé","fafnir"},{"Corbeau de jade vaincu","midnightRaven"},
		{"Chirada vaincue","chirada"},
		{"Suparna et Chirada vaincues","suparnaChirada"},{"Benedikta vaincue","benedikta"},
		{"Garuda vaincue","garuda"},
		{"Chevalier dragon du crépuscule vaincu","dyingSun"},
		{"Géant de fer vaincu","ironGiant"},{"Ifrit vaincu","infernalEikon"},
		{"Canonnier vaincu","cannonier"},{"Dragon éthérique vaincu","akashicDragon"},{"Typhos vaincu","typhon"},

		{"Panthère de combat vaincue","warPanther"},
		{"Morbol éthérique vaincu","akashicMorbol"},{"Archéosaure de feu vaincu","flameLizard"},{"Flamme liquide vaincue","liquidFlame"},
		{"Coeurl vaincu","coeurl"},{"Hugo Kupka vaincu","kupka"},
		{"Acrolithe vaincu","undertaker"},{"Titan vaincu","titan"},
		{"Dragon blanc vaincu","whiteDragon"},{"Nécrophobie vaincue","necrophobe"},{"Bahamut vaincu","bahamut"},

		{"Sleipnir vaincu","sleipnir"},
		{"Lancement de l'Entreprise réussi","enterpriseEscape"},
		{"Combat terminé","barnabas"},
		{"Géant d'aurum vaincu","aurumGiant"},{"Barnabas vaincu","odin"},
		{"Béhémoth vaincu","behemoth"},{"Ultima défait","ultima"},
		{"Victoire sur Primo-Ultima","ultimaPrime"},{"Victoire sur Ultimalius","ultimalius"},

		{"Sigma vaincu","sigma"},{"Angra Mainyu terrassé","angraMainyu"},{"Oméga vaincu","omega"},

		{"Pérykos vaincue","perykos"},{"Hreidmarr vaincu","hreidmar"},{"Gardien du temps vaincu","timekeeper"},{"Léviathan vaincu","leviathan"},

		{"1er cercle maîtrisé","circle1"},{"2e cercle maîtrisé","circle2"},{"3e cercle maîtrisé","circle3"},
		{"4e cercle maîtrisé","circle4"},{"Ifrit enflammé vaincu","circle5"},{"6e cercle maîtrisé","circle6"},
		{"7e cercle maîtrisé","circle7"},{"8e cercle maîtrisé","circle8"},{"9e cercle maîtrisé","circle9"},
		{"Benedikta la tempétueuse vaincue","circle10"},{"11e cercle maîtrisé","circle11"},{"12e cercle maîtrisé","circle12"},
		{"13e cercle maîtrisé","circle13"},{"14e cercle maîtrisé","circle14"},{"Hugo le tumultueux vaincu","circle15"},
		{"16e cercle maîtrisé","circle16"},{"17e cercle maîtrisé","circle17"},{"18e cercle maîtrisé","circle18"},
		{"19e cercle maîtrisé","circle19"},{"Barnabas le sombre vaincu","circle20"},{"Clive enflammé vaincu","kairosBoss"},

		{"QUÊTE TERMINÉE","subquests"},
		{"Ennemis vaincus","minorEncounters"},{"Ennemis abattus","minorEncounters"},{"Ennemis éliminés","minorEncounters"},

		// German
		{"Gigas bezwungen","gigas"},{"Morbol erlegt","morbol"},
		{"Dragoon der Blendenden Morgenröte bezwungen","blindingDawn"},{"Esper des Feuers bezwungen","eikonOfFire"},

		{"Shivas Dominus bezwungen","shiva"},{"Tiamat bezwungen","tiamat"},
		{"Fafnir erlegt","fafnir"},{"Mitternachtsraben bezwungen","midnightRaven"},
		{"Chirada bezwungen","chirada"},
		{"Suparna & Chirada bezwungen","suparnaChirada"},{"Benedikta bezwungen","benedikta"},
		{"Garuda bezwungen","garuda"},
		{"Dragoon der Sterbenden Sonne bezwungen","dyingSun"},
		{"Eisengiganten zerlegt","ironGiant"},{"Schatten überwunden","infernalEikon"},
		{"Kaiserlichen Kanonier bezwungen","cannonier"},{"Akasischen Drachen erlegt","akashicDragon"},{"Typhon bezwungen","typhon"},

		{"Dhalmekischen Kriegspanther erlegt","warPanther"},
		{"Akasischen Morbol erlegt","akashicMorbol"},{"Flammenechse erlegt","flameLizard"},{"Flüssige Flamme erstickt","liquidFlame"},
		{"Coeurl erlegt","coeurl"},{"Hugo Kupka bezwungen","kupka"},
		{"Threnos bezwungen","undertaker"},{"Titan bezwungen","titan"},
		{"Weißen Drachen erlegt","whiteDragon"},{"Nekrophobos bezwungen","necrophobe"},{"Bahamut bezwungen","bahamut"},

		{"Sleipnir bezwungen","sleipnir"},
		{"Entkommen","enterpriseEscape"},
		{"Clive bezwungen","barnabas"},
		{"Goldgiganten zerlegt","aurumGiant"},{"Barnabas bezwungen","odin"},
		{"Behemoth erlegt","behemoth"},{"Ultima bezwungen","ultima"},
		{"Prim-Ultima bezwungen","ultimaPrime"},{"Ultimalius vernichtet","ultimalius"},

		{"Sigma bezwungen","sigma"},{"Angra Mainyu bezwungen","angraMainyu"},{"Omega bezwungen","omega"},

		{"Perykos bezwungen","perykos"},{"Hreidmar erlegt","hreidmar"},{"Wächter der Zeit bezwungen","timekeeper"},{"Leviathan gezähmt","leviathan"},

		{"Ersten Kreis abgeschlossen","circle1"},{"Zweiten Kreis abgeschlossen","circle2"},{"Dritten Kreis abgeschlossen","circle3"},
		{"Vierten Kreis abgeschlossen","circle4"},{"Infernalen Ifrit bezwungen","circle5"},{"Sechsten Kreis abgeschlossen","circle6"},
		{"Siebten Kreis abgeschlossen","circle7"},{"Achten Kreis abgeschlossen","circle8"},{"Neunten Kreis abgeschlossen","circle9"},
		{"Herrin des Winds bezwungen","circle10"},{"Elften Kreis abgeschlossen","circle11"},{"Zwölften Kreis abgeschlossen","circle12"},
		{"Dreizehnten Kreis abgeschlossen","circle13"},{"Vierzehnten Kreis abgeschlossen","circle14"},{"Herrn der Erde bezwungen","circle15"},
		{"Sechzehnten Kreis abgeschlossen","circle16"},{"Siebzehnten Kreis abgeschlossen","circle17"},{"Achtzehnten Kreis abgeschlossen","circle18"},
		{"Neunzehnten Kreis abgeschlossen","circle19"},{"Herrn der Dunkelheit bezwungen","circle20"},{"Infernalen Schatten bezwungen","kairosBoss"},

		{"Auftrag abgeschlossen","subquests"},
		{"Gegner bezwungen","minorEncounters"},{"Soldaten bezwungen","minorEncounters"}
	};

	// For tracking the number of times the victory text for two-part fights which re-use the same text has occurred during the run.
	vars.garuda = 0;
	vars.bahamut = 0;
}

init
{
	// Debug message handler
	string DebugPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\\" + game.ProcessName + "_debug.log";
	Action<string> DebugLog = (message) => {
		message = "[" + DateTime.Now.ToString("HH:mm:ss") + "] " + message;
		if (settings["debug_file"]) {
			using(System.IO.StreamWriter stream = new System.IO.StreamWriter(DebugPath, true)) {
				stream.WriteLine(message);
				stream.Close();
			}
		}
		print("[FFXVI_AS] " + message);
	};
	vars.DebugLog = DebugLog;
	
	// Establish required pointer locations. Signatures are valid for both full game and demo.
	IntPtr victoryTextRelPtr = IntPtr.Zero;
	IntPtr loadRelPtr = IntPtr.Zero;
	IntPtr startRelPtr = IntPtr.Zero;

	var victoryTextTarget = new SigScanTarget(3, "48 8B 05 ?? ?? ?? ?? 48 83 60 ?? 00 FF 15");
	var loadTarget = new SigScanTarget(3, "48 89 0D ?? ?? ?? ?? BA F0 00 00 00");
	var startTarget = new SigScanTarget(3, "48 8B 0D ?? ?? ?? ?? 45 33 C9 41 8B 52");

	var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);

	bool scanningError = false;
	if ((victoryTextRelPtr = scanner.Scan(victoryTextTarget)) != IntPtr.Zero) {
		print("Victory Text signature found at 0x" + victoryTextRelPtr.ToString("X"));
	} else {
		scanningError = true;
	}

	if ((loadRelPtr = scanner.Scan(loadTarget)) != IntPtr.Zero) {
		print("Loading signature found at 0x" + loadRelPtr.ToString("X"));
	} else {
		scanningError = true;
	}

	if ((startRelPtr = scanner.Scan(startTarget)) != IntPtr.Zero) {
		print("Start signature found at 0x" + startRelPtr.ToString("X"));
	} else {
		scanningError = true;
	}

	if (scanningError) throw new Exception("[FFXVI_AS] Unable to locate one or more signatures");

	vars.victoryTextPtr = victoryTextRelPtr + 0x4 + game.ReadValue<int>(victoryTextRelPtr);
	vars.loadPtr = loadRelPtr + 0x4 + game.ReadValue<int>(loadRelPtr);
	vars.startPtr = startRelPtr + 0x4 + game.ReadValue<int>(startRelPtr);

	vars.watchers = new MemoryWatcherList() {
		(vars.victoryTextDisplayed = new MemoryWatcher<int>(new DeepPointer(vars.victoryTextPtr, 0x58, 0xFF0, 0x38, 0xCC))),
		(vars.victoryText1 = new StringWatcher(new DeepPointer(vars.victoryTextPtr, 0x58, 0xFF0, 0x38, 0xD8), 40)),
		(vars.victoryText2 = new StringWatcher(new DeepPointer(vars.victoryTextPtr, 0x58, 0xFF0, 0x38, 0xD8, 0x0), 40)),
		(vars.load = new MemoryWatcher<int>(new DeepPointer(vars.loadPtr, 0x8, 0xD60, 0x78, 0x130))),
		(vars.start = new MemoryWatcher<int>(new DeepPointer(vars.startPtr, 0x640)))
	};
}

update
{
	// Process watcher state updates.
	vars.watchers.UpdateAll(game);

	// Reset the boss counters if needed when the timer is stopped.
	if ((vars.garuda > 0 || vars.bahamut > 0) && timer.CurrentPhase == TimerPhase.NotRunning) {
		vars.garuda = 0;
		vars.bahamut = 0;
		vars.DebugLog("Boss counters reset");
	}
}

start
{
	// Autostart currently only relevant to NG and NG+ categories.
  	return vars.start.Current == 0 && vars.start.Old == 1 && vars.load.Current == 1;
}

split
{
	bool textVisible = vars.victoryTextDisplayed.Current == 1 && vars.victoryTextDisplayed.Old == 0;
	if (!textVisible) return false;

	/*
	 * Fetch the correct settings key for the encounter that has been cleared
	 * by directly providing the resultant victory text to our mapping dictionary.
	 *
	 * Direct access attempts via these try-catch sequences should be more performant
	 * than any alternative dictionary searching method, especially as more languages
	 * are added for support to the dictionary mapping.
	 *
	 * NOTE: We do currently need to rely on two similar pointers for this operation.
	 *   Only one of them will be valid for any given encounter, never both.
	 */
	string settingsKey = null;
	try {
		settingsKey = vars.victoryTextMap[vars.victoryText1.Current];
		vars.DebugLog("Split: Found key '" + settingsKey + "' from victory text 1: " + vars.victoryText1.Current);
	}
	catch {
		try {
			settingsKey = vars.victoryTextMap[vars.victoryText2.Current];
			vars.DebugLog("Split: Found key '" + settingsKey + "' from victory text 2: " + vars.victoryText2.Current);
		}
		catch {
			// The mapping dictionary does not contain an entry for the victory text
			// that was received. Skip the event to avoid crashing LiveSplit.
			vars.DebugLog("Reached a split condition, but no mapping for victory text found. VT1: " + vars.victoryText1.Current + " VT2: " + vars.victoryText2.Current);
			return false;
		}
	}

	// Manage any special cases for encounters that re-use victory text more than once,
	// ensuring we pass along the correct variation of the key.
	if (settingsKey == "garuda") {
		vars.garuda++;
		settingsKey = settingsKey + vars.garuda.ToString();
	}
	else if (settingsKey == "bahamut") {
		vars.bahamut++;
		settingsKey = settingsKey + vars.bahamut.ToString();
	}
	
	// Finally, if the setting for that key is enabled, the split will activate.
	return settings[settingsKey];
}

exit
{
	// Pause the timer if the process is closed, such as if the game has crashed.
	timer.IsGameTimePaused = true;
}

isLoading
{
	return vars.load.Current == 1;
}

onStart
{
	// Ensure timer starting at 0.00
	timer.IsGameTimePaused = true;

	vars.DebugLog("Timer started");
	vars.DebugLog(" - Victory Text pointer position: 0x" + vars.victoryTextPtr.ToString("X"));
	vars.DebugLog(" - Loading pointer position: 0x" + vars.loadPtr.ToString("X"));
	vars.DebugLog(" - Start pointer position: 0x" + vars.startPtr.ToString("X"));
}