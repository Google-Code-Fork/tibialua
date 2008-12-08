#include "tibialua_register.h"

// register windows glue
void tibialua_register_windows_glue(lua_State *L)
{
	lua_register(L, "messageBox", l_messageBox);
}

// register tibia glue
void tibialua_register_tibia_glue(lua_State *L)
{
	lua_register(L, "writeBytes", l_writeBytes);
	lua_register(L, "writeDouble", l_writeDouble);
	lua_register(L, "writeString", l_writeString);
	lua_register(L, "writeNops", l_writeNops);
	lua_register(L, "readBytes", l_readBytes);
	lua_register(L, "readString", l_readString);
}
