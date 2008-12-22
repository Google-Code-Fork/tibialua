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
            -- set creature outfit
            tibia_writebytes(i + OFFSET_CREATURE_OUTFIT, OUTFIT_COCKROACH, 4)
        end
    end
end
