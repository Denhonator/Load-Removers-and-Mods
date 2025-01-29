state("ff7rebirth_", "EGS")
{
	bool load : "ff7rebirth_.exe", 0x9218238;
	bool load2 : "ff7rebirth_.exe", 0x8F925D4;
	bool load3 : "ff7rebirth_.exe", 0x091C5018, 0x68;
	//bool load4 : "ff7rebirth_.exe", 0x92181C4;
	int black : "ff7rebirth_.exe", 0x91E1F98, 0x12A8, 0x48, 8;
	bool menu : "ff7rebirth_.exe", 0x905E324;
	bool canskip : "ff7rebirth_.exe", 0x905E320;
}

state("ff7rebirth_", "Steam")
{
	bool load : "ff7rebirth_.exe", 0x900168C;
	bool load2 : "ff7rebirth_.exe", 0x8F925D4;
	bool load3 : "ff7rebirth_.exe", 0x091C5018, 0x68;
	int black : "ff7rebirth_.exe", 0x0926A2D8, 0x12A8, 0x48, 8;
	bool menu : "ff7rebirth_.exe", 0x87DEC9C;
	bool canskip : "ff7rebirth_.exe", 0x87DEC98;
}

startup
{
	vars.zackload = false;
}

init
{
	timer.IsGameTimePaused = false;
	
	print(modules.First().ModuleMemorySize.ToString());
	if (modules.First().ModuleMemorySize == 162217984)
		version = "Steam";
	else //161636352
		version = "EGS";
}

exit
{
	timer.IsGameTimePaused = true;
}

isLoading
{
	if(old.black==13 && current.black<13)
		vars.zackload = true;
	else if(current.black < 2)
		vars.zackload = false;
	return (current.black > 2 && !(current.menu||current.canskip||vars.zackload))
		|| (version=="EGS" && (current.load||current.load2||current.load3));
}