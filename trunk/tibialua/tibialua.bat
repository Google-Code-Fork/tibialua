REM http://www.mingw.org/
"c:\mingw\bin\windres.exe" "c:\code\tibialua\tibialua\tibialua.rc" "c:\code\tibialua\tibialua\resource.o"
"c:\mingw\bin\g++.exe" "c:\code\tibialua\tibialua\tibialua.cpp" "c:\code\tibialua\tibialua\tibialua_windows.cpp" "c:\code\tibialua\tibialua\tibialua_windows_glue.cpp" "c:\code\tibialua\tibialua\tibialua_tibia.cpp" "c:\code\tibialua\tibialua\tibialua_tibia_glue.cpp" "c:\code\tibialua\tibialua\tibialua_register.cpp" "c:\code\tinyxml253\tinyxml\tinyxml.cpp" "c:\code\tinyxml253\tinyxml\tinyxmlerror.cpp" "c:\code\tinyxml253\tinyxml\tinyxmlparser.cpp" "c:\code\tinyxml253\tinyxml\tinystr.cpp" -I"c:\code\tibialua" -I"c:\code\tinyxml253\tinyxml" -I"c:\code\lua514\include" -L"c:\code\lua514\lib" -llua5.1 -lkernel32 -luser32 -lgdi32 -lshell32 -Wl,-subsystem,windows -Wall -O2 -s -o "c:\code\tibialua\tibialua\release\tibialua.exe" "c:\code\tibialua\tibialua\resource.o"
DEL "c:\code\tibialua\tibialua\resource.o"
PAUSE
