REM http://www.mingw.org/
windres tibialua.rc resource.o
g++ tibialua_test.cpp tibialua_windows.cpp tibialua_windows_glue.cpp tibialua_tibia.cpp tibialua_tibia_glue.cpp tibialua_register.cpp -I"c:\code\lua514\include" -I"c:\code\iup3b2\include" -L"c:\code\lua514\lib" -L"c:\code\iup3b2\lib" -llua5.1 -liuplua51 -liup -lkernel32 -luser32 -lgdi32 -lshell32 -lcomctl32 -lcomdlg32 -lole32 -Wl,-subsystem,console -Wall -O2 -s -o release\tibialua_test.exe resource.o
DEL "c:\code\tibialua\tibialua\resource.o"
PAUSE
