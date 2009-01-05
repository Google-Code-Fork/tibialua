-- level spy must be enabled
if Tibia:IsLevelSpyEnabled() == false then
    Tibia:SetStatusbarText("Please enable Level Spy first!")
    return
end

-- get player z
local playerZ = Tibia:GetPlayerZ()

-- get ground level
local groundLevel = 0
if playerZ <= Tibia.Constants.Client.ZAxisDefault then
    -- above ground
    groundLevel = Tibia.Addresses.LevelSpy.Above
else
    -- below ground
    groundLevel = Tibia.Addresses.LevelSpy.Below
end

-- get current level
local currentLevel = tibia_readbytes(groundLevel, 1)

-- get spy level
local spyLevel = 0
if currentLevel >= Tibia.Constants.LevelSpy.Max then
    spyLevel = Tibia.Constants.LevelSpy.Min -- loop back to start
else
    spyLevel = currentLevel + 1 -- increase spy level
end

-- level spy up
tibia_writebytes(groundLevel, spyLevel, 1)

-- calculate display level
local displayLevel = 0
if playerZ <= Tibia.Constants.Client.ZAxisDefault then
    displayLevel = spyLevel -- above ground
else
    displayLevel = spyLevel - (Tibia.Constants.LevelSpy.BelowDefault + 1) -- below ground
end

-- display level
Tibia:SetStatusbarText("Level Spy: " .. displayLevel)
