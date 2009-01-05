#ifndef _TIBIALUA_H_
#define _TIBIALUA_H_

#include <ctime>

#include <fstream>
#include <sstream>
#include <string>
#include <vector>

#include <windows.h>
#include <shellapi.h>

#include "tibialua_xml.h"

#include "tibialua_lua.h"

#include "tibialua_register.h"

#include "resource.h"

/* defines */

// window dimensions
#define WINDOW_HEIGHT 320
#define WINDOW_WIDTH  240

// tray notification message
#define WM_SHELLNOTIFY WM_USER+5

/* ids */

// tray icon
#define ID_TRAY_ICON 101

// tray menu
#define ID_TRAY_MENU_NULL     1001
#define ID_TRAY_MENU_HOTKEYS  1002
#define ID_TRAY_MENU_ABOUT    1003
#define ID_TRAY_MENU_HOMEPAGE 1004
#define ID_TRAY_MENU_EXIT     1005

// tray menus
#define ID_TRAY_MENUS_BEGIN 1100

// timers
#define ID_TIMERS_BEGIN 10000

// hotkeys
#define ID_HOTKEYS_BEGIN 100000

/* globals */

// lua state
lua_State *L;

// tibia lua script
typedef struct
{
    int id;
    bool timerIsEnabled;

    std::string fileName;
    std::string name;
    int hotkeyId;
    std::string hotkeyName;
    int timerDelay;
    int timerStartEnabled;
    int menuVisible;
} TibiaLuaScript;

// scripts vector
std::vector<TibiaLuaScript> vectorScripts;
std::vector<TibiaLuaScript>::iterator vectorScriptsIt;

// tray icon
NOTIFYICONDATA trayIcon;

// tray menu
HMENU trayMenu;

/* booleans */

// hotkeys
bool bHotkeys = true;

#endif // _TIBIALUA_H_
