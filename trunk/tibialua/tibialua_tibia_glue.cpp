#include "tibialua_tibia_glue.h"

int l_tibia_writebytes(lua_State *L)
{
    const int address = luaL_checkinteger(L, 1);
    const int value = luaL_checkinteger(L, 2);
    const int bytes = luaL_checkinteger(L, 3);

    tibia_writebytes(address, value, bytes);

    return 0;
}

int l_tibia_writedouble(lua_State *L)
{
    const int address = luaL_checkinteger(L, 1);
    const float value = luaL_checknumber(L, 2);

    tibia_writedouble(address, value);

    return 0;
}

int l_tibia_writestring(lua_State *L)
{
    const int address = luaL_checkinteger(L, 1);
    const char* text = luaL_checkstring(L, 2);

    tibia_writestring(address, (char*)text);

    return 0;
}

int l_tibia_writenops(lua_State *L)
{
    const int address = luaL_checkinteger(L, 1);
    const int nops = luaL_checkinteger(L, 2);

    tibia_writenops(address, nops);

    return 0;
}

int l_tibia_readbytes(lua_State *L)
{
    const int address = luaL_checkinteger(L, 1);
    const int bytes = luaL_checkinteger(L, 2);

    int result = tibia_readbytes(address, bytes);

    lua_pushinteger(L, result);

    return 1;
}

int l_tibia_readstring(lua_State *L)
{
    const int address = luaL_checkinteger(L, 1);
    
    char* result = tibia_readstring(address);

    lua_pushstring(L, result);

    return 1;
}
