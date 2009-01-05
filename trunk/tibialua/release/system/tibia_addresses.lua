--[[ Tibia 8.40 ]]--

-- client
Tibia.Addresses.Client =
{
    RsaKey           = 0x005AB610,
    XteaKey          = 0x00784D0C,
    StartTimer       = 0x0078A1D0,
    ConnectionStatus = 0x00788370
}

-- pointers
Tibia.Addresses.Pointers =
{
    LevelSpy = 0x006376A8,
    Map      = 0x0063F568,
    Dat      = 0x00784D2C,
    Fps      = 0x00788EB4
}

-- statusbar
Tibia.Addresses.Statusbar =
{
    Text  = 0x0078A1E8,
    Timer = 0x0078A1E4 -- timer for showing text
}

-- login servers
Tibia.Addresses.LoginServers =
{
    Begin = 0x0077FC48,
    End   = 0x007800A8 -- = begin + (step * max)
}

-- creatures
Tibia.Addresses.Creatures =
{
    Begin = 0x0062BD90,
    End   = 0x006359D0 -- = begin + (step * max)
}

-- containers
Tibia.Addresses.Containers =
{
    Begin = 0x00638160,
    End   = 0x0063A020 -- = begin + (step * max)
}

-- vips
Tibia.Addresses.Vips =
{
    Begin = 0x00629A50,
    End   = 0x0062AB80 -- = begin + (step * max)
}

-- level spy
Tibia.Addresses.LevelSpy =
{
    Value1 = 0x004EE02A,
    Value2 = 0x004EE12F,
    Value3 = 0x004EE1B0,

    Nop   = 0x004D0DF0,
    Above = 0x004D0DEC,
    Below = 0x004D0DF4
}

-- name spy
Tibia.Addresses.NameSpy =
{
    Nop  = 0x004EC179,
    Nop2 = 0x004EC183
}

-- show invisible creatures
Tibia.Addresses.Invisible =
{
    Value1 = 0x0045E2F3,
    Value2 = 0x004EB445
}

-- full light
Tibia.Addresses.Light =
{
    Nop    = 0x004E4929,
    Amount = 0x004E492C
}

-- player
Tibia.Addresses.Player =
{
    Level = 0x0062BD20,
    Exp   = 0x0062BD24,
    Id    = 0x0062BD30, -- unique id

    Z     = 0x0063AA50,
    Y     = 0x0063AA54,
    X     = 0x0063AA58
}
