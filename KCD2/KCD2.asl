state("KingdomCome", "1.1.1")
{
	bool load : "WHGame.DLL", 0x53D9ED8, 0x60; //1 or 0
	bool fade : "WHGame.DLL", 0x5281120, 0xF48, 0x108, 0x18; //1 or 0
	bool fasttime : "WHGame.DLL", 0x52A3098; //0xFFFFFFFF or 0
	int quest : "WHGame.DLL", 0x53DE7A8, 0x650, 0x30; //Not valid for 1.1.1
}

state("KingdomCome", "1.1.2")
{
	bool load : "WHGame.DLL", 0x520910C; //1 or 0
	bool fade : "WHGame.DLL", 0x52833A0, 0xF48, 0x108, 0x18; //1 or 0
	bool fasttime : "WHGame.DLL", 0x52A5318; //0xFFFFFFFF or 0
	int quest : "WHGame.DLL", 0x53DE7A8, 0x650, 0x30; //0 for first quest, +1 per quest
}

startup
{
	vars.hasSplit = new List<int>();
}

init
{
	vars.bootingUp = true;
	timer.IsGameTimePaused = false;
	
	print(modules.First().ModuleMemorySize.ToString());
	if(modules.First().ModuleMemorySize == 1527808)
		version = "1.1.2";
	else
		version = "1.1.1";
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
	else if(current.quest != old.quest && !vars.hasSplit.Contains(current.quest)){
		vars.hasSplit.Add(current.quest);
		return true;
	}
	return false;
}

isLoading
{
	if(current.quest >= 0 && current.quest < 100)
		vars.bootingUp = false;
	return current.load || current.fade || current.fasttime || vars.bootingUp;
}