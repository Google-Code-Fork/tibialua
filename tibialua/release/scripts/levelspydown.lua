-- level spy must be enabled
if tibia_islevelspyenabled() == 0 then
    tibia_setstatusbartext("Please enable Level Spy first!")
    return
end

-- get player z
local playerZ = tibia_getplayerz()

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
