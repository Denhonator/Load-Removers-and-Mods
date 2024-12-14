state("Romancing SaGa 2 RotS-Win64", "101")
{
	bool load : "Romancing SaGa 2 RotS-Win64.exe", 0x5CFBBF0, 0x58, 0x198, 0xF0, 0x5A8, 0x100;
	byte load2 : "Romancing SaGa 2 RotS-Win64.exe", 0x57EFB20, 0x2A8, 0x230, 0x708, 0, 0x50, 0x288;
}

state("Romancing SaGa 2 RotS-Win64", "102")
{
	bool load : "Romancing SaGa 2 RotS-Win64.exe", 0x5CF2D70, 0x70, 0x80, 0xF0, 0x5A8, 0x100;
	byte load2 : "Romancing SaGa 2 RotS-Win64.exe", 0x5CF2D70, 0x6B0, 0x28, 0x2B0, 0x748, 0, 0x288;
}


init
{
	timer.IsGameTimePaused = false;
	
	//print(modules.First().ModuleMemorySize.ToString());
	if (modules.First().ModuleMemorySize == 588587008)
		version = "102";
	else //629063680
		version = "101";
}

exit
{
	timer.IsGameTimePaused = true;
}

isLoading
{
	return current.load || current.load2 == 1;
}