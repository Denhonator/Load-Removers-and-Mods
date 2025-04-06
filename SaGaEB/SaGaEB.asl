state("SaGaEmeraldBeyond")
{
	bool load : "GameAssembly.dll", 0x02D6B7F8, 0x728, 0x168, 0xB8, 0x78, 0x60, 0xC8, 0x30;
	bool fade : "GameAssembly.dll", 0x02D6B7F8, 0x728, 0x168, 0xB8, 0x78, 0x60, 0xB8, 0x30;
	bool fadecolor : "GameAssembly.dll", 0x02D6B7F8, 0x728, 0x168, 0xB8, 0x78, 0x60, 0xB8, 0x78;
	byte decideState : "GameAssembly.dll", 0x02D9D4F0, 0xB8, 0x28, 0x10, 0x38, 0x70, 0xC8, 0x18, 0xA0;
	int scriptLine : "GameAssembly.dll", 0x2DCBDA0, 0x20, 0x90, 0x338, 0x50, 0xB8, 0x20, 0x28;
}

startup
{
	timer.IsGameTimePaused = false;
}

init
{
	timer.IsGameTimePaused = false;
	vars.cutsceneLoad = 0;
}

exit
{
	timer.IsGameTimePaused = true;
}

isLoading
{
	if(current.decideState!=1 && old.decideState==1)
		vars.cutsceneLoad = 120;
	else if(current.decideState==1||current.scriptLine!=old.scriptLine)
		vars.cutsceneLoad = 0;
	else if(vars.cutsceneLoad>0)
		vars.cutsceneLoad -= 1;
	return !current.load||(!current.fade&&!current.fadecolor)||vars.cutsceneLoad>0;
}
