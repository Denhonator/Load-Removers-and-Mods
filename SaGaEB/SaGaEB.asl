state("SaGaEmeraldBeyond")
{
	bool load : "GameAssembly.dll", 0x02D6B7F8, 0x728, 0x168, 0xB8, 0x78, 0x60, 0xC8, 0x30;
}

startup
{
	timer.IsGameTimePaused = false;
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
	return !current.load;
}
