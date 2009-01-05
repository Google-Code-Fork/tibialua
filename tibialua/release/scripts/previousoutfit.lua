-- get outfit
local playerOutfit = Tibia:GetPlayerOutfit()

-- loop back to end
if playerOutfit == Tibia.Constants.Outfits.Min then
    playerOutfit = Tibia.Constants.Outfits.Max + 1
end

-- get previous outfit
while true do
    playerOutfit = playerOutfit - 1

    -- avoid client crash
    if Tibia:IsOutfitError(playerOutfit) == false then break end
end

-- set outfit
Tibia:SetPlayerOutfit(playerOutfit)
Tibia:SetStatusbarText("Previous Outfit: " .. Tibia:GetPlayerOutfit())
