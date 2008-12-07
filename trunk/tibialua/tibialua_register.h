#ifndef _TIBIALUA_REGISTER_H_
#define _TIBIALUA_REGISTER_H_

#include "tibialua_lua.h"

#include "tibialua_windows_glue.h"
#include "tibialua_tibia_glue.h"

void tibialua_register_windows_glue(lua_State *L);

void tibialua_register_tibia_glue(lua_State *L);

#endif // _TIBIALUA_REGISTER_H_

