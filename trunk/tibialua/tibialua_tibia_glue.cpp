#include "tibialua_tibia_glue.h"

// writeBytes
int l_writeBytes(lua_State *L)
{
	const int address = luaL_checkinteger(L, 1);
	const int value = luaL_checkinteger(L, 2);
	const int bytes = luaL_checkinteger(L, 3);

	writeBytes(address, value, bytes);

	return 0;
}

// writeDouble
int l_writeDouble(lua_State *L)
{
	const int address = luaL_checkinteger(L, 1);
	const float value = luaL_checknumber(L, 2);

	writeDouble(address, value);

	return 0;
}

// writeString
int l_writeString(lua_State *L)
{
	const int address = luaL_checkinteger(L, 1);
	const char* text = luaL_checkstring(L, 2);

	writeString(address, (char*)text);

	return 0;
}

// writeNops
int l_writeNops(lua_State *L)
{
	const int address = luaL_checkinteger(L, 1);
	const int nops = luaL_checkinteger(L, 2);

	writeNops(address, nops);

	return 0;
}

// readBytes
int l_readBytes(lua_State *L)
{
	const int address = luaL_checkinteger(L, 1);
	const int bytes = luaL_checkinteger(L, 2);

	int result = readBytes(address, bytes);

	lua_pushinteger(L, result);

	return 1;
}

// readString
int l_readString(lua_State *L)
{
	const int address = luaL_checkinteger(L, 1);
	
	char* result = readString(address);

	lua_pushstring(L, result);

	return 1;
}
