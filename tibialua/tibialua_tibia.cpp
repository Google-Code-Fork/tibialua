#include "tibialua_tibia.h"

// get window
HWND tibia_getwindow()
    { return FindWindow("tibiaclient", 0); }

// get process id
DWORD tibia_getprocessid()
{
    // get tibia window
    HWND tibiaWindow = tibia_getwindow();

    // get process id
    DWORD processId;
    GetWindowThreadProcessId(tibiaWindow, &processId);

    return processId;
}

// get process handle
HANDLE tibia_getprocesshandle()
{
    // get process id
    DWORD processId = tibia_getprocessid();

    // get process handle
    HANDLE processHandle = OpenProcess(PROCESS_ALL_ACCESS, 0, processId);

    return processHandle;
}

// write bytes to memory
void tibia_writebytes(DWORD address, int value, int bytes)
{
    // get process handle
    HANDLE processHandle = tibia_getprocesshandle();

    // write to memory
    WriteProcessMemory(processHandle, (LPVOID)address, &value, bytes, 0);

    // close process handle
    CloseHandle(processHandle);
}

// write double to memory
void tibia_writedouble(DWORD address, double value)
{
    // get process handle
    HANDLE processHandle = tibia_getprocesshandle();

    // write to memory
    WriteProcessMemory(processHandle, (LPVOID)address, &value, sizeof(value), 0);

    // close process handle
    CloseHandle(processHandle);
}

// write string to memory
void tibia_writestring(DWORD address, char* text)
{
    // get process handle
    HANDLE processHandle = tibia_getprocesshandle();

    // write to memory
    WriteProcessMemory(processHandle, (LPVOID)address, text, strlen(text) + 1, 0);

    // close process handle
    CloseHandle(processHandle);
}

// write NOPs to memory
void tibia_writenops(DWORD address, int nops)
{
    // get process handle
    HANDLE processHandle = tibia_getprocesshandle();

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
int tibia_readbytes(DWORD address, int bytes)
{
    // get process handle
    HANDLE processHandle = tibia_getprocesshandle();

    // read from memory
    int buffer = 0;
    ReadProcessMemory(processHandle, (LPVOID)address, &buffer, bytes, 0);

    // close process handle
    CloseHandle(processHandle);

    return buffer;
}

// read string from memory
char* tibia_readstring(DWORD address)
{
    // get process handle
    HANDLE processHandle = tibia_getprocesshandle();

    // read from memory
    static char buffer[256];
    ReadProcessMemory(processHandle, (LPVOID)address, &buffer, sizeof(buffer), 0);

    // close process handle
    CloseHandle(processHandle);

    return buffer;
}
