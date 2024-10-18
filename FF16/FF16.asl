state("ffxvi")
{
	uint load : "ffxvi.exe", 0x2743DC8, 0x88, 0xD60, 0x78, 0x130;
}

state("ffxvi_demo")
{
	uint load : "ffxvi_demo.exe", 0x26DF570, 0x88, 0xD60, 0x78, 0x130;
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