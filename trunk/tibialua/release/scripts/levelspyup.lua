-- level spy must be enabled
if tibia_islevelspyenabled() == false then
    tibia_setstatusbartext("Please enable Level Spy first!")
    return
end

-- get player z
local playerZ = tibia_getplayerz()

-- get ground level
local groundLevel = 0
if playerZ <= Z_AXIS_DEFAULT then
    -- above ground
    groundLevel = LEVELSPY_ABOVE
else
    -- below ground
    groundLevel = LEVELSPY_BELOW
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
