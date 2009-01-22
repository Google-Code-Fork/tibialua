REM http://www.mingw.org/
windres tibialua.rc resource.o
g++ tibialua.cpp tibialua_windows.cpp tibialua_windows_glue.cpp tibialua_tibia.cpp tibialua_tibia_glue.cpp tibialua_register.cpp "c:\code\tinyxml253\tinyxml\tinyxml.cpp" "c:\code\tinyxml253\tinyxml\tinyxmlerror.cpp" "c:\code\tinyxml253\tinyxml\tinyxmlparser.cpp" "c:\code\tinyxml253\tinyxml\tinystr.cpp" -I"c:\code\tinyxml253\tinyxml" -I"c:\code\lua514\include" -I"c:\code\iup3b2\include" -L"c:\code\lua514\lib" -L"c:\code\iup3b2\lib" -llua5.1 -liuplua51 -liup -lkernel32 -luser32 -lgdi32 -lshell32 -lcomctl32 -lcomdlg32 -lole32 -Wl,-subsystem,windows -Wall -O2 -s -o release\tibialua.exe resource.o
DEL resource.o
PAUSE
