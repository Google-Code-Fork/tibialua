-- search through creatures
for i = Tibia.Addresses.Creatures.Begin, Tibia.Addresses.Creatures.End, Tibia.Constants.Creatures.Step do
    -- get creature type
    local creatureType = tibia_readbytes(i + Tibia.Constants.Creatures.OffsetType, 1)

    -- check if creature is not an npc 
    if creatureType ~= Tibia.Constants.CreatureTypes.Npc then
        -- get creature id
        local creatureId = tibia_readbytes(i + Tibia.Constants.Creatures.OffsetId, 3)

        -- check if creature is not the player
        if creatureId ~= Tibia:GetPlayerId() then
            -- get creature outfit
            local creatureOutfitId = tibia_readbytes(i + Tibia.Constants.Creatures.OffsetOutfit, 4)

            -- check if creature is male
            if Tibia:IsOutfitMale(creatureOutfitId) == true then
                -- set creature outfit
                tibia_writebytes(i + Tibia.Constants.Creatures.OffsetOutfit, Tibia.Constants.Outfits.MaleCitizen, 4)
            end

            -- check if creature is female
            if Tibia:IsOutfitFemale(creatureOutfitId) == true then
                -- set creature outfit
                tibia_writebytes(i + Tibia.Constants.Creatures.OffsetOutfit, Tibia.Constants.Outfits.FemaleCitizen, 4)
            end

            -- set creature outfit addon
            tibia_writebytes(i + Tibia.Constants.Creatures.OffsetOutfitAddon, Tibia.Constants.OutfitAddons.None, 1)

            -- set creature outfit colors
            tibia_writebytes(i + Tibia.Constants.Creatures.OffsetOutfitHead, OUTFIT_COLORS_NEWBIE[1], 1)
            tibia_writebytes(i + Tibia.Constants.Creatures.OffsetOutfitBody, OUTFIT_COLORS_NEWBIE[2], 1)
            tibia_writebytes(i + Tibia.Constants.Creatures.OffsetOutfitLegs, OUTFIT_COLORS_NEWBIE[3], 1)
            tibia_writebytes(i + Tibia.Constants.Creatures.OffsetOutfitFeet, OUTFIT_COLORS_NEWBIE[4], 1)
        end
    end
end
