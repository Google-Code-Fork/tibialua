#include "tibialua_register.h"

// register windows glue
void tibialua_register_windows_glue(lua_State *L)
{
    lua_register(L, "windows_messagebox", l_windows_messagebox);
}

// register tibia glue
void tibialua_register_tibia_glue(lua_State *L)
{
    lua_register(L, "tibia_writebytes", l_tibia_writebytes);
    lua_register(L, "tibia_writedouble", l_tibia_writedouble);
    lua_register(L, "tibia_writestring", l_tibia_writestring);
    lua_register(L, "tibia_writenops", l_tibia_writenops);
    lua_register(L, "tibia_readbytes", l_tibia_readbytes);
    lua_register(L, "tibia_readstring", l_tibia_readstring);
}
