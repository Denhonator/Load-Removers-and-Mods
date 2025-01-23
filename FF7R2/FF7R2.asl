state("ff7rebirth_")
{
	bool load : "ff7rebirth_.exe", 0x9218238;
	bool load2 : "ff7rebirth_.exe", 0x8F925D4;
	bool loadskip : "ff7rebirth_.exe", 0x08F795C0, 0xA68, 0;
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
	return current.load || current.load2 || current.loadskip;
}