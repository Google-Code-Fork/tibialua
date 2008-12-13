/*
 * Tibia Lua Console
 * by Evremonde
 * Last updated on 12/10/2008
 */

#include "tibialua_console.h"

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        MessageBox(0,
            "Usage: tibialua_console.exe script\nExample: tibialua_console.exe helloworld.lua",
            "Error", MB_OK | MB_ICONERROR);
        return 0;
    }

    // open lua
    L = luaL_newstate();

    // open lua libraries
    luaL_openlibs(L);

    // register windows glue
    tibialua_register_windows_glue(L);

    // register tibia glue
    tibialua_register_tibia_glue(L);

    // initialize tibia api
    luaL_dofile(L, "system/tibia_addresses.lua");
    luaL_dofile(L, "system/tibia_constants.lua");
    luaL_dofile(L, "system/tibia_functions.lua");

    // execute user config script
    luaL_dofile(L, "system/autoexec.lua");

    // get script name
    char script[256];
    strcpy(script, "scripts/");
    strcat(script, argv[1]);

    // execute script
    luaL_dofile(L, script);

    // close lua
    lua_close(L);
}
