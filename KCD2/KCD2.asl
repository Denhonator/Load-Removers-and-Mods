state("KingdomCome", "1.1.1")
{
	bool load : "WHGame.DLL", 0x53D9ED8, 0x60;
	bool fade : "WHGame.DLL", 0x5281120, 0xF48, 0x108, 0x18;
	bool fasttime : "WHGame.DLL", 0x52A3098;
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
	return current.load || current.fade || current.fasttime;
}