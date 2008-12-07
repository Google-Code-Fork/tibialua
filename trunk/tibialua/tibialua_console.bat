REM http://www.mingw.org/
"c:\mingw\bin\windres.exe" "c:\code\tibialua\tibialua.rc" "c:\code\tibialua\resource.o"
"c:\mingw\bin\g++.exe" "c:\code\tibialua\tibialua_console.cpp" "c:\code\tibialua\tibialua_windows.cpp" "c:\code\tibialua\tibialua_windows_glue.cpp" "c:\code\tibialua\tibialua_tibia.cpp" "c:\code\tibialua\tibialua_tibia_glue.cpp" "c:\code\tibialua\tibialua_register.cpp" -I"c:\code\tibialua" -I"c:\code\lua514\include" -L"c:\code\lua514\lib" -llua5.1 -lkernel32 -luser32 -lgdi32 -lshell32 -Wl,-subsystem,windows -Wall -O2 -s -o "c:\code\tibialua\release\tibialua_console.exe" "c:\code\tibialua\resource.o"
DEL "c:\code\tibialua\resource.o"
PAUSE
