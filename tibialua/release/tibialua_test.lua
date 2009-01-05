print("Hello World!")

print("Player ID: " .. Tibia:GetPlayerId())
print("Player Level: " .. Tibia:GetPlayerLevel())
print("Player EXP: " .. Tibia:GetPlayerExp())
print("Player X: " .. Tibia:GetPlayerX())
print("Player Y: " .. Tibia:GetPlayerY())
print("Player Z: " .. Tibia:GetPlayerZ())

if (Tibia:IsOutfitMale(Tibia:GetPlayerOutfit()) == true) then
    print("Player is male.")
else
    print("Player is female.")
end
