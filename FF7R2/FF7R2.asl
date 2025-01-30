state("ff7rebirth_", "EGS")
{
	//bool load : "ff7rebirth_.exe", 0x9218238; //1 when loading save or skipping scene
	//bool load2 : "ff7rebirth_.exe", 0x8F925D4;
	bool load3 : "ff7rebirth_.exe", 0x091C5018, 0x68; //1, 4 when not load, 3, 3 when load (4 byte)
	//bool load4 : "ff7rebirth_.exe", 0x92181C4;
	int black : "ff7rebirth_.exe", 0x91C4FA0, 0x10, 0xE8, 0x98, 8; //7 on non-load black screen, 13 on loads, 1 during gameplay
	bool menu : "ff7rebirth_.exe", 0x905E324; //1 when paused
	bool canskip : "ff7rebirth_.exe", 0x905E320; //1 when current cutscene can be skipped
}

state("ff7rebirth_", "Steam")
{
	//bool load : "ff7rebirth_.exe", 0x900168C;
	//bool load2 : "ff7rebirth_.exe", 0x8F925D4;
	bool load3 : "ff7rebirth_.exe", 0x0924D038, 0x68;
	int black : "ff7rebirth_.exe", 0x924CFC0, 0x10, 0xE8, 0x98, 8;
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
	// if(old.black==13 && current.black<13)
		// vars.zackload = true;
	// else if(old.black==7 && current.black!=7)
		// vars.zackload = false;
	return (current.black > 2 && current.black != 7 && !(current.menu||current.canskip||vars.zackload))
		|| current.load3;
}