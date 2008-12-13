--[[ Tibia 8.40 ]]--

-- multi client
MULTI_CLIENT        = 0x00505924

-- rsa key
RSA_KEY             = 0x005AB610

-- xtea key
XTEA_KEY            = 0x00784D0C

-- connection status
CONNECTION_STATUS   = 0x00788370

-- start timer
START_TIMER         = 0x0078A1D0

-- fps
FPS_POINTER         = 0x00788EB4

-- map
MAP_POINTER         = 0x0063F568

-- dat
DAT_POINTER         = 0x00784D2C

-- statusbar
STATUSBAR_TEXT      = 0x0078A1E8
STATUSBAR_TIMER     = 0x0078A1E4 -- timer for showing text

-- login servers
LOGIN_SERVERS_BEGIN = 0x0077FC48
LOGIN_SERVERS_END   = 0x007800A8 -- = LOGIN_SERVERS_BEGIN + (STEP_LOGIN_SERVER * MAX_LOGIN_SERVERS)

-- creatures
CREATURES_BEGIN     = 0x0062BD90
CREATURES_END       = 0x006359D0 -- = CREATURES_BEGIN + (STEP_CREATURE * MAX_CREATURES)

-- containers
CONTAINERS_BEGIN    = 0x00638160
CONTAINERS_END      = 0x00000000 -- = CONTAINERS_BEGIN + (STEP_CONTAINER * MAX_CONTAINERS)

-- level spy
LEVELSPY1           = 0x004EE02A
LEVELSPY2           = 0x004EE12F
LEVELSPY3           = 0x004EE1B0
LEVELSPY_POINTER    = 0x006376A8

LEVELSPY_NOP        = 0x004D0DF0
LEVELSPY_ABOVE      = 0x004D0DEC
LEVELSPY_BELOW      = 0x004D0DF4

-- name spy
NAMESPY_NOP         = 0x004EC179
NAMESPY_NOP2        = 0x004EC183

-- show invisible creatures
INVISIBLE1          = 0x0045E2F3
INVISIBLE2          = 0x004EB445

-- full light
LIGHT_NOP           = 0x004E4929
LIGHT_AMOUNT        = 0x004E492C

-- player
PLAYER_LEVEL        = 0x0062BD20
PLAYER_EXP          = 0x0062BD24
PLAYER_ID           = 0x0062BD30 -- unique id
PLAYER_Z            = 0x0063AA50
