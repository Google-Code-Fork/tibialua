--[[ Tibia 8.31 ]]--

-- get player id
function tibia_getplayerid()
    return tibia_readbytes(PLAYER_ID, 3)
end

-- get player offset
function tibia_getplayeroffset(offset, bytes)
    -- search through creature list
    for i = CREATURELIST_BEGIN, CREATURELIST_END, STEP_CREATURE do
        -- get creature id
        local creatureId = tibia_readbytes(i + OFFSET_CREATURE_ID, 3)

        -- creature is player
        if creatureId == tibia_getplayerid() then
            return tibia_readbytes(i + offset, bytes)
        end
    end

    return -1 -- player not found
end

-- get player outfit
function tibia_getplayeroutfit()
    return tibia_getplayeroffset(OFFSET_CREATURE_OUTFIT, 1)
end

-- get player outfit addon
function tibia_getplayeroutfitaddon()
    return tibia_getplayeroffset(OFFSET_CREATURE_OUTFIT_ADDON, 1)
end

-- set statusbar text
function tibia_setstatusbartext(text)
    -- show statusbar text by timer
    tibia_writebytes(STATUSBAR_TIMER, STATUSBAR_DURATION, 1)

    -- set statusbar text
    tibia_writestring(STATUSBAR_TEXT, text)
end

-- set player offset
function tibia_setplayeroffset(offset, value, bytes)
    -- search through creature list
    for i = CREATURELIST_BEGIN, CREATURELIST_END, STEP_CREATURE do
        -- get creature id
        local creatureId = tibia_readbytes(i + OFFSET_CREATURE_ID, 3)

        -- creature is player
        if creatureId == tibia_getplayerid() then
            -- set offset
            tibia_writebytes(i + offset, value, bytes)
            break -- player was found
        end
    end
end

-- set player outfit
function tibia_setplayeroutfit(outfit)
    tibia_setplayeroffset(OFFSET_CREATURE_OUTFIT, outfit, 2)
end

-- set player outfit addon
function tibia_setplayeroutfitaddon(outfitAddon)
    tibia_setplayeroffset(OFFSET_CREATURE_OUTFIT_ADDON, outfitAddon, 1)
end

-- set player outfit colors
function tibia_setplayeroutfitcolors(head, body, legs, feet)
    tibia_setplayeroffset(OFFSET_CREATURE_OUTFIT_HEAD, head, 1)
    tibia_setplayeroffset(OFFSET_CREATURE_OUTFIT_BODY, body, 1)
    tibia_setplayeroffset(OFFSET_CREATURE_OUTFIT_LEGS, legs, 1)
    tibia_setplayeroffset(OFFSET_CREATURE_OUTFIT_FEET, feet, 1)
end

-- set player outfit random
function tibia_setplayeroutfitrandom()
    -- get random outfit
    local randomOutfit = math.random(0, MAX_OUTFIT)

    -- avoid client crash
    for i = 1, table.getn(OUTFIT_ERROR) do
        if randomOutfit == OUTFIT_ERROR[i] then
            tibia_setplayeroutfitrandom()
            return
        end
    end

    -- avoid same outfit
    if randomOutfit == tibia_getplayeroutfit() then
        tibia_setplayeroutfitrandom()
        return
    end

    -- set outfit
    tibia_setplayeroutfit(randomOutfit)
end

-- check if level spy is enabled
function tibia_islevelspyenabled()
    local levelSpyNop = tibia_readbytes(LEVELSPY_NOP, 2)
    if levelSpyNop == LEVELSPY_NOP_DEFAULT then
        return 0
    else
        return 1
    end
end

-- check if name spy is enabled
function tibia_isnamespyenabled()
    local nameSpyNop = tibia_readbytes(NAMESPY_NOP, 2)
    local nameSpyNop2 = tibia_readbytes(NAMESPY_NOP2, 2)
    if nameSpyNop == NAMESPY_NOP_DEFAULT or nameSpyNop2 == NAMESPY_NOP2_DEFAULT then
        return 0
    else
        return 1
    end
end

-- check if show invisible creatures is enabled
function tibia_isshowinvisiblecreaturesenabled()
    local invisible1 = tibia_readbytes(INVISIBLE1, 1)
    local invisible2 = tibia_readbytes(INVISIBLE2, 1)
    if invisible1 == INVISIBLE1_DEFAULT or invisible2 == INVISIBLE2_DEFAULT then
        return 0
    else
        return 1
    end
end

-- check if full light is enabled
function tibia_isfulllightenabled()
    local lightNop = tibia_readbytes(LIGHT_NOP, 2)
    if lightNop == LIGHT_NOP_DEFAULT then
        return 0
    else
        return 1
    end
end

-- initialize level spy
function tibia_dolevelspyinit()
    -- get player z
    local playerZ = tibia_readbytes(PLAYER_Z, 1)

    -- set level spy to current level
    if playerZ <= Z_AXIS_DEFAULT then
        -- above ground
        tibia_writebytes(LEVELSPY_ABOVE, Z_AXIS_DEFAULT - playerZ, 1) -- z-axis calculated
        tibia_writebytes(LEVELSPY_BELOW, LEVELSPY_BELOW_DEFAULT, 1)
    else
        -- below ground
        tibia_writebytes(LEVELSPY_ABOVE, LEVELSPY_ABOVE_DEFAULT, 1)
        tibia_writebytes(LEVELSPY_BELOW, LEVELSPY_BELOW_DEFAULT, 1)
    end
end

-- disable level spy
function tibia_dolevelspyoff()
    -- disable level spy by restoring default values
    tibia_writebytes(LEVELSPY_NOP, LEVELSPY_NOP_DEFAULT, 2)

    tibia_writebytes(LEVELSPY_ABOVE, LEVELSPY_ABOVE_DEFAULT, 1)
    tibia_writebytes(LEVELSPY_BELOW, LEVELSPY_BELOW_DEFAULT, 1)
end

-- toggle level spy
function tibia_dolevelspytoggle()
    -- check if level spy is enabled
    if tibia_islevelspyenabled() == 0 then
        -- enable level spy
        tibia_writenops(LEVELSPY_NOP, 2)

        -- initialize level spy
        tibia_dolevelspyinit()

        tibia_setstatusbartext("Level Spy: On")
    else
        -- disable level spy
        tibia_dolevelspyoff()

        tibia_setstatusbartext("Level Spy: Off")
    end
end

-- level spy up
function tibia_dolevelspyup()
    -- level spy must be enabled
    if tibia_islevelspyenabled() == 0 then
        tibia_setstatusbartext("Please enable Level Spy first!")
        return
    end

    -- get player z
    local playerZ = tibia_readbytes(PLAYER_Z, 1)

    -- get ground level
    local groundLevel = 0
    if playerZ <= Z_AXIS_DEFAULT then
        groundLevel = LEVELSPY_ABOVE -- above ground
    else
        groundLevel = LEVELSPY_BELOW -- below ground
    end

    -- get current level
    local currentLevel = tibia_readbytes(groundLevel, 1)

    -- get spy level
    local spyLevel = 0
    if currentLevel >= LEVELSPY_MAX then
        spyLevel = LEVELSPY_MIN -- loop back to start
    else
        spyLevel = currentLevel + 1 -- increase spy level
    end

    -- level spy up
    tibia_writebytes(groundLevel, spyLevel, 1)

    -- calculate display level
    local displayLevel = 0
    if playerZ <= Z_AXIS_DEFAULT then
        displayLevel = spyLevel -- above ground
    else
        displayLevel = spyLevel - (LEVELSPY_BELOW_DEFAULT + 1) -- below ground
    end

    -- display level
    tibia_setstatusbartext("Level Spy: " .. displayLevel)
end

-- level spy down
function tibia_dolevelspydown()
    -- level spy must be enabled
    if tibia_islevelspyenabled() == 0 then
        tibia_setstatusbartext("Please enable Level Spy first!")
        return
    end

    -- get player z
    local playerZ = tibia_readbytes(PLAYER_Z, 1)

    -- get ground level
    local groundLevel = 0
    if playerZ <= Z_AXIS_DEFAULT then
        groundLevel = LEVELSPY_ABOVE -- above ground
    else
        groundLevel = LEVELSPY_BELOW -- below ground
    end

    -- get current level
    local currentLevel = tibia_readbytes(groundLevel, 1)

    -- cannot spy below default z-axis
    --if playerZ == Z_AXIS_DEFAULT and currentLevel == LEVELSPY_MIN then
        --tibia_setstatusbartext("You cannot spy below the default ground level!")
        --return
    --end

    -- get spy level
    local spyLevel = 0
    if currentLevel <= LEVELSPY_MIN then
        spyLevel = LEVELSPY_MAX -- loop back to start
    else
        spyLevel = currentLevel - 1 -- decrease spy level
    end

    -- level spy down
    tibia_writebytes(groundLevel, spyLevel, 1)

    -- calculate display level
    local displayLevel = 0
    if playerZ <= Z_AXIS_DEFAULT then
        displayLevel = spyLevel -- above ground
    else
        displayLevel = spyLevel - (LEVELSPY_BELOW_DEFAULT + 1) -- below ground
    end

    -- display level
    tibia_setstatusbartext("Level Spy: " .. displayLevel)
end

-- disable name spy
function tibia_donamespyoff()
    -- disable name spy by restoring default values
    tibia_writebytes(NAMESPY_NOP, NAMESPY_NOP_DEFAULT, 2)
    tibia_writebytes(NAMESPY_NOP2, NAMESPY_NOP2_DEFAULT, 2)
end

-- toggle name spy
function tibia_donamespytoggle()
    -- check if name spy is enabled
    if tibia_isnamespyenabled() == 0 then
        -- enable name spy
        tibia_writenops(NAMESPY_NOP, 2)
        tibia_writenops(NAMESPY_NOP2, 2)

        tibia_setstatusbartext("Name Spy: On")
    else
        -- disable name spy
        tibia_donamespyoff()

        tibia_setstatusbartext("Name Spy: Off")
    end
end

-- disable show invisible creatures
function tibia_doshowinvisiblecreaturesoff()
    -- disable show invisible creatures by restoring default values
    tibia_writebytes(INVISIBLE1, INVISIBLE1_DEFAULT, 1)
    tibia_writebytes(INVISIBLE2, INVISIBLE2_DEFAULT, 1)
end

-- toggle show invisible creatures
function tibia_doshowinvisiblecreaturestoggle()
    -- check if show invisible creatures is enabled
    if tibia_isshowinvisiblecreaturesenabled() == 0 then
        -- enable show invisible creatures
        tibia_writebytes(INVISIBLE1, INVISIBLE_PATCH, 1)
        tibia_writebytes(INVISIBLE2, INVISIBLE_PATCH, 1)

        tibia_setstatusbartext("Show Invisible Creatures: On")
    else
        -- disable show invisible creatures
        tibia_doshowinvisiblecreaturesoff()

        tibia_setstatusbartext("Show Invisible Creatures: Off")
    end
end

-- disable full light
function tibia_dofulllightoff()
    -- disable full light by restoring default values
    tibia_writebytes(LIGHT_NOP, LIGHT_NOP_DEFAULT, 2)
    tibia_writebytes(LIGHT_AMOUNT, LIGHT_AMOUNT_DEFAULT, 1)
end

-- toggle full light
function tibia_dofulllighttoggle()
    -- check if full light is enabled
    if tibia_isfulllightenabled() == 0 then
        -- enable full light
        tibia_writenops(LIGHT_NOP, 2)
        tibia_writebytes(LIGHT_AMOUNT, LIGHT_AMOUNT_FULL, 1)

        tibia_setstatusbartext("Full Light: On")
    else
        -- disable full light
        tibia_dofulllightoff()

        tibia_setstatusbartext("Full Light: Off")
    end
end
