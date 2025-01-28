state("ff7rebirth_")
{
	bool load : "ff7rebirth_.exe", 0x9218238;
	bool load2 : "ff7rebirth_.exe", 0x8F925D4;
	bool loadskip : "ff7rebirth_.exe", 0x08F795C0, 0xA68, 0;
	bool load3 : "ff7rebirth_.exe", 0x091C5018, 0x68;
	int black : "ff7rebirth_.exe", 0x091C5018, 0x10;
	int black2 : "ff7rebirth_.exe", 0x091E1F98, 0x12A8, 0x48, 8;
	float fade : "ff7rebirth_.exe", 0x09217FC8, 0x30, 0x1F8, 0x2BC;
	bool menu : "ff7rebirth_.exe", 0x905E324;
	bool canskip : "ff7rebirth_.exe", 0x905E320;
}

startup
{
	vars.zackload = false;
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
	if(current.black==7 && old.black==13)
		vars.zackload = true;
	else if(current.black < 2)
		vars.zackload = false;
	return (current.black > 0 && current.black != 2 && !(current.menu|current.canskip|vars.zackload))
		|| current.load || current.load2 || current.load3;
	//return current.load || current.load2 || current.load3 || current.loadskip;
}