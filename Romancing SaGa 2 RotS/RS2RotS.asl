state("Romancing SaGa 2 RotS-Win64")
{
	bool load : "Romancing SaGa 2 RotS-Win64.exe", 0x5CFBBF0, 0x58, 0x198, 0xF0, 0x5A8, 0x100;
	byte load2 : "Romancing SaGa 2 RotS-Win64.exe", 0x57EFB20, 0x2A8, 0x230, 0x708, 0, 0x50, 0x288;
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
	return current.load || current.load2 == 1;
}