state("KingdomCome", "1.1.2")
{
	bool load : "WHGame.DLL", 0x520910C; //1 or 0
	bool fade : "WHGame.DLL", 0x52833A0, 0xF48, 0x108, 0x18; //1 or 0
	bool fasttime : "WHGame.DLL", 0x52A5318; //0xFFFFFFFF or 0
	int quest : "WHGame.DLL", 0x53DE7A8, 0x650, 0x30; //0 for first quest, +1 per quest
}

state("KingdomCome", "1.2.1")
{
	bool load : "WHGame.DLL", 0x53D4E48, 0x60; //1 or 0
	bool fade : "WHGame.DLL", 0x527C5A0, 0x1A0, 0x18; //1 or 0
	bool fasttime : "WHGame.DLL", 0x529E598; //0xFFFFFFFF or 0
	int quest : "WHGame.DLL", 0x53D75A8, 0x18, 0x11F0, 0x30; //0 for first quest, +1 per quest
}

state("KingdomCome", "1.2.2")
{
	bool load : "WHGame.DLL", 0x53D3C20, 0x60; //1 or 0
	bool fade : "WHGame.DLL", 0x527B390, 0x1A0, 0x18; //1 or 0
	bool fasttime : "WHGame.DLL", 0x529D398; //0xFFFFFFFF or 0
	int quest : "WHGame.DLL", 0x53D6488, 0x638, 0x30; //0 for first quest, +1 per quest
}

state("KingdomCome", "1.2.4")
{
	bool load : "WHGame.DLL", 0x53D4CB8, 0x60; //1 or 0
	bool fade : "WHGame.DLL", 0x527C3A0, 0x1A0, 0x18; //1 or 0
	bool fasttime : "WHGame.DLL", 0x529E398; //0xFFFFFFFF or 0
	int quest : "WHGame.DLL", 0x53D7500, 0x18, 0x38, 0x11F0; //0 for first quest, +1 per quest
}

startup
{
	vars.hasSplit = new List<int>();
}

init
{
	vars.bootingUp = true;
	timer.IsGameTimePaused = false;
	
	vars.memsize = modules.Where(m => m.ModuleName == "WHGame.DLL").First().ModuleMemorySize;
	print(vars.memsize.ToString());
	
	if(vars.memsize == 94892032)
		version = "1.2.4";
	else if(vars.memsize == 94887936)
		version = "1.2.2";
	else if(vars.memsize == 94900224)
		version = "1.2.1";
	else
		version = "1.1.2";
}

exit
{
	timer.IsGameTimePaused = true;
	vars.bootingUp = true;
}

split
{
	if(current.quest==1 && old.quest==0)
		vars.hasSplit.Clear();
	if(current.quest > old.quest && !vars.hasSplit.Contains(current.quest)){
		vars.hasSplit.Add(current.quest);
		return true;
	}
	return false;
}

isLoading
{
	if(current.quest >= 0 && current.quest < 200)
		vars.bootingUp = false;
	return current.load || current.fade || current.fasttime || vars.bootingUp;
}
