state("Romancing SaGa 2 RotS Demo-Win64")
{
	bool load : "Romancing SaGa 2 RotS Demo-Win64.exe", 0x58324E8, 0x350, 0x28, 0x10, 0x590, 0x100;
	byte load2 : "Romancing SaGa 2 RotS Demo-Win64.exe", 0x5B9EF80, 0x27F0, 0x140, 0x640, 0x20, 0x50, 0x2F0;
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