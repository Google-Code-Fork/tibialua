--[[ Tibia 8.40 ]]--

-- client
Tibia.Constants.Client =
{
    -- z-axis
    ZAxisDefault = 7,

    -- rsa key
    RsaKeySize = 309,

    -- rsa keys
    RsaKeyTibia     = "124710459426827943004376449897985582167801707960697037164044904862948569380850421396904597686953877022394604239428185498284169068581802277612081027966724336319448537811441719076484340922854929273517308661370727105382899118999403808045846444647284499123164879035103627004668521005328367415259939915284902061793",
    RsaKeyOpenTibia = "109120132967399429278860960508995541528237502902798129123468757937266291492576446330739696001110603907230888610072655818825358503429057592827629436413108566029093628212635953836686562675849720620786279431090218017681061521755056710823876476444260558147179707119674283982419152118103759076030616683978566631413"
}

-- connection status
Tibia.Constants.ConnectionStatus =
{
    Offline = 0,
    Online  = 8
}

-- statusbar
Tibia.Constants.Statusbar =
{
    Duration = 50 -- duration to show text
}

-- map
Tibia.Constants.Map =
{
    X = 18,
    Y = 14,
    Z = 8,

    OffsetTileObjectCount = 0,  -- number of objects on tile
    OffsetTileId          = 4,
    OffsetObjectId        = 16,
    OffsetObjectData      = 20, -- unique id or item count

    StepTile   = 172,
    StepObject = 4,

    MaxTiles       = 2016, -- = (18 * 14 * 8) = (x * y * z)
    MaxTileObjects = 13
}

-- fps
Tibia.Constants.Fps =
{
    OffsetLimit         = 88,
    OffsetCurrent       = 96,
    OffsetLimitReadOnly = 104 -- read-only
}

-- login servers
Tibia.Constants.LoginServers =
{
    OffsetPort = 100,

    Step = 112,

    Max = 10
}

-- creatures
Tibia.Constants.Creatures =
{
    OffsetId          = 0, -- unique id
    OffsetType        = 3,
    OffsetOutfit      = 96,
    OffsetOutfitHead  = 100,
    OffsetOutfitBody  = 104,
    OffsetOutfitLegs  = 108,
    OffsetOutfitFeet  = 112,
    OffsetOutfitAddon = 116,

    Step = 160,

    Max = 250
}

-- creature types
Tibia.Constants.CreatureTypes =
{
    Player = 0,
    Target = 1,
    Npc    = 64
}

-- containers
Tibia.Constants.Containers =
{
    OffsetId        = 4,
    OffsetName      = 16,
    OffsetVolume    = 48, -- max number of items in container
    OffsetHasParent = 52,
    OffsetAmount    = 56, -- current number of items in container
    OffsetItemId    = 60,
    OffsetItemCount = 64,

    Step = 492,
    StepItem = 12,

    Max = 16
}

-- vips
Tibia.Constants.Vips =
{
    OffsetId       = 0,
    OffsetName     = 4,
    OffsetIsOnline = 34,
    OffsetIcon     = 40,

    Step = 44,

    Max = 100
}

-- hotkeys
Tibia.Constants.Hotkeys =
{
    Max = 36
}

-- level spy
Tibia.Constants.LevelSpy =
{
    NopDefault = 49451,

    AboveDefault = 7,
    BelowDefault = 2,

    Min = 0,
    Max = 7
}

-- name spy
Tibia.Constants.NameSpy =
{
    NopDefault  = 19061,
    Nop2Default = 16501
}

-- show invisible creatures
Tibia.Constants.Invisible =
{
    Value1Default = 114,
    Value2Default = 117,

    Patch         = 235
}

-- full light
Tibia.Constants.Light =
{
    NopDefault = 1406,

    AmountDefault = 128,
    AmountFull    = 255
}

-- outfits
Tibia.Constants.Outfits =
{
    -- possible outfit ranges before client crashes
    Min = 2,
    Max = 326,

    -- outfits that do not exist and cause the client to crash:
    -- 0, 1, 135, 161-191, 327+
    Error =
    {
        0, 1, 135,
        161, 162, 163, 164, 165, 166, 167, 168, 169, 170,
        171, 172, 173, 174, 175, 176, 177, 178, 179, 180,
        181, 182, 183, 184, 185, 186, 187, 188, 189, 190,
        191
    },

    Invisible         = 0,

    Swimming          = 267, -- swimming in water

    Gamemaster        = 75,  -- voluntary gamemaster
    Gamemaster2       = 266, -- customer support gamemaster
    CommunityManager  = 302, -- community manager

    Hero              = 73,
    Ferumbras         = 229,
    Cockroach         = 284,

    MaleOld           = 127, -- no animations
    FemaleOld         = 126, -- no animations

    MaleCitizen       = 128, -- druid
    MaleHunter        = 129, -- paladin
    MaleMage          = 130, -- sorcerer
    MaleKnight        = 131, -- knight

    MaleNobleman      = 132,
    MaleSummoner      = 133,
    MaleWarrior       = 134,
    MaleBarbarian     = 143,
    MaleDruid         = 144,
    MaleWizard        = 145,
    MaleOriental      = 146,
    MalePirate        = 151,
    MaleAssassin      = 152,
    MaleBeggar        = 153,
    MaleShaman        = 154,
    MaleNorseman      = 251,
    MaleNightmare     = 268,
    MaleJester        = 273,
    MaleBrotherhood   = 278,
    MaleDemonhunter   = 289,
    MaleYalaharian    = 325,

    FemaleCitizen     = 136, -- druid
    FemaleHunter      = 137, -- paladin
    FemaleSummoner    = 138, -- sorcerer
    FemaleKnight      = 139, -- knight

    FemaleNobleman    = 140,
    FemaleMage        = 141,
    FemaleWarrior     = 142,
    FemaleBarbarian   = 147,
    FemaleDruid       = 148,
    FemaleWizard      = 149,
    FemaleOriental    = 150,
    FemalePirate      = 155,
    FemaleAssassin    = 156,
    FemaleBeggar      = 157,
    FemaleShaman      = 158,
    FemaleNorseman    = 252,
    FemaleNightmare   = 269,
    FemaleJester      = 270,
    FemaleBrotherhood = 279,
    FemaleDemonhunter = 288,
    FemaleYalaharian  = 324,

    Male =
    {
        127,
        128,
        129,
        130,
        131,
        132,
        133,
        134,
        143,
        144,
        145,
        146,
        151,
        152,
        153,
        154,
        251,
        268,
        273,
        278,
        289,
        325
    },

    Female =
    {
        126,
        136,
        137,
        138,
        139,
        140,
        141,
        142,
        147,
        148,
        149,
        150,
        155,
        156,
        157,
        158,
        252,
        269,
        270,
        279,
        288,
        324
    }
}

-- outfit addons
Tibia.Constants.OutfitAddons =
{
    None   = 0,
    First  = 1,
    Second = 2,
    Both   = 3
}

-- outfit colors
Tibia.Constants.OutfitColors =
{
    Max = 132, -- possible colors to choose

    Newbie = {78, 69, 58, 76}
}

-- tiles
Tibia.Constants.Tiles =
{
    Lava = 727,

    WaterFishBegin   = 4597,
    WaterFishEnd     = 4602,

    WaterNoFishBegin = 4609,
    WaterNoFishEnd   = 4614
}

-- objects
Tibia.Constants.Objects =
{
    Creature = 99,

    Locker   = 3499,
    Depot    = 3502,

    Bush     = 3681,
    Bush2    = 3682,

    Trees =
    {
        957,
        3608, 3609, 3613, 3614, 3615, 3616, 3617, 3618, 3619, 3620,
        3621, 3622, 3623, 3624, 3625, 3626, 3631, 3632, 3633, 3634,
        3635, 3636, 3637, 3638, 3639, 3640, 3641, 3647, 3649, 3687,
        3688, 3689, 3691, 3692, 3694, 3742, 3743, 3744, 3745, 3750,
        3751, 3752, 3753, 3754, 3755, 3756, 3757, 3758, 3759, 3760,
        3761, 3762, 3780, 3871, 3872, 3873, 3877, 3878, 3884, 3885,
        3899, 3901, 3902, 3903, 3905, 3908, 3909, 3910, 3911, 3920,
        3921, 5091, 5092, 5093, 5094, 5095, 5155, 5156, 5389, 5390,
        5391, 5392, 6094, 7020, 7021, 7022, 7023, 7024
    }
}
