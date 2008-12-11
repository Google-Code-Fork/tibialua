#include "tibialua_windows_glue.h"

int l_windows_messagebox(lua_State *L)
{
    const char* text = luaL_checkstring(L, 1);
    const char* title = luaL_optstring(L, 2, "Tibia Lua");

    MessageBox(0, text, title, MB_OK);

    return 0;
}
