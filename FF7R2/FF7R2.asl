state("ff7rebirth_")
{
	bool load : "ff7rebirth_.exe", 0x9218238;
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
	return current.load;
}