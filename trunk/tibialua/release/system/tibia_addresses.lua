--[[ Tibia 8.31 ]]--

-- statusbar
STATUSBAR_TEXT     = 0x00785328
STATUSBAR_TIMER    = 0x00785324 -- timer for showing text

-- creature list
CREATURELIST_BEGIN = 0x0062AD50
CREATURELIST_END   = 0x00630B10 -- = CREATURELIST_BEGIN + (STEP_CREATURE * MAX_CREATURES)

-- level spy
LEVELSPY_NOP       = 0x004D0D80
LEVELSPY_ABOVE     = 0x004D0D7C
LEVELSPY_BELOW     = 0x004D0D84

-- name spy
NAMESPY_NOP        = 0x004EC109
NAMESPY_NOP2       = 0x004EC113

-- show invisible creatures
INVISIBLE1         = 0x0045E283
INVISIBLE2         = 0x004EB3D5

-- full light
LIGHT_NOP          = 0x004E48B9
LIGHT_AMOUNT       = 0x004E48BC

-- player
PLAYER_ID          = 0x0062ACF0 -- unique id

PLAYER_Z           = 0x00635B90
