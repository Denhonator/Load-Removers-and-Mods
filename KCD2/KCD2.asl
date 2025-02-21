state("KingdomCome", "1.1.1")
{
	bool load : "WHGame.DLL", 0x53D9ED8, 0x60; //1 or 0
	bool fade : "WHGame.DLL", 0x5281120, 0xF48, 0x108, 0x18; //1 or 0
	bool fasttime : "WHGame.DLL", 0x52A3098; //0xFFFFFFFF or 0
}

state("KingdomCome", "1.1.2")
{
	bool load : "WHGame.DLL", 0x520910C; //1 or 0
	bool fade : "WHGame.DLL", 0x52833A0, 0xF48, 0x108, 0x18; //1 or 0
	bool fasttime : "WHGame.DLL", 0x52A5318; //0xFFFFFFFF or 0
}

init
{
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
}

isLoading
{
	return current.load || current.fade || current.fasttime;
}