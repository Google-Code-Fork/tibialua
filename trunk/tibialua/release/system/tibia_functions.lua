--[[ Tibia 8.40 ]]--

-- calculate exp for level
function tibia_calcexpforlevel(level)
    return ((17 + (level - 6) * level) / 3 * level - 4) * 50
end

-- calcuate exp to level up
function tibia_calcexptolevelup()
    return tibia_calcexpforlevel(tibia_getplayerlevel() + 1) - tibia_getplayerexp()
end

-- check if level spy is enabled
function tibia_islevelspyenabled()
    local levelSpyNop = tibia_readbytes(LEVELSPY_NOP, 2)
    if levelSpyNop == LEVELSPY_NOP_DEFAULT then
        return false
    else
        return true
    end
end

-- check if name spy is enabled
function tibia_isnamespyenabled()
    local nameSpyNop = tibia_readbytes(NAMESPY_NOP, 2)
    local nameSpyNop2 = tibia_readbytes(NAMESPY_NOP2, 2)
    if nameSpyNop == NAMESPY_NOP_DEFAULT or nameSpyNop2 == NAMESPY_NOP2_DEFAULT then
        return false
    else
        return true
    end
end

-- check if show invisible creatures is enabled
function tibia_isshowinvisiblecreaturesenabled()
    local invisible1 = tibia_readbytes(INVISIBLE1, 1)
    local invisible2 = tibia_readbytes(INVISIBLE2, 1)
    if invisible1 == INVISIBLE1_DEFAULT or invisible2 == INVISIBLE2_DEFAULT then
        return false
    else
        return true
    end
end

-- check if full light is enabled
function tibia_isfulllightenabled()
    local lightNop = tibia_readbytes(LIGHT_NOP, 2)
    if lightNop == LIGHT_NOP_DEFAULT then
        return false
    else
        return true
    end
end

-- check if outfit will cause client crash
function tibia_isoutfiterror(outfit)
    for i = 1, table.getn(OUTFIT_ERROR) do
        if outfit == OUTFIT_ERROR[i] then
            return true
        end
    end

    -- check if outfit is out of range
    if outfit < MIN_OUTFIT or outfit > MAX_OUTFIT then
        return true
    end

    return false
end

-- get map pointer
function tibia_getmappointer()
    return tibia_readbytes(MAP_POINTER, 4)
end

-- get fps pointer
function tibia_getfpspointer()
    return tibia_readbytes(FPS_POINTER, 4)
end

-- get dat pointer
function tibia_getdatpointer()
    return tibia_readbytes(DAT_POINTER, 4)
end

-- get player exp
function tibia_getplayerexp()
    return tibia_readbytes(PLAYER_EXP, 4)
end

-- get player level
function tibia_getplayerlevel()
    return tibia_readbytes(PLAYER_LEVEL, 4)
end

-- get player id
function tibia_getplayerid()
    return tibia_readbytes(PLAYER_ID, 3)
end

-- get player z
function tibia_getplayerz()
    return tibia_readbytes(PLAYER_Z, 1)
end

-- get player offset
function tibia_getplayeroffset(offset, bytes)
    -- search through creatures
    for i = CREATURES_BEGIN, CREATURES_END, STEP_CREATURE do
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
    return tibia_getplayeroffset(OFFSET_CREATURE_OUTFIT, 4)
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
    -- search through creatures
    for i = CREATURES_BEGIN, CREATURES_END, STEP_CREATURE do
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
    tibia_setplayeroffset(OFFSET_CREATURE_OUTFIT, outfit, 4)
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
    if tibia_isoutfiterror(randomOutfit) then
        tibia_setplayeroutfitrandom()
        return
    end

    -- avoid same outfit
    if randomOutfit == tibia_getplayeroutfit() then
        tibia_setplayeroutfitrandom()
        return
    end

    -- set outfit
    tibia_setplayeroutfit(randomOutfit)
end

-- set level spy
function tibia_setlevelspy(enabled)
    if enabled == true then
        -- enable level spy
        tibia_writenops(LEVELSPY_NOP, 2)

        -- initialize level spy
        tibia_dolevelspyinitialize()
    else
        -- disable level spy by restoring default values
        tibia_writebytes(LEVELSPY_NOP, LEVELSPY_NOP_DEFAULT, 2)

        tibia_writebytes(LEVELSPY_ABOVE, LEVELSPY_ABOVE_DEFAULT, 1)
        tibia_writebytes(LEVELSPY_BELOW, LEVELSPY_BELOW_DEFAULT, 1)
    end
end

-- set name spy
function tibia_setnamespy(enabled)
    if enabled == true then
        -- enable name spy
        tibia_writenops(NAMESPY_NOP, 2)
        tibia_writenops(NAMESPY_NOP2, 2)
    else
        -- disable name spy by restoring default values
        tibia_writebytes(NAMESPY_NOP, NAMESPY_NOP_DEFAULT, 2)
        tibia_writebytes(NAMESPY_NOP2, NAMESPY_NOP2_DEFAULT, 2)
    end
end

-- set show invisible creatures
function tibia_setshowinvisiblecreatures(enabled)
    if enabled == true then
        -- enable show invisible creatures
        tibia_writebytes(INVISIBLE1, INVISIBLE_PATCH, 1)
        tibia_writebytes(INVISIBLE2, INVISIBLE_PATCH, 1)
    else
        -- disable show invisible creatures by restoring default values
        tibia_writebytes(INVISIBLE1, INVISIBLE1_DEFAULT, 1)
        tibia_writebytes(INVISIBLE2, INVISIBLE2_DEFAULT, 1)
    end
end

-- set full light
function tibia_setfulllight(enabled)
    if enabled == true then
        -- enable full light
        tibia_writenops(LIGHT_NOP, 2)
        tibia_writebytes(LIGHT_AMOUNT, LIGHT_AMOUNT_FULL, 1)
    else
        -- disable full light by restoring default values
        tibia_writebytes(LIGHT_NOP, LIGHT_NOP_DEFAULT, 2)
        tibia_writebytes(LIGHT_AMOUNT, LIGHT_AMOUNT_DEFAULT, 1)
    end
end

-- initialize level spy
function tibia_dolevelspyinitialize()
    -- get player z
    local playerZ = tibia_getplayerz()

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
