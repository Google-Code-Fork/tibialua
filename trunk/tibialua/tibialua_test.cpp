/*
 * Tibia Lua Test
 * by Evremonde
 * Last updated on 12/10/2008
 */

#include "tibialua_test.h"

int main()
{
    // open iup
    IupOpen(0, 0);

    // open lua
    L = luaL_newstate();

    // open lua libraries
    luaL_openlibs(L);

    // open iup lua
    iuplua_open(L);

    // register windows glue
    tibialua_register_windows_glue(L);

    // register tibia glue
    tibialua_register_tibia_glue(L);

    // initialize tibia api
    int error = luaL_dofile(L, "system/tibia.lua");

    // display error
    if (error)
    {
        std::cout << lua_tostring(L, -1) << std::endl;
        lua_pop(L, 1);
    }

    // execute user config script
    luaL_dofile(L, "system/autoexec.lua");

    // execute test script
    luaL_dofile(L, "tibialua_test.lua");

    // start iup
    //IupMainLoop();

    // close lua
    lua_close(L);

    // close iup
    IupClose();

    std::cin.get();

    return 0;
}
