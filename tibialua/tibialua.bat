REM http://www.mingw.org/
windres tibialua.rc resource.o
g++ tibialua.cpp tibialua_windows.cpp tibialua_windows_glue.cpp tibialua_tibia.cpp tibialua_tibia_glue.cpp tibialua_register.cpp "c:\code\tinyxml253\tinyxml\tinyxml.cpp" "c:\code\tinyxml253\tinyxml\tinyxmlerror.cpp" "c:\code\tinyxml253\tinyxml\tinyxmlparser.cpp" "c:\code\tinyxml253\tinyxml\tinystr.cpp" -I"c:\code\tinyxml253\tinyxml" -I"c:\code\lua514\include" -L"c:\code\lua514\lib" -llua5.1 -lkernel32 -luser32 -lgdi32 -lshell32 -Wl,-subsystem,windows -Wall -O2 -s -o release\tibialua.exe resource.o
DEL resource.o
PAUSE
