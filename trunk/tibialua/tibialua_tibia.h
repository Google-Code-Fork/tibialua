#ifndef _TIBIALUA_TIBIA_H_
#define _TIBIALUA_TIBIA_H_

#include <windows.h>

/* functions */

HWND getGameWindow();
HANDLE getGameProcessHandle();
void writeBytes(DWORD address, int value, int bytes);
void writeDouble(DWORD address, double value);
void writeString(DWORD address, char* text);
void writeNops(DWORD address, int nops);
int readBytes(DWORD address, int bytes);
char* readString(DWORD address);

#endif // _TIBIALUA_TIBIA_H_
