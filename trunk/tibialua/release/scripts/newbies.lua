-- search through creatures
for i = CREATURES_BEGIN, CREATURES_END, STEP_CREATURE do
    -- get creature type
    local creatureType = tibia_readbytes(i + OFFSET_CREATURE_TYPE, 1)

    -- check if creature is not an npc 
    if creatureType ~= CREATURE_TYPE_NPC then
        -- get creature id
        local creatureId = tibia_readbytes(i + OFFSET_CREATURE_ID, 3)

        -- check if creature is not the player
        if creatureId ~= tibia_getplayerid() then
            -- get creature outfit
            local creatureOutfitId = tibia_readbytes(i + OFFSET_CREATURE_OUTFIT, 4)

            -- check if creature is male
            if tibia_isoutfitmale(creatureOutfitId) == true then
                -- set creature outfit
                tibia_writebytes(i + OFFSET_CREATURE_OUTFIT, OUTFIT_MALE_CITIZEN, 4)
            end

            -- check if creature is female
            if tibia_isoutfitfemale(creatureOutfitId) == true then
                -- set creature outfit
                tibia_writebytes(i + OFFSET_CREATURE_OUTFIT, OUTFIT_FEMALE_CITIZEN, 4)
            end

            -- set creature outfit addon
            tibia_writebytes(i + OFFSET_CREATURE_OUTFIT_ADDON, OUTFIT_ADDON_NONE, 1)

            -- set creature outfit colors
            tibia_writebytes(i + OFFSET_CREATURE_OUTFIT_HEAD, OUTFIT_COLORS_NEWBIE[1], 1)
            tibia_writebytes(i + OFFSET_CREATURE_OUTFIT_BODY, OUTFIT_COLORS_NEWBIE[2], 1)
            tibia_writebytes(i + OFFSET_CREATURE_OUTFIT_LEGS, OUTFIT_COLORS_NEWBIE[3], 1)
            tibia_writebytes(i + OFFSET_CREATURE_OUTFIT_FEET, OUTFIT_COLORS_NEWBIE[4], 1)
        end
    end
end
