--[[ memory addresses ]]--

-- statusbar
STATUSBAR_TEXT  = 0x00785328
STATUSBAR_TIMER = 0x00785324 -- timer for showing text

-- level spy
LEVELSPY_NOP    = 0x004D0D80
LEVELSPY_ABOVE  = 0x004D0D7C
LEVELSPY_BELOW  = 0x004D0D84

-- name spy
NAMESPY_NOP     = 0x004EC109
NAMESPY_NOP2    = 0x004EC113

-- show invisible creatures
INVISIBLE1      = 0x0045E283
INVISIBLE2      = 0x004EB3D5

-- full light
LIGHT_NOP       = 0x004E48B9
LIGHT_AMOUNT    = 0x004E48BC

-- player
PLAYER_Z        = 0x00635B90

--[[ constants ]]--

-- z-axis
Z_AXIS_DEFAULT = 7

-- statusbar
STATUSBAR_DURATION = 50 -- duration to show text

-- level spy
LEVELSPY_NOP_DEFAULT = 49451

LEVELSPY_ABOVE_DEFAULT = 7
LEVELSPY_BELOW_DEFAULT = 2

LEVELSPY_MIN = 0
LEVELSPY_MAX = 7

-- name spy
NAMESPY_NOP_DEFAULT  = 19061
NAMESPY_NOP2_DEFAULT = 16501

-- show invisible creatures
INVISIBLE1_DEFAULT = 114
INVISIBLE2_DEFAULT = 117

INVISIBLE_PATCH = 235

-- full light
LIGHT_NOP_DEFAULT = 1406

LIGHT_AMOUNT_DEFAULT = 128
LIGHT_AMOUNT_FULL    = 255
