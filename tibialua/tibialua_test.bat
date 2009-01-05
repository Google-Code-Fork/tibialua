REM http://www.mingw.org/
windres tibialua.rc resource.o
g++ tibialua_console.cpp tibialua_windows.cpp tibialua_windows_glue.cpp tibialua_tibia.cpp tibialua_tibia_glue.cpp tibialua_register.cpp -I"c:\code\lua514\include" -L"c:\code\lua514\lib" -llua5.1 -lkernel32 -luser32 -lgdi32 -lshell32 -Wl,-subsystem,windows -Wall -O2 -s -o release\tibialua_console.exe resource.o
DEL "c:\code\tibialua\tibialua\resource.o"
PAUSE
