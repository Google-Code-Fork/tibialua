-- search through creatures
for i = Tibia.CREATURES_BEGIN, Tibia.CREATURES_END, Tibia.STEP_CREATURE do
    -- get creature type
    local creatureType = tibia_readbytes(i + Tibia.OFFSET_CREATURE_TYPE, 1)

    -- check if creature is not an npc 
    if creatureType ~= Tibia.CREATURE_TYPE_NPC then
        -- get creature id
        local creatureId = tibia_readbytes(i + Tibia.OFFSET_CREATURE_ID, 3)

        -- check if creature is not the player
        if creatureId ~= Tibia:GetPlayerId() then
            -- set creature outfit
            tibia_writebytes(i + Tibia.OFFSET_CREATURE_OUTFIT, Tibia.OUTFIT_COCKROACH, 4)
        end
    end
end
