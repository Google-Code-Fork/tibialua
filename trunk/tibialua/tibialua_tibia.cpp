#include "tibialua_tibia.h"

/* functions */

// get game window
HWND getGameWindow()
	{ return FindWindow("tibiaclient", 0); }

// get game process id
DWORD getGameProcessId()
{
	// get game window
	HWND gameWindow = getGameWindow();

	// get process id
	DWORD processId;
	GetWindowThreadProcessId(gameWindow, &processId);

	return processId;
}

// get game process handle
HANDLE getGameProcessHandle()
{
	// get process id
	DWORD processId = getGameProcessId();

	// get process handle
	HANDLE processHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, processId);

	return processHandle;
}

// write bytes to memory
void writeBytes(DWORD address, int value, int bytes)
{
	// get process handle
	HANDLE processHandle = getGameProcessHandle();

	// write to memory
	WriteProcessMemory(processHandle, (LPVOID)address, &value, bytes, 0);

	// close process handle
	CloseHandle(processHandle);
}

// write double to memory
void writeDouble(DWORD address, double value)
{
	// get process handle
	HANDLE processHandle = getGameProcessHandle();

	// write to memory
	WriteProcessMemory(processHandle, (LPVOID)address, &value, sizeof(value), 0);

	// close process handle
	CloseHandle(processHandle);
}

// write string to memory
void writeString(DWORD address, char* text)
{
	// get process handle
	HANDLE processHandle = getGameProcessHandle();

	// write to memory
	WriteProcessMemory(processHandle, (LPVOID)address, text, strlen(text) + 1, 0);

	// close process handle
	CloseHandle(processHandle);
}

// write NOPs to memory
void writeNops(DWORD address, int nops)
{
	// get process handle
	HANDLE processHandle = getGameProcessHandle();

	// write to memory
	int i, j = 0;
	for (i = 0; i < nops; i++)
	{
		unsigned char nop = 0x90;
		WriteProcessMemory(processHandle, (LPVOID)(address + j), &nop, 1, 0);
		j++; // increment address
	}

	// close process handle
	CloseHandle(processHandle);
}

// read bytes from memory
int readBytes(DWORD address, int bytes)
{
	// get process handle
	HANDLE processHandle = getGameProcessHandle();

	// read from memory
	int buffer = 0;
	ReadProcessMemory(processHandle, (LPVOID)address, &buffer, bytes, 0);

	// close process handle
	CloseHandle(processHandle);

	return buffer;
}

// read string from memory
char* readString(DWORD address)
{
	// get process handle
	HANDLE processHandle = getGameProcessHandle();

	// read from memory
	static char buffer[256];
	ReadProcessMemory(processHandle, (LPVOID)address, &buffer, sizeof(buffer), 0);

	// close process handle
	CloseHandle(processHandle);

	return buffer;
}
