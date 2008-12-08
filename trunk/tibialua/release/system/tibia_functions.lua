--[[ Tibia 8.31 ]]--

-- get player id
function getPlayerId()
    return readBytes(PLAYER_ID, 3)
end

-- get player offset
function getPlayerOffset(offset, bytes)
    -- search through creature list
    for i = CREATURELIST_BEGIN, CREATURELIST_END, STEP_CREATURE do
        -- get creature id
        local creatureId = readBytes(i + OFFSET_CREATURE_ID, 3)

        -- creature is player
        if creatureId == getPlayerId() then
            return readBytes(i + offset, bytes)
        end
    end

    return -1 -- player not found
end

-- get player outfit
function getPlayerOutfit()
    return getPlayerOffset(OFFSET_CREATURE_OUTFIT, 1)
end

-- get player outfit addon
function getPlayerOutfitAddon()
    return getPlayerOffset(OFFSET_CREATURE_OUTFIT_ADDON, 1)
end

-- set statusbar text
function setStatusbarText(text)
    -- show statusbar text by timer
    writeBytes(STATUSBAR_TIMER, STATUSBAR_DURATION, 1)

    -- set statusbar text
    writeString(STATUSBAR_TEXT, text)
end

-- set player offset
function setPlayerOffset(offset, value, bytes)
    -- search through creature list
    for i = CREATURELIST_BEGIN, CREATURELIST_END, STEP_CREATURE do
        -- get creature id
        local creatureId = readBytes(i + OFFSET_CREATURE_ID, 3)

        -- creature is player
        if creatureId == getPlayerId() then
            -- set offset
            writeBytes(i + offset, value, bytes)
            break -- player was found
        end
    end
end

-- set player outfit
function setPlayerOutfit(outfitType)
    setPlayerOffset(OFFSET_CREATURE_OUTFIT, outfitType, 2)
end

-- set player outfit addon
function setPlayerOutfitAddon(outfitAddonType)
    setPlayerOffset(OFFSET_CREATURE_OUTFIT_ADDON, outfitAddonType, 1)
end

-- set player outfit colors
function setPlayerOutfitColors(head, body, legs, feet)
    setPlayerOffset(OFFSET_CREATURE_OUTFIT_HEAD, head, 1)
    setPlayerOffset(OFFSET_CREATURE_OUTFIT_BODY, body, 1)
    setPlayerOffset(OFFSET_CREATURE_OUTFIT_LEGS, legs, 1)
    setPlayerOffset(OFFSET_CREATURE_OUTFIT_FEET, feet, 1)
end

-- check if level spy is enabled
function isLevelSpyEnabled()
    local levelSpyNop = readBytes(LEVELSPY_NOP, 2)
    if levelSpyNop == LEVELSPY_NOP_DEFAULT then
        return 0
    else
        return 1
    end
end

-- check if name spy is enabled
function isNameSpyEnabled()
    local nameSpyNop = readBytes(NAMESPY_NOP, 2)
    local nameSpyNop2 = readBytes(NAMESPY_NOP2, 2)
    if nameSpyNop == NAMESPY_NOP_DEFAULT or nameSpyNop2 == NAMESPY_NOP2_DEFAULT then
        return 0
    else
        return 1
    end
end

-- check if show invisible creatures is enabled
function isShowInvisibleCreaturesEnabled()
    local invisible1 = readBytes(INVISIBLE1, 1)
    local invisible2 = readBytes(INVISIBLE2, 1)
    if invisible1 == INVISIBLE1_DEFAULT or invisible2 == INVISIBLE2_DEFAULT then
        return 0
    else
        return 1
    end
end

-- check if full light is enabled
function isFullLightEnabled()
    local lightNop = readBytes(LIGHT_NOP, 2)
    if lightNop == LIGHT_NOP_DEFAULT then
        return 0
    else
        return 1
    end
end

-- initialize level spy
function doLevelSpyInit()
    -- get player z
    local playerZ = readBytes(PLAYER_Z, 1)

    -- set level spy to current level
    if playerZ <= Z_AXIS_DEFAULT then
        -- above ground
        writeBytes(LEVELSPY_ABOVE, Z_AXIS_DEFAULT - playerZ, 1) -- z-axis calculated
        writeBytes(LEVELSPY_BELOW, LEVELSPY_BELOW_DEFAULT, 1)
    else
        -- below ground
        writeBytes(LEVELSPY_ABOVE, LEVELSPY_ABOVE_DEFAULT, 1)
        writeBytes(LEVELSPY_BELOW, LEVELSPY_BELOW_DEFAULT, 1)
    end
end

-- disable level spy
function doLevelSpyOff()
    -- disable level spy by restoring default values
    writeBytes(LEVELSPY_NOP, LEVELSPY_NOP_DEFAULT, 2)

    writeBytes(LEVELSPY_ABOVE, LEVELSPY_ABOVE_DEFAULT, 1)
    writeBytes(LEVELSPY_BELOW, LEVELSPY_BELOW_DEFAULT, 1)
end

-- toggle level spy
function doLevelSpyToggle()
    -- check if level spy is enabled
    if isLevelSpyEnabled() == 0 then
        -- enable level spy
        writeNops(LEVELSPY_NOP, 2)

        -- initialize level spy
        doLevelSpyInit()

        setStatusbarText("Level Spy: On")
    else
        -- disable level spy
        doLevelSpyOff()

        setStatusbarText("Level Spy: Off")
    end
end

-- level spy up
function doLevelSpyUp()
    -- level spy must be enabled
    if isLevelSpyEnabled() == 0 then
        setStatusbarText("Please enable Level Spy first!")
        return
    end

    -- get player z
    local playerZ = readBytes(PLAYER_Z, 1)

    -- get ground level
    local groundLevel = 0
    if playerZ <= Z_AXIS_DEFAULT then
        groundLevel = LEVELSPY_ABOVE -- above ground
    else
        groundLevel = LEVELSPY_BELOW -- below ground
    end

    -- get current level
    local currentLevel = readBytes(groundLevel, 1)

    -- get spy level
    local spyLevel = 0
    if currentLevel >= LEVELSPY_MAX then
        spyLevel = LEVELSPY_MIN -- loop back to start
    else
        spyLevel = currentLevel + 1 -- increase spy level
    end

    -- level spy up
    writeBytes(groundLevel, spyLevel, 1)

    -- calculate display level
    local displayLevel = 0
    if playerZ <= Z_AXIS_DEFAULT then
        displayLevel = spyLevel -- above ground
    else
        displayLevel = spyLevel - (LEVELSPY_BELOW_DEFAULT + 1) -- below ground
    end

    -- display level
    setStatusbarText("Level Spy: " .. displayLevel)
end

-- level spy down
function doLevelSpyDown()
    -- level spy must be enabled
    if isLevelSpyEnabled() == 0 then
        setStatusbarText("Please enable Level Spy first!")
        return
    end

    -- get player z
    local playerZ = readBytes(PLAYER_Z, 1)

    -- get ground level
    local groundLevel = 0
    if playerZ <= Z_AXIS_DEFAULT then
        groundLevel = LEVELSPY_ABOVE -- above ground
    else
        groundLevel = LEVELSPY_BELOW -- below ground
    end

    -- get current level
    local currentLevel = readBytes(groundLevel, 1)

    -- cannot spy below default z-axis
    --if playerZ == Z_AXIS_DEFAULT and currentLevel == LEVELSPY_MIN then
        --setStatusbarText("You cannot spy below the default ground level!")
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
    writeBytes(groundLevel, spyLevel, 1)

    -- calculate display level
    local displayLevel = 0
    if playerZ <= Z_AXIS_DEFAULT then
        displayLevel = spyLevel -- above ground
    else
        displayLevel = spyLevel - (LEVELSPY_BELOW_DEFAULT + 1) -- below ground
    end

    -- display level
    setStatusbarText("Level Spy: " .. displayLevel)
end

-- disable name spy
function doNameSpyOff()
    -- disable name spy by restoring default values
    writeBytes(NAMESPY_NOP, NAMESPY_NOP_DEFAULT, 2)
    writeBytes(NAMESPY_NOP2, NAMESPY_NOP2_DEFAULT, 2)
end

-- toggle name spy
function doNameSpyToggle()
    -- check if name spy is enabled
    if isNameSpyEnabled() == 0 then
        -- enable name spy
        writeNops(NAMESPY_NOP, 2)
        writeNops(NAMESPY_NOP2, 2)

        setStatusbarText("Name Spy: On")
    else
        -- disable name spy
        doNameSpyOff()

        setStatusbarText("Name Spy: Off")
    end
end

-- disable show invisible creatures
function doShowInvisibleCreaturesOff()
    -- disable show invisible creatures by restoring default values
    writeBytes(INVISIBLE1, INVISIBLE1_DEFAULT, 1)
    writeBytes(INVISIBLE2, INVISIBLE2_DEFAULT, 1)
end

-- toggle show invisible creatures
function doShowInvisibleCreaturesToggle()
    -- check if show invisible creatures is enabled
    if isShowInvisibleCreaturesEnabled() == 0 then
        -- enable show invisible creatures
        writeBytes(INVISIBLE1, INVISIBLE_PATCH, 1)
        writeBytes(INVISIBLE2, INVISIBLE_PATCH, 1)

        setStatusbarText("Show Invisible Creatures: On")
    else
        -- disable show invisible creatures
        doShowInvisibleCreaturesOff()

        setStatusbarText("Show Invisible Creatures: Off")
    end
end

-- disable full light
function doFullLightOff()
    -- disable full light by restoring default values
    writeBytes(LIGHT_NOP, LIGHT_NOP_DEFAULT, 2)
    writeBytes(LIGHT_AMOUNT, LIGHT_AMOUNT_DEFAULT, 1)
end

-- toggle full light
function doFullLightToggle()
    -- check if full light is enabled
    if isFullLightEnabled() == 0 then
        -- enable full light
        writeNops(LIGHT_NOP, 2)
        writeBytes(LIGHT_AMOUNT, LIGHT_AMOUNT_FULL, 1)

        setStatusbarText("Full Light: On")
    else
        -- disable full light
        doFullLightOff()

        setStatusbarText("Full Light: Off")
    end
end

-- random outfit
function doOutfitRandom()
    -- get random outfit
    local randomOutfit = math.random(0, MAX_OUTFIT)

    -- avoid client crash
    for i = 1, table.getn(OUTFIT_ERROR) do
        if randomOutfit == OUTFIT_ERROR[i] then
            doOutfitRandom()
            return
        end
    end

    -- avoid same outfit
    if randomOutfit == getPlayerOutfit() then
        doOutfitRandom()
        return
    end

    -- set outfit
    setPlayerOutfit(randomOutfit)
end
