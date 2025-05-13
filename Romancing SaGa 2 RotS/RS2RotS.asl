state("Romancing SaGa 2 RotS-Win64", "101")
{
	bool load : "Romancing SaGa 2 RotS-Win64.exe", 0x5CFBBF0, 0x58, 0x198, 0xF0, 0x5A8, 0x100;
	byte load2 : "Romancing SaGa 2 RotS-Win64.exe", 0x57EFB20, 0x2A8, 0x230, 0x708, 0, 0x50, 0x288;
}

state("Romancing SaGa 2 RotS-Win64", "102")
{
	bool load : "Romancing SaGa 2 RotS-Win64.exe", 0x5A65BB8, 0xA8, 0x180, 0xF0, 0x5A8, 0x100;
	byte load2 : "Romancing SaGa 2 RotS-Win64.exe", 0x5A65BB8, 0xA8, 0x30, 0xA8, 0x78, 0x288;
}

state("Romancing SaGa 2 RotS-Win64", "103")
{
	bool load : "Romancing SaGa 2 RotS-Win64.exe", 0x5A65BB8, 0xA8, 0x180, 0xF0, 0x5A8, 0x100;
	byte load2 : "Romancing SaGa 2 RotS-Win64.exe", 0x5A65BB8, 0xA8, 0x30, 0xA8, 0x78, 0x288;
}

startup
{
	vars.crash = false;
}

update
{
	if (current.load)
		vars.crash = false;
}


init
{
	timer.IsGameTimePaused = false;
	
	print(modules.First().ModuleMemorySize.ToString());
	if (modules.First().ModuleMemorySize == 104296448)
		version = "103";
	else if (modules.First().ModuleMemorySize == 588587008)
		version = "102";
	else //629063680
		version = "101";
}

exit
{
	timer.IsGameTimePaused = true;
	vars.crash = true;
}

isLoading
{
	return current.load || current.load2 == 1 || vars.crash;
}
