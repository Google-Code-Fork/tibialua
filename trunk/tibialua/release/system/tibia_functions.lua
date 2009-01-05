--[[ Tibia 8.40 ]]--

-- calculate exp for level
function Tibia:CalcExpForLevel(level)
    return ((17 + (level - 6) * level) / 3 * level - 4) * 50
end

-- calcuate exp to level up
function Tibia:CalcExpToLevelUp()
    return Tibia:CalcExpForLevel(Tibia:GetPlayerLevel() + 1) - Tibia:GetPlayerExp()
end

-- check if level spy is enabled
function Tibia:IsLevelSpyEnabled()
    local levelSpyNop = tibia_readbytes(Tibia.LEVELSPY_NOP, 2)
    if levelSpyNop == Tibia.LEVELSPY_NOP_DEFAULT then
        return false
    else
        return true
    end
end

-- check if name spy is enabled
function Tibia:IsNameSpyEnabled()
    local nameSpyNop = tibia_readbytes(Tibia.NAMESPY_NOP, 2)
    local nameSpyNop2 = tibia_readbytes(Tibia.NAMESPY_NOP2, 2)
    if nameSpyNop == Tibia.NAMESPY_NOP_DEFAULT or nameSpyNop2 == Tibia.NAMESPY_NOP2_DEFAULT then
        return false
    else
        return true
    end
end

-- check if show invisible creatures is enabled
function Tibia:IsShowInvisibleCreaturesEnabled()
    local invisible1 = tibia_readbytes(Tibia.INVISIBLE1, 1)
    local invisible2 = tibia_readbytes(Tibia.INVISIBLE2, 1)
    if invisible1 == Tibia.INVISIBLE1_DEFAULT or invisible2 == Tibia.INVISIBLE2_DEFAULT then
        return false
    else
        return true
    end
end

-- check if full light is enabled
function Tibia:IsFullLightEnabled()
    local lightNop = tibia_readbytes(Tibia.LIGHT_NOP, 2)
    if lightNop == Tibia.LIGHT_NOP_DEFAULT then
        return false
    else
        return true
    end
end

-- check if outfit is male
function Tibia:IsOutfitMale(outfit)
    for i = 1, table.getn(Tibia.OUTFITS_MALE) do
        if outfit == Tibia.OUTFITS_MALE[i] then
            return true
        end
    end
end

-- check if outfit is female
function Tibia:IsOutfitFemale(outfit)
    for i = 1, table.getn(Tibia.OUTFITS_FEMALE) do
        if outfit == Tibia.OUTFITS_FEMALE[i] then
            return true
        end
    end
end

-- check if outfit will cause client crash
function Tibia:IsOutfitError(outfit)
    for i = 1, table.getn(Tibia.OUTFITS_ERROR) do
        if outfit == Tibia.OUTFITS_ERROR[i] then
            return true
        end
    end

    -- check if outfit is out of range
    if outfit < Tibia.MIN_OUTFIT or outfit > Tibia.MAX_OUTFIT then
        return true
    end

    return false
end

-- get map pointer
function Tibia:GetMapPointer()
    return tibia_readbytes(Tibia.MAP_POINTER, 4)
end

-- get fps pointer
function Tibia:GetFpsPointer()
    return tibia_readbytes(Tibia.FPS_POINTER, 4)
end

-- get dat pointer
function Tibia:GetDatPointer()
    return tibia_readbytes(Tibia.DAT_POINTER, 4)
end

-- get player exp
function Tibia:GetPlayerExp()
    return tibia_readbytes(Tibia.PLAYER_EXP, 4)
end

-- get player level
function Tibia:GetPlayerLevel()
    return tibia_readbytes(Tibia.PLAYER_LEVEL, 4)
end

-- get player id
function Tibia:GetPlayerId()
    return tibia_readbytes(Tibia.PLAYER_ID, 3)
end

-- get player z
function Tibia:GetPlayerZ()
    return tibia_readbytes(Tibia.PLAYER_Z, 1)
end

-- get player y
function Tibia:GetPlayerY()
    return tibia_readbytes(Tibia.PLAYER_Y, 4)
end

-- get player x
function Tibia:GetPlayerX()
    return tibia_readbytes(Tibia.PLAYER_X, 4)
end

-- get player offset
function Tibia:GetPlayerOffset(offset, bytes)
    -- search through creatures
    for i = Tibia.CREATURES_BEGIN, Tibia.CREATURES_END, Tibia.STEP_CREATURE do
        -- get creature id
        local creatureId = tibia_readbytes(i + Tibia.OFFSET_CREATURE_ID, 3)

        -- creature is player
        if creatureId == Tibia:GetPlayerId() then
            return tibia_readbytes(i + offset, bytes)
        end
    end

    return -1 -- player not found
end

-- get player outfit
function Tibia:GetPlayerOutfit()
    return Tibia:GetPlayerOffset(Tibia.OFFSET_CREATURE_OUTFIT, 4)
end

-- get player outfit addon
function Tibia:GetPlayerOutfitAddon()
    return Tibia:GetPlayerOffset(Tibia.OFFSET_CREATURE_OUTFIT_ADDON, 1)
end

-- set statusbar text
function Tibia:SetStatusbarText(text)
    -- show statusbar text by timer
    tibia_writebytes(Tibia.STATUSBAR_TIMER, Tibia.STATUSBAR_DURATION, 1)

    -- set statusbar text
    tibia_writestring(Tibia.STATUSBAR_TEXT, text)
end

-- set player offset
function Tibia:SetPlayerOffset(offset, value, bytes)
    -- search through creatures
    for i = Tibia.CREATURES_BEGIN, Tibia.CREATURES_END, Tibia.STEP_CREATURE do
        -- get creature id
        local creatureId = tibia_readbytes(i + Tibia.OFFSET_CREATURE_ID, 3)

        -- creature is player
        if creatureId == Tibia:GetPlayerId() then
            -- set offset
            tibia_writebytes(i + offset, value, bytes)
            break -- player was found
        end
    end
end

-- set player outfit
function Tibia:SetPlayerOutfit(outfit)
    Tibia:SetPlayerOffset(Tibia.OFFSET_CREATURE_OUTFIT, outfit, 4)
end

-- set player outfit addon
function Tibia:SetPlayerOutfitAddon(outfitAddon)
    Tibia:SetPlayerOffset(Tibia.OFFSET_CREATURE_OUTFIT_ADDON, outfitAddon, 1)
end

-- set player outfit colors
function Tibia:SetPlayerOutfitColors(head, body, legs, feet)
    Tibia:SetPlayerOffset(Tibia.OFFSET_CREATURE_OUTFIT_HEAD, head, 1)
    Tibia:SetPlayerOffset(Tibia.OFFSET_CREATURE_OUTFIT_BODY, body, 1)
    Tibia:SetPlayerOffset(Tibia.OFFSET_CREATURE_OUTFIT_LEGS, legs, 1)
    Tibia:SetPlayerOffset(Tibia.OFFSET_CREATURE_OUTFIT_FEET, feet, 1)
end

-- set player outfit random
function Tibia:SetPlayerOutfitRandom()
    -- get random outfit
    local randomOutfit = math.random(0, Tibia.MAX_OUTFIT)

    -- avoid client crash
    if Tibia:IsOutfitError(randomOutfit) then
        Tibia:SetPlayerOutfitRandom()
        return
    end

    -- avoid same outfit
    if randomOutfit == Tibia:GetPlayerOutfit() then
        Tibia:SetPlayerOutfitRandom()
        return
    end

    -- set outfit
    Tibia:SetPlayerOutfit(randomOutfit)
end

-- set level spy
function Tibia:SetLevelSpy(enabled)
    if enabled == true then
        -- enable level spy
        tibia_writenops(Tibia.LEVELSPY_NOP, 2)

        -- initialize level spy
        Tibia:DoLevelSpyInitialize()
    else
        -- disable level spy by restoring default values
        tibia_writebytes(Tibia.LEVELSPY_NOP, Tibia.LEVELSPY_NOP_DEFAULT, 2)

        tibia_writebytes(Tibia.LEVELSPY_ABOVE, Tibia.LEVELSPY_ABOVE_DEFAULT, 1)
        tibia_writebytes(Tibia.LEVELSPY_BELOW, Tibia.LEVELSPY_BELOW_DEFAULT, 1)
    end
end

-- set name spy
function Tibia:SetNameSpy(enabled)
    if enabled == true then
        -- enable name spy
        tibia_writenops(Tibia.NAMESPY_NOP, 2)
        tibia_writenops(Tibia.NAMESPY_NOP2, 2)
    else
        -- disable name spy by restoring default values
        tibia_writebytes(Tibia.NAMESPY_NOP, Tibia.NAMESPY_NOP_DEFAULT, 2)
        tibia_writebytes(Tibia.NAMESPY_NOP2, Tibia.NAMESPY_NOP2_DEFAULT, 2)
    end
end

-- set show invisible creatures
function Tibia:SetShowInvisibleCreatures(enabled)
    if enabled == true then
        -- enable show invisible creatures
        tibia_writebytes(Tibia.INVISIBLE1, Tibia.INVISIBLE_PATCH, 1)
        tibia_writebytes(Tibia.INVISIBLE2, Tibia.INVISIBLE_PATCH, 1)
    else
        -- disable show invisible creatures by restoring default values
        tibia_writebytes(Tibia.INVISIBLE1, Tibia.INVISIBLE1_DEFAULT, 1)
        tibia_writebytes(Tibia.INVISIBLE2, Tibia.INVISIBLE2_DEFAULT, 1)
    end
end

-- set full light
function Tibia:SetFullLight(enabled)
    if enabled == true then
        -- enable full light
        tibia_writenops(Tibia.LIGHT_NOP, 2)
        tibia_writebytes(Tibia.LIGHT_AMOUNT, Tibia.LIGHT_AMOUNT_FULL, 1)
    else
        -- disable full light by restoring default values
        tibia_writebytes(Tibia.LIGHT_NOP, Tibia.LIGHT_NOP_DEFAULT, 2)
        tibia_writebytes(Tibia.LIGHT_AMOUNT, Tibia.LIGHT_AMOUNT_DEFAULT, 1)
    end
end

-- initialize level spy
function Tibia:DoLevelSpyInitialize()
    -- get player z
    local playerZ = Tibia:GetPlayerZ()

    -- set level spy to current level
    if playerZ <= Tibia.Z_AXIS_DEFAULT then
        -- above ground
        tibia_writebytes(Tibia.LEVELSPY_ABOVE, Tibia.Z_AXIS_DEFAULT - playerZ, 1) -- z-axis calculated
        tibia_writebytes(Tibia.LEVELSPY_BELOW, Tibia.LEVELSPY_BELOW_DEFAULT, 1)
    else
        -- below ground
        tibia_writebytes(Tibia.LEVELSPY_ABOVE, Tibia.LEVELSPY_ABOVE_DEFAULT, 1)
        tibia_writebytes(Tibia.LEVELSPY_BELOW, Tibia.LEVELSPY_BELOW_DEFAULT, 1)
    end
end
