-- search through creatures
for i = Tibia.Addresses.Creatures.Begin, Tibia.Addresses.Creatures.End, Tibia.Addresses.Creatures.Step do
    -- get creature type
    local creatureType = tibia_readbytes(i + Tibia.Constants.Creatures.OffsetType, 1)

    -- check if creature is not an npc 
    if creatureType ~= Tibia.Constants.CreatureTypes.Npc then
        -- get creature id
        local creatureId = tibia_readbytes(i + Tibia.Constants.Creatures.OffsetId, 3)

        -- check if creature is not the player
        if creatureId ~= Tibia:GetPlayerId() then
            -- set creature outfit
            tibia_writebytes(i + Tibia.Constants.Creatures.OffsetOutfit, Tibia.Constants.Outfits.Cockroach, 4)
        end
    end
end
