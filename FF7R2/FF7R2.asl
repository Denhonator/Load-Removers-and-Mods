state("ff7rebirth_", "EGS1")
{
	bool load5 : "ff7rebirth_.exe", 0x91BAFB0; //3 during loads
	bool load3 : "ff7rebirth_.exe", 0x8F79868, 0x218, 0x5D0; //1 for fast travel loads (16xFF at +50)
	int black : "ff7rebirth_.exe", 0x9216638, 0x10, 0x1B8, 0x90, 8, 8; //7 on non-load black screen, 13 on loads, 1 during gameplay
	bool menu : "ff7rebirth_.exe", 0x905E324; //1 when paused
	bool canskip : "ff7rebirth_.exe", 0x905E320; //1 when current cutscene can be skipped
}

state("ff7rebirth_", "Steam1")
{
	bool load5 : "ff7rebirth_.exe", 0x92428C0;
	bool load3 : "ff7rebirth_.exe", 0x9001588, 0x218, 0x5D0;
	int black : "ff7rebirth_.exe", 0x929E808, 0x10, 0x1B8, 0x90, 8, 8;
	bool menu : "ff7rebirth_.exe", 0x87DEC9C;
	bool canskip : "ff7rebirth_.exe", 0x87DEC98;
}

state("ff7rebirth_", "EGS2")
{
	bool load5 : "ff7rebirth_.exe", 0x91C3FE0; //3 during loads
	bool load3 : "ff7rebirth_.exe", 0x8F82868, 0x218, 0x5D0; //1 for fast travel loads (16xFF at +50)
	int black : "ff7rebirth_.exe", 0x921F668, 0x10, 0x1B8, 0x90, 8, 8; //7 on non-load black screen, 13 on loads, 1 during gameplay
	bool menu : "ff7rebirth_.exe", 0x9067324; //1 when paused
	bool canskip : "ff7rebirth_.exe", 0x9067320; //1 when current cutscene can be skipped
}

state("ff7rebirth_", "Steam2")
{
	bool load5 : "ff7rebirth_.exe", 0x9212860;
	bool load3 : "ff7rebirth_.exe", 0x8FD1508, 0x218, 0x5D0;
	int black : "ff7rebirth_.exe", 0x926E798, 0x10, 0x1B8, 0x90, 8, 8;
	bool menu : "ff7rebirth_.exe", 0x87AEC1C;
	bool canskip : "ff7rebirth_.exe", 0x87AEC18;
}

state("ff7rebirth_", "EGS3")
{
	bool load5 : "ff7rebirth_.exe", 0x91BFFF8; //3 during loads
	bool load3 : "ff7rebirth_.exe", 0x8F7E8A8, 0x218, 0x5D0; //1 for fast travel loads (16xFF at +50)
	int black : "ff7rebirth_.exe", 0x921B708, 0x10, 0x1B8, 0x90, 8, 8; //7 on non-load black screen, 13 on loads, 1 during gameplay
	bool menu : "ff7rebirth_.exe", 0x9063324; //1 when paused
	bool canskip : "ff7rebirth_.exe", 0x9063320; //1 when current cutscene can be skipped
}

state("ff7rebirth_", "Steam3")
{
	bool load5 : "ff7rebirth_.exe", 0x9211820;
	bool load3 : "ff7rebirth_.exe", 0x8FD0548, 0x218, 0x5D0;
	int black : "ff7rebirth_.exe", 0x926D7E8, 0x10, 0x1B8, 0x90, 8, 8;
	bool menu : "ff7rebirth_.exe", 0x87ADC5C;
	bool canskip : "ff7rebirth_.exe", 0x87ADC58;
}

startup
{
	vars.zackload = false;
	vars.blackcounter = 0;
	refreshRate = 60;
}

init
{
	timer.IsGameTimePaused = false;
	
	print(modules.First().ModuleMemorySize.ToString());
	if (modules.First().ModuleMemorySize == 161656832)
		version = "EGS3";
	else if (modules.First().ModuleMemorySize == 161996800)
		version = "Steam3";
	else if (modules.First().ModuleMemorySize == 161677312)
		version = "EGS2";
	else if (modules.First().ModuleMemorySize == 162000896)
		version = "Steam2";
	else if (modules.First().ModuleMemorySize == 162217984)
		version = "Steam1";
	else if (modules.First().ModuleMemorySize == 161636352)
		version = "EGS1";
}

exit
{
	timer.IsGameTimePaused = true;
}

isLoading
{
	if(old.black==13 && current.black!=13)
		vars.zackload = true;
	//print("Black: " + current.black.ToString() + " Black2: " + current.black2.ToString() + " Black3: " + current.black3.ToString());
	if(current.black==7 && !current.menu)
		vars.blackcounter += vars.zackload ? 60 : 1;
	else if((current.black==1 || current.black==13) && !current.menu){
		vars.blackcounter = 0;
		vars.zackload = false;
	}
	return (current.black > 2 && ((current.black!=7||vars.blackcounter>=60)) && !(current.menu||current.canskip))
		|| current.load3 || current.load5 || current.black==13;
}