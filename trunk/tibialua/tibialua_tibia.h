#ifndef _TIBIALUA_TIBIA_H_
#define _TIBIALUA_TIBIA_H_

#include <windows.h>

HWND tibia_getwindow();
DWORD tibia_getprocessid();
HANDLE tibia_getprocesshandle();
void tibia_writebytes(DWORD address, int value, int bytes);
void tibia_writedouble(DWORD address, double value);
void tibia_writestring(DWORD address, char* text);
void tibia_writenops(DWORD address, int nops);
int tibia_readbytes(DWORD address, int bytes);
char* tibia_readstring(DWORD address);

#endif // _TIBIALUA_TIBIA_H_
