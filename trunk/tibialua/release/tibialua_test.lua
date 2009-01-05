print("Hello World!")

if (Tibia:IsOnline() == true) then
    print("Player is online.")
else
    print("Player is offline.")
end

if (Tibia:IsOutfitMale(Tibia:GetPlayerOutfit()) == true) then
    print("Player is male.")
elseif (Tibia:IsOutfitFemale(Tibia:GetPlayerOutfit()) == true) then
    print("Player is female.")
else
    print("Player not found.")
end

print("Player ID: " .. Tibia:GetPlayerId())
print("Player Level: " .. Tibia:GetPlayerLevel())
print("Player EXP: " .. Tibia:GetPlayerExp())
print("Player X: " .. Tibia:GetPlayerX())
print("Player Y: " .. Tibia:GetPlayerY())
print("Player Z: " .. Tibia:GetPlayerZ())
