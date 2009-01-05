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
    groundLevel = Tibia.Addresses.LevelSpy.Above -- above ground
else
    groundLevel = Tibia.Addresses.LevelSpy.Below -- below ground
end

-- get current level
local currentLevel = tibia_readbytes(groundLevel, 1)

-- cannot spy below default z-axis
--if playerZ == Tibia.Constants.Client.ZAxisDefault and currentLevel == Tibia.Constants.LevelSpy.Min then
    --Tibia:SetStatusbarText("You cannot spy below the default ground level!")
    --return
--end

-- get spy level
local spyLevel = 0
if currentLevel <= Tibia.Constants.LevelSpy.Min then
    spyLevel = Tibia.Constants.LevelSpy.Max -- loop back to start
else
    spyLevel = currentLevel - 1 -- decrease spy level
end

-- level spy down
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
