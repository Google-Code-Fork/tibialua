-- get outfit
local playerOutfit = Tibia:GetPlayerOutfit()

-- loop back to start
if playerOutfit == Tibia.Constants.Outfits.Max then
    playerOutfit = Tibia.Constants.Outfits.Min - 1
end

-- get next outfit
while true do
    playerOutfit = playerOutfit + 1

    -- avoid client crash
    if Tibia:IsOutfitError(playerOutfit) == false then break end
end

-- set outfit
Tibia:SetPlayerOutfit(playerOutfit)
Tibia:SetStatusbarText("Next Outfit: " .. Tibia:GetPlayerOutfit())
