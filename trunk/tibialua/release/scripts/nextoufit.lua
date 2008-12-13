-- get outfit
local playerOutfit = tibia_getplayeroutfit()

-- loop back to start
if playerOutfit == MAX_OUTFIT then
    playerOutfit = MIN_OUTFIT - 1
end

-- get next outfit
while true do
    playerOutfit = playerOutfit + 1

    -- avoid client crash
    if tibia_isoutfiterror(playerOutfit) == false then break end
end

-- set outfit
tibia_setplayeroutfit(playerOutfit)
tibia_setstatusbartext("Next Outfit: " .. tibia_getplayeroutfit())
