--[[ Tibia 8.40 ]]--

-- calculate exp for level
function Tibia:CalcExpForLevel(level)
    return ((17 + (level - 6) * level) / 3 * level - 4) * 50
end

-- calcuate exp to level up
function Tibia:CalcExpToLevelUp()
    return Tibia:CalcExpForLevel(Tibia:GetPlayerLevel() + 1) - Tibia:GetPlayerExp()
end

-- check if online
function Tibia:IsOnline()
    local connectionStatus = tibia_readbytes(Tibia.Addresses.Client.ConnectionStatus, 1)
    if connectionStatus == Tibia.Constants.ConnectionStatus.Online then
        return true
    else
        return false
    end
end

-- check if level spy is enabled
function Tibia:IsLevelSpyEnabled()
    local levelSpyNop = tibia_readbytes(Tibia.Addresses.LevelSpy.Nop, 2)
    if levelSpyNop == Tibia.Constants.LevelSpy.NopDefault then
        return false
    else
        return true
    end
end

-- check if name spy is enabled
function Tibia:IsNameSpyEnabled()
    local nameSpyNop = tibia_readbytes(Tibia.Addresses.NameSpy.Nop, 2)
    local nameSpyNop2 = tibia_readbytes(Tibia.Addresses.NameSpy.Nop2, 2)
    if nameSpyNop == Tibia.Constants.NameSpy.NopDefault or nameSpyNop2 == Tibia.Constants.NameSpy.Nop2Default then
        return false
    else
        return true
    end
end

-- check if show invisible creatures is enabled
function Tibia:IsShowInvisibleCreaturesEnabled()
    local invisible1 = tibia_readbytes(Tibia.Addresses.Invisible.Value1, 1)
    local invisible2 = tibia_readbytes(Tibia.Addresses.Invisible.Value2, 1)
    if invisible1 == Tibia.Constants.Invisible.Value1Default or invisible2 == Tibia.Constants.Invisible.Value2Default then
        return false
    else
        return true
    end
end

-- check if full light is enabled
function Tibia:IsFullLightEnabled()
    local lightNop = tibia_readbytes(Tibia.Addresses.Light.Nop, 2)
    if lightNop == Tibia.Constants.Light.NopDefault then
        return false
    else
        return true
    end
end

-- check if outfit is male
function Tibia:IsOutfitMale(outfit)
    for i = 1, table.getn(Tibia.Constants.Outfits.Male) do
        if outfit == Tibia.Constants.Outfits.Male[i] then
            return true
        end
    end
end

-- check if outfit is female
function Tibia:IsOutfitFemale(outfit)
    for i = 1, table.getn(Tibia.Constants.Outfits.Female) do
        if outfit == Tibia.Constants.Outfits.Female[i] then
            return true
        end
    end
end

-- check if outfit will cause client crash
function Tibia:IsOutfitError(outfit)
    for i = 1, table.getn(Tibia.Constants.Outfits.Error) do
        if outfit == Tibia.Constants.Outfits.Error[i] then
            return true
        end
    end

    -- check if outfit is out of range
    if outfit < Tibia.Constants.Outfits.Min or outfit > Tibia.Constants.Outfits.Max then
        return true
    end

    return false
end

-- get level spy pointer
function Tibia:GetLevelSpyPointer()
    return tibia_readbytes(Tibia.Addresses.Pointers.LevelSpy, 4)
end

-- get map pointer
function Tibia:GetMapPointer()
    return tibia_readbytes(Tibia.Addresses.Pointers.Map, 4)
end

-- get dat pointer
function Tibia:GetDatPointer()
    return tibia_readbytes(Tibia.Addresses.Pointers.Dat, 4)
end

-- get fps pointer
function Tibia:GetFpsPointer()
    return tibia_readbytes(Tibia.Addresses.Pointers.Fps, 4)
end

-- get player exp
function Tibia:GetPlayerExp()
    return tibia_readbytes(Tibia.Addresses.Player.Exp, 4)
end

-- get player level
function Tibia:GetPlayerLevel()
    return tibia_readbytes(Tibia.Addresses.Player.Level, 4)
end

-- get player id
function Tibia:GetPlayerId()
    return tibia_readbytes(Tibia.Addresses.Player.Id, 3)
end

-- get player z
function Tibia:GetPlayerZ()
    return tibia_readbytes(Tibia.Addresses.Player.Z, 1)
end

-- get player y
function Tibia:GetPlayerY()
    return tibia_readbytes(Tibia.Addresses.Player.Y, 4)
end

-- get player x
function Tibia:GetPlayerX()
    return tibia_readbytes(Tibia.Addresses.Player.X, 4)
end

-- get player offset
function Tibia:GetPlayerOffset(offset, bytes)
    -- search through creatures
    for i = Tibia.Addresses.Creatures.Begin, Tibia.Addresses.Creatures.End, Tibia.Constants.Creatures.Step do
        -- get creature id
        local creatureId = tibia_readbytes(i + Tibia.Constants.Creatures.OffsetId, 3)

        -- creature is player
        if creatureId == Tibia:GetPlayerId() then
            return tibia_readbytes(i + offset, bytes)
        end
    end

    return -1 -- player not found
end

-- get player outfit
function Tibia:GetPlayerOutfit()
    return Tibia:GetPlayerOffset(Tibia.Constants.Creatures.OffsetOutfit, 4)
end

-- get player outfit addon
function Tibia:GetPlayerOutfitAddon()
    return Tibia:GetPlayerOffset(Tibia.Constants.Creatures.OffsetOutfitAddon, 1)
end

-- set statusbar text
function Tibia:SetStatusbarText(text)
    -- show statusbar text by timer
    tibia_writebytes(Tibia.Addresses.Statusbar.Timer, Tibia.Constants.Statusbar.Duration, 1)

    -- set statusbar text
    tibia_writestring(Tibia.Addresses.Statusbar.Text, text)
end

-- set player offset
function Tibia:SetPlayerOffset(offset, value, bytes)
    -- search through creatures
    for i = Tibia.Addresses.Creatures.Begin, Tibia.Addresses.Creatures.End, Tibia.Constants.Creatures.Step do
        -- get creature id
        local creatureId = tibia_readbytes(i + Tibia.Constants.Creatures.OffsetId, 3)

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
    Tibia:SetPlayerOffset(Tibia.Constants.Creatures.OffsetOutfit, outfit, 4)
end

-- set player outfit addon
function Tibia:SetPlayerOutfitAddon(outfitAddon)
    Tibia:SetPlayerOffset(Tibia.Constants.Creatures.OffsetOutfitAddon, outfitAddon, 1)
end

-- set player outfit colors
function Tibia:SetPlayerOutfitColors(head, body, legs, feet)
    Tibia:SetPlayerOffset(Tibia.Constants.Creatures.OffsetOutfitHead, head, 1)
    Tibia:SetPlayerOffset(Tibia.Constants.Creatures.OffsetOutfitBody, body, 1)
    Tibia:SetPlayerOffset(Tibia.Constants.Creatures.OffsetOutfitLegs, legs, 1)
    Tibia:SetPlayerOffset(Tibia.Constants.Creatures.OffsetOutfitFeet, feet, 1)
end

-- set player outfit random
function Tibia:SetPlayerOutfitRandom()
    -- get random outfit
    local randomOutfit = math.random(0, Tibia.Constants.Outfits.Max)

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
        tibia_writenops(Tibia.Addresses.LevelSpy.Nop, 2)

        -- initialize level spy
        Tibia:DoLevelSpyInitialize()
    else
        -- disable level spy by restoring default values
        tibia_writebytes(Tibia.Addresses.LevelSpy.Nop, Tibia.Constants.LevelSpy.NopDefault, 2)

        tibia_writebytes(Tibia.Addresses.LevelSpy.Above, Tibia.Constants.LevelSpy.AboveDefault, 1)
        tibia_writebytes(Tibia.Addresses.LevelSpy.Below, Tibia.Constants.LevelSpy.BelowDefault, 1)
    end
end

-- set name spy
function Tibia:SetNameSpy(enabled)
    if enabled == true then
        -- enable name spy
        tibia_writenops(Tibia.Addresses.NameSpy.Nop, 2)
        tibia_writenops(Tibia.Addresses.NameSpy.Nop2, 2)
    else
        -- disable name spy by restoring default values
        tibia_writebytes(Tibia.Addresses.NameSpy.Nop, Tibia.Constants.NameSpy.NopDefault, 2)
        tibia_writebytes(Tibia.Addresses.NameSpy.Nop2, Tibia.Constants.NameSpy.Nop2Default, 2)
    end
end

-- set show invisible creatures
function Tibia:SetShowInvisibleCreatures(enabled)
    if enabled == true then
        -- enable show invisible creatures
        tibia_writebytes(Tibia.Addresses.Invisible.Value1, Tibia.Constants.Invisible.Patch, 1)
        tibia_writebytes(Tibia.Addresses.Invisible.Value2, Tibia.Constants.Invisible.Patch, 1)
    else
        -- disable show invisible creatures by restoring default values
        tibia_writebytes(Tibia.Addresses.Invisible.Value1, Tibia.Constants.Invisible.Value1Default, 1)
        tibia_writebytes(Tibia.Addresses.Invisible.Value2, Tibia.Constants.Invisible.Value2Default, 1)
    end
end

-- set full light
function Tibia:SetFullLight(enabled)
    if enabled == true then
        -- enable full light
        tibia_writenops(Tibia.Addresses.Light.Nop, 2)
        tibia_writebytes(Tibia.Addresses.Light.Amount, Tibia.Constants.Light.AmountFull, 1)
    else
        -- disable full light by restoring default values
        tibia_writebytes(Tibia.Addresses.Light.Nop, Tibia.Constants.Light.NopDefault, 2)
        tibia_writebytes(Tibia.Addresses.Light.Amount, Tibia.Constants.Light.AmountDefault, 1)
    end
end

-- initialize level spy
function Tibia:DoLevelSpyInitialize()
    -- get player z
    local playerZ = Tibia:GetPlayerZ()

    -- set level spy to current level
    if playerZ <= Tibia.Constants.Client.ZAxisDefault then
        -- above ground
        tibia_writebytes(Tibia.Addresses.LevelSpy.Above, Tibia.Constants.Client.ZAxisDefault - playerZ, 1) -- z-axis calculated
        tibia_writebytes(Tibia.Addresses.LevelSpy.Below, Tibia.Constants.LevelSpy.BelowDefault, 1)
    else
        -- below ground
        tibia_writebytes(Tibia.Addresses.LevelSpy.Above, Tibia.Constants.LevelSpy.AboveDefault, 1)
        tibia_writebytes(Tibia.Addresses.LevelSpy.Below, Tibia.Constants.LevelSpy.BelowDefault, 1)
    end
end
