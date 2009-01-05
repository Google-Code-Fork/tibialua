--[[ Tibia 8.40 ]]--

-- rsa key
Tibia.RSA_KEY             = 0x005AB610

-- xtea key
Tibia.XTEA_KEY            = 0x00784D0C

-- connection status
Tibia.CONNECTION_STATUS   = 0x00788370

-- start timer
Tibia.START_TIMER         = 0x0078A1D0

-- fps
Tibia.FPS_POINTER         = 0x00788EB4

-- map
Tibia.MAP_POINTER         = 0x0063F568

-- dat
Tibia.DAT_POINTER         = 0x00784D2C

-- statusbar
Tibia.STATUSBAR_TEXT      = 0x0078A1E8
Tibia.STATUSBAR_TIMER     = 0x0078A1E4 -- timer for showing text

-- login servers
Tibia.LOGIN_SERVERS_BEGIN = 0x0077FC48
Tibia.LOGIN_SERVERS_END   = 0x007800A8 -- = LOGIN_SERVERS_BEGIN + (STEP_LOGIN_SERVER * MAX_LOGIN_SERVERS)

-- creatures
Tibia.CREATURES_BEGIN     = 0x0062BD90
Tibia.CREATURES_END       = 0x006359D0 -- = CREATURES_BEGIN + (STEP_CREATURE * MAX_CREATURES)

-- containers
Tibia.CONTAINERS_BEGIN    = 0x00638160
Tibia.CONTAINERS_END      = 0x00000000 -- = CONTAINERS_BEGIN + (STEP_CONTAINER * MAX_CONTAINERS)

-- vips
Tibia.VIPS_BEGIN          = 0x00629A50
Tibia.VIPS_END            = 0x0062AB80 -- = VIPS_BEGIN + (STEP_VIP * MAX_VIPS)

-- level spy
Tibia.LEVELSPY1           = 0x004EE02A
Tibia.LEVELSPY2           = 0x004EE12F
Tibia.LEVELSPY3           = 0x004EE1B0
Tibia.LEVELSPY_POINTER    = 0x006376A8

Tibia.LEVELSPY_NOP        = 0x004D0DF0
Tibia.LEVELSPY_ABOVE      = 0x004D0DEC
Tibia.LEVELSPY_BELOW      = 0x004D0DF4

-- name spy
Tibia.NAMESPY_NOP         = 0x004EC179
Tibia.NAMESPY_NOP2        = 0x004EC183

-- show invisible creatures
Tibia.INVISIBLE1          = 0x0045E2F3
Tibia.INVISIBLE2          = 0x004EB445

-- full light
Tibia.LIGHT_NOP           = 0x004E4929
Tibia.LIGHT_AMOUNT        = 0x004E492C

-- player
Tibia.PLAYER_LEVEL        = 0x0062BD20
Tibia.PLAYER_EXP          = 0x0062BD24
Tibia.PLAYER_ID           = 0x0062BD30 -- unique id
Tibia.PLAYER_Z            = 0x0063AA50
Tibia.PLAYER_Y            = 0x0063AA54
Tibia.PLAYER_X            = 0x0063AA58
