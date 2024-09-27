state("ffxvi")
{
	uint load : "ffxvi.exe", 0x27429F8, 0x88, 0xD60, 0x78, 0x130;
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