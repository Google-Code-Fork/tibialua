/*
 * Tibia Lua Test
 * by Evremonde
 * Last updated on 12/10/2008
 */

#include "tibialua_test.h"

int main()
{
    // open lua
    L = luaL_newstate();

    // open lua libraries
    luaL_openlibs(L);

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

    // close lua
    lua_close(L);

    std::cin.get();

    return 0;
}
