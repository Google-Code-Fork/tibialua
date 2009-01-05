/*
 * Tibia Lua
 * by Evremonde
 * Last updated on 12/10/2008
 */

#include "tibialua.h"

/* functions */

// show about
void doShowAbout()
{
    MessageBox(0,
        "Tibia Lua\nby Evremonde\nLast updated on 12/10/2008\n\nHomepage:\nhttp://code.google.com/p/tibialua/",
        "About", MB_OK | MB_ICONINFORMATION);
}

// open homepage
void doOpenHomepage()
    { ShellExecute(0, 0, "http://code.google.com/p/tibialua/", 0, 0, SW_SHOW); }

// load scripts
void doScriptsLoad()
{
    // clear the scripts vector
    vectorScripts.clear();

    // declare xml file
    TiXmlDocument file("tibialua.xml");

    // load xml file
    if (!file.LoadFile())
        return;

    // prepare to parse xml file
    TiXmlHandle handleDoc(&file);

    // find scripts
    TiXmlHandle handleScripts = handleDoc.FirstChildElement("scripts");

    // find script
    TiXmlElement* elementScript = handleScripts.FirstChildElement("script").Element();

    // parse xml file
    int scriptId = 0;
    for (elementScript; elementScript; elementScript = elementScript->NextSiblingElement())
    {
        // tibia lua script
        TibiaLuaScript script;

        // get id
        script.id = scriptId;

        // get file name
        script.fileName = elementScript->Attribute("filename");

        // get name
        script.name = elementScript->Attribute("name");

        // find hotkey
        TiXmlHandle handleHotkey = TiXmlHandle(elementScript);
        TiXmlElement* elementHotkey = handleHotkey.FirstChildElement("hotkey").Element();

        // get hotkey id
        elementHotkey->QueryIntAttribute("id" , &script.hotkeyId);

        // get hotkey name
        script.hotkeyName = elementHotkey->Attribute("name");

        // find timer
        TiXmlHandle handleTimer = TiXmlHandle(elementScript);
        TiXmlElement* elementTimer = handleTimer.FirstChildElement("timer").Element();

        // get timer delay
        elementTimer->QueryIntAttribute("delay" , &script.timerDelay);

        // get timer start enabled
        elementTimer->QueryIntAttribute("startenabled" , &script.timerStartEnabled);

        // find menu
        TiXmlHandle handleMenu = TiXmlHandle(elementScript);
        TiXmlElement* elementMenu = handleMenu.FirstChildElement("menu").Element();

        // get menu visible
        elementMenu->QueryIntAttribute("visible" , &script.menuVisible);

        // add the script to the scripts vector
        vectorScripts.push_back(script);

        // next script id
        scriptId += 1;
    }
}

// execute script
void doScriptExecute(std::string fileName)
{
    // get script location
    std::string scriptLocation = "scripts/" + fileName;

    // execute script
    luaL_dofile(L, scriptLocation.c_str());
}

// register timers
void doTimersRegister(HWND hwnd)
{
    // register timers for the scripts in the scripts vector
    for(vectorScriptsIt = vectorScripts.begin(); vectorScriptsIt != vectorScripts.end(); vectorScriptsIt++)
    {
        // check timer
        if (vectorScriptsIt->timerDelay == 0)
        {
            vectorScriptsIt->timerIsEnabled = false;
            continue;
        }

        // check timer start enabled
        if (vectorScriptsIt->timerStartEnabled == 0)
        {
            vectorScriptsIt->timerIsEnabled = false;
            continue;
        }

        SetTimer(hwnd, ID_TIMERS_BEGIN + vectorScriptsIt->id, vectorScriptsIt->timerDelay, 0);
    }
}

// unregister timers
void doTimersUnregister(HWND hwnd)
{
    // unregister timers for the scripts in the scripts vector
    for(vectorScriptsIt = vectorScripts.begin(); vectorScriptsIt != vectorScripts.end(); vectorScriptsIt++)
        KillTimer(hwnd, ID_TIMERS_BEGIN + vectorScriptsIt->id);
}

// register hotkeys
void doHotkeysRegister(HWND hwnd)
{
    // register hotkeys for the scripts in the scripts vector
    for(vectorScriptsIt = vectorScripts.begin(); vectorScriptsIt != vectorScripts.end(); vectorScriptsIt++)
    {
        // check hotkey
        if (vectorScriptsIt->hotkeyId == 0)
            continue;

        RegisterHotKey(hwnd, ID_HOTKEYS_BEGIN + vectorScriptsIt->id, 0, vectorScriptsIt->hotkeyId);
    }
}

// unregister hotkeys
void doHotkeysUnregister(HWND hwnd)
{
    // unregister hotkeys for the scripts in the scripts vector
    for(vectorScriptsIt = vectorScripts.begin(); vectorScriptsIt != vectorScripts.end(); vectorScriptsIt++)
        UnregisterHotKey(hwnd, ID_HOTKEYS_BEGIN + vectorScriptsIt->id);
}

// toggle hotkeys
void doHotkeysToggle()
{
    // check if hotkeys are enabled
    if (bHotkeys == false)
    {
        // enable hotkeys
        bHotkeys = true;

        CheckMenuItem(trayMenu, ID_TRAY_MENU_HOTKEYS, MF_CHECKED);
    }
    else
    {
        // disable hotkeys
        bHotkeys = false;

        CheckMenuItem(trayMenu, ID_TRAY_MENU_HOTKEYS, MF_UNCHECKED);
    }
}

/* tray icon */

// create tray icon
void doTrayIconCreate(HWND hwnd)
{
    // initialize tray icon
    trayIcon.cbSize           = sizeof(NOTIFYICONDATA);
    trayIcon.hWnd             = hwnd;
    trayIcon.uID              = ID_TRAY_ICON;
    trayIcon.uFlags           = NIF_ICON | NIF_MESSAGE | NIF_TIP;
    trayIcon.uCallbackMessage = WM_SHELLNOTIFY;
    trayIcon.hIcon            = (HICON)LoadImage(GetModuleHandle(0), MAKEINTRESOURCE(ID_ICON_APPLICATION), IMAGE_ICON, GetSystemMetrics(SM_CXSMICON), GetSystemMetrics(SM_CXSMICON), LR_SHARED); //LoadIcon(0, IDI_WINLOGO);

    // set tray icon tip text
    strcpy(trayIcon.szTip, "Tibia Lua");

    // add tray icon
    Shell_NotifyIcon(NIM_ADD, &trayIcon);
}

/* tray menu */

void doTrayMenuAppendScripts(HMENU menu)
{
    // append the scripts in the scripts vector
    for(vectorScriptsIt = vectorScripts.begin(); vectorScriptsIt != vectorScripts.end(); vectorScriptsIt++)
    {
        // check for separator
        if (vectorScriptsIt->fileName == "separator")
        {
            // append separator to tray menu
            AppendMenu(menu, MF_SEPARATOR, 0, 0);
            continue;
        }

        // check menu visible
        if (vectorScriptsIt->menuVisible == 0)
            continue;

        // menu item text for the script
        std::stringstream menuItemText;
        menuItemText << vectorScriptsIt->name; // script name
        menuItemText << "\t";
        if (vectorScriptsIt->hotkeyId != 0) // check for hotkey
            if (vectorScriptsIt->hotkeyName.size())
                menuItemText << vectorScriptsIt->hotkeyName; // script hotkey name

        // append script to tray menu
        AppendMenu(menu, MF_STRING, ID_TRAY_MENUS_BEGIN + vectorScriptsIt->id, menuItemText.str().c_str());

        // check timer start enabled
        if (vectorScriptsIt->timerStartEnabled == 1)
        {
            // check tray menu item
            CheckMenuItem(menu, ID_TRAY_MENUS_BEGIN + vectorScriptsIt->id, MF_CHECKED);
        }
    }
}

// create tray menu
void doTrayMenuCreate(HWND hwnd)
{
    // create tray menu
    trayMenu = CreatePopupMenu();
    AppendMenu(trayMenu, MF_STRING, ID_TRAY_MENU_NULL,     "Tibia Lua");
    AppendMenu(trayMenu, MF_SEPARATOR, 0, 0);

    // append scripts to tray menu
    doTrayMenuAppendScripts(trayMenu);

    AppendMenu(trayMenu, MF_SEPARATOR, 0, 0);
    AppendMenu(trayMenu, MF_STRING, ID_TRAY_MENU_HOTKEYS,  "Hotkeys");
    AppendMenu(trayMenu, MF_SEPARATOR, 0, 0);
    AppendMenu(trayMenu, MF_STRING, ID_TRAY_MENU_ABOUT,    "About...");
    AppendMenu(trayMenu, MF_STRING, ID_TRAY_MENU_HOMEPAGE, "Homepage...");
    AppendMenu(trayMenu, MF_STRING, ID_TRAY_MENU_EXIT,     "Exit");

    // set default tray menu item
    SetMenuDefaultItem(trayMenu, ID_TRAY_MENU_NULL, MF_BYCOMMAND);

    // check tray menu items
    CheckMenuItem(trayMenu, ID_TRAY_MENU_HOTKEYS, MF_CHECKED);
}

// show tray menu
void doTrayMenuShow(HWND hwnd)
{
    // get menu location
    POINT trayMenuLocation;
    GetCursorPos(&trayMenuLocation);

    // required to make menu show and hide correctly
    SetForegroundWindow(hwnd);

    // show tray menu
    TrackPopupMenu(trayMenu,
        TPM_RIGHTALIGN | TPM_RIGHTBUTTON, // align right and allow right-click on menu items
        trayMenuLocation.x, trayMenuLocation.y,
        0, hwnd, 0);

    // required to make menu show and hide correctly
    PostMessage(hwnd, WM_NULL, 0, 0);
}

/* windows messages */

void onCreate(HWND hwnd)
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
    luaL_dofile(L, "system/tibia.lua");

    // execute open script
    luaL_dofile(L, "system/onopen.lua");

    // execute user config script
    luaL_dofile(L, "system/autoexec.lua");

    // load scripts
    doScriptsLoad();

    // register hotkeys
    doHotkeysRegister(hwnd);

    // register timers
    doTimersRegister(hwnd);

    // create tray icon
    doTrayIconCreate(hwnd);

    // create tray menu
    doTrayMenuCreate(hwnd);
}

void onDestroy(HWND hwnd)
{
    // execute close script
    luaL_dofile(L, "system/onclose.lua");

    // close lua
    lua_close(L);

    // unregister hotkeys
    doHotkeysUnregister(hwnd);

    // unregister timers
    doTimersUnregister(hwnd);

    // delete tray icon
    Shell_NotifyIcon(NIM_DELETE, &trayIcon);

    // destroy tray menu
    DestroyMenu(trayMenu);

    // exit
    PostQuitMessage(0);
}

void onTray(HWND hwnd, WPARAM wparam, LPARAM lparam)
{
    // tray icon
    if (wparam == ID_TRAY_ICON)
    {
        // left click or right click
        if (lparam == WM_LBUTTONDOWN || lparam == WM_RBUTTONDOWN)
        {
            // show tray menu
            doTrayMenuShow(hwnd);
        }
    }
}

void onTimer(HWND hwnd, WPARAM wparam, LPARAM lparam)
{
    // timers
    for(vectorScriptsIt = vectorScripts.begin(); vectorScriptsIt != vectorScripts.end(); vectorScriptsIt++)
    {
        // check hotkey id
        if (wparam == (unsigned int)ID_TIMERS_BEGIN + vectorScriptsIt->id)
        {
            // execute script
            doScriptExecute(vectorScriptsIt->fileName);
        }
    }
}

void onHotkey(HWND hwnd, WPARAM wparam, LPARAM lparam)
{
    // check if hotkeys are enabled
    if (bHotkeys == false)
        return;

    // restrict hotkeys to tibia and tibia lua by window focus
    HWND currentWindow = GetForegroundWindow();
    HWND tibiaWindow = tibia_getwindow();
    if (currentWindow != tibiaWindow && currentWindow != hwnd)
        return;

    // hotkeys
    for(vectorScriptsIt = vectorScripts.begin(); vectorScriptsIt != vectorScripts.end(); vectorScriptsIt++)
    {
        // check hotkey id
        if (wparam == (unsigned int)ID_HOTKEYS_BEGIN + vectorScriptsIt->id)
        {
            // execute script
            doScriptExecute(vectorScriptsIt->fileName);
        }
    }
}

void onCommand(HWND hwnd, int command, int notifycode, HWND hwnditem)
{
    // scripts
    for(vectorScriptsIt = vectorScripts.begin(); vectorScriptsIt != vectorScripts.end(); vectorScriptsIt++)
    {
        // check tray menu id
        if (command == ID_TRAY_MENUS_BEGIN + vectorScriptsIt->id)
        {
            // check timer
            if (vectorScriptsIt->timerDelay != 0)
            {
                // check timer is enabled
                if (vectorScriptsIt->timerIsEnabled == false)
                {
                    vectorScriptsIt->timerIsEnabled = true;

                    // check tray menu item
                    CheckMenuItem(trayMenu, ID_TRAY_MENUS_BEGIN + vectorScriptsIt->id, MF_CHECKED);

                    // start timer
                    SetTimer(hwnd, ID_TIMERS_BEGIN + vectorScriptsIt->id, vectorScriptsIt->timerDelay, 0);
                }
                else
                {
                    vectorScriptsIt->timerIsEnabled = false;

                    // uncheck tray menu item
                    CheckMenuItem(trayMenu, ID_TRAY_MENUS_BEGIN + vectorScriptsIt->id, MF_UNCHECKED);

                    // stop timer
                    KillTimer(hwnd, ID_TIMERS_BEGIN + vectorScriptsIt->id);
                }

                return;
            }

            // execute script
            doScriptExecute(vectorScriptsIt->fileName);

            return;
        }
    }

    switch (command)
    {
        // hotkeys
        case ID_TRAY_MENU_HOTKEYS:
            doHotkeysToggle();
            break;

        // about
        case ID_TRAY_MENU_ABOUT:
            doShowAbout();
            break;

        // homepage
        case ID_TRAY_MENU_HOMEPAGE:
            doOpenHomepage();
            break;

        // exit
        case ID_TRAY_MENU_EXIT:
            DestroyWindow(hwnd); // exit
            break;
    }
}

/* window messages handler */

LRESULT CALLBACK windowProc(HWND hwnd, UINT umsg, WPARAM wparam, LPARAM lparam)
{
    switch (umsg)
    {
        case WM_CREATE:
            onCreate(hwnd);
            break;

        case WM_CLOSE:
            DestroyWindow(hwnd); // exit
            break;

        case WM_DESTROY:
            onDestroy(hwnd);
            break;

        case WM_SHELLNOTIFY:
            onTray(hwnd, wparam, lparam);
            break;

        case WM_TIMER:
            onTimer(hwnd, wparam, lparam);
            break;

        case WM_HOTKEY:
            onHotkey(hwnd, wparam, lparam);
            break;

        case WM_COMMAND:
            onCommand(hwnd, LOWORD(wparam), HIWORD(wparam), (HWND)lparam);
            SetForegroundWindow(tibia_getwindow()); // set focus to tibia window after using tray menu
            break;

        default:
            return DefWindowProc(hwnd, umsg, wparam, lparam);
    }
    return 0;
}

/* main function */

int WINAPI WinMain(HINSTANCE hinstance, HINSTANCE hprevinstance, LPSTR cmdline, int cmdshow)
{
    // only allow one instance of application
    HWND applicationWindow = FindWindow(0, "Tibia Lua");
    if (applicationWindow)
        return 0;

    // register window class
    WNDCLASSEX wc;
    wc.cbSize        = sizeof(WNDCLASSEX);
    wc.style         = 0;
    wc.lpfnWndProc   = windowProc; // window messages handler
    wc.cbClsExtra    = 0;
    wc.cbWndExtra    = 0;
    wc.hInstance     = hinstance;
    wc.hIcon         = (HICON)LoadImage(GetModuleHandle(0), MAKEINTRESOURCE(ID_ICON_APPLICATION), IMAGE_ICON, GetSystemMetrics(SM_CXICON), GetSystemMetrics(SM_CXICON), LR_SHARED); //LoadIcon(0, IDI_WINLOGO);
    wc.hIconSm       = (HICON)LoadImage(GetModuleHandle(0), MAKEINTRESOURCE(ID_ICON_APPLICATION), IMAGE_ICON, GetSystemMetrics(SM_CXSMICON), GetSystemMetrics(SM_CXSMICON), LR_SHARED); //LoadIcon(0, IDI_WINLOGO);
    wc.hCursor       = LoadCursor(0, IDC_ARROW);
    wc.hbrBackground = 0; //(HBRUSH)CreateSolidBrush(GetSysColor(COLOR_BTNFACE)); // window background color
    wc.lpszMenuName  = 0;
    wc.lpszClassName = "tibialua";

    if(!RegisterClassEx(&wc))
    {
        MessageBox(0,
            "Register Window Class failed!",
            "Error", MB_OK | MB_ICONERROR);
        return 0;
    }

    // create window
    HWND hwnd;
    hwnd = CreateWindowEx(
        WS_EX_DLGMODALFRAME, // extended window style
        "tibialua", "Tibia Lua", // window class and title
        WS_CAPTION | WS_MINIMIZEBOX | WS_SYSMENU, // window style
        CW_USEDEFAULT, CW_USEDEFAULT,
        WINDOW_HEIGHT, WINDOW_WIDTH, // window dimensions
        HWND_DESKTOP, 0, hinstance, 0);

    if(hwnd == 0)
    {
        MessageBox(0,
            "Create Window failed!",
            "Error", MB_OK | MB_ICONERROR);
        return 0;
    }

    // center window
    //HWND desktopWindow = GetDesktopWindow();
    //RECT desktopRect;
    //GetWindowRect(desktopWindow, &desktopRect);

    //RECT hwndRect;
    //GetWindowRect(hwnd, &hwndRect);

    //hwndRect.left = desktopRect.left + ((desktopRect.right  - desktopRect.left) - (hwndRect.right  - hwndRect.left)) / 2;
    //hwndRect.top  = desktopRect.top  + ((desktopRect.bottom - desktopRect.top)  - (hwndRect.bottom - hwndRect.top))  / 2;

    //SetWindowPos(hwnd, 0, hwndRect.left, hwndRect.top, 0, 0, SWP_NOACTIVATE | SWP_NOZORDER | SWP_NOSIZE);

    // show window
    //ShowWindow(hwnd, cmdshow);
    //UpdateWindow(hwnd);

    // message loop
    MSG msg;
    while(GetMessage(&msg, 0, 0, 0) > 0)
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return msg.wParam;
}
