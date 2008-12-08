#ifndef _TIBIALUA_TIBIA_GLUE_H_
#define _TIBIALUA_TIBIA_GLUE_H_

#include <windows.h>

#include "tibialua_lua.h"

#include "tibialua_tibia.h"

int l_writeBytes(lua_State *L);
int l_writeDouble(lua_State *L);
int l_writeString(lua_State *L);
int l_writeNops(lua_State *L);
int l_readBytes(lua_State *L);
int l_readString(lua_State *L);

#endif // _TIBIALUA_TIBIA_GLUE_H_
