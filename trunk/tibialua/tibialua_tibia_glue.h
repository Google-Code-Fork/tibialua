#ifndef _TIBIALUA_TIBIA_GLUE_H_
#define _TIBIALUA_TIBIA_GLUE_H_

#include <windows.h>

#include "tibialua_lua.h"

#include "tibialua_tibia.h"

int l_tibia_writebytes(lua_State *L);
int l_tibia_writedouble(lua_State *L);
int l_tibia_writestring(lua_State *L);
int l_tibia_writenops(lua_State *L);
int l_tibia_readbytes(lua_State *L);
int l_tibia_readstring(lua_State *L);

#endif // _TIBIALUA_TIBIA_GLUE_H_
