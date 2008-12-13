-- get outfit
local playerOutfit = tibia_getplayeroutfit()

-- loop back to end
if playerOutfit == MIN_OUTFIT then
    playerOutfit = MAX_OUTFIT + 1
end

-- get previous outfit
while true do
    playerOutfit = playerOutfit - 1

    -- avoid client crash
    if tibia_isoutfiterror(playerOutfit) == false then break end
end

-- set outfit
tibia_setplayeroutfit(playerOutfit)
tibia_setstatusbartext("Previous Outfit: " .. tibia_getplayeroutfit())
