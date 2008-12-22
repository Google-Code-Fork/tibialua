-- male outfits
local outfitsMale =
{
    OUTFIT_MALE_OLD,
    OUTFIT_MALE_CITIZEN,
    OUTFIT_MALE_HUNTER,
    OUTFIT_MALE_MAGE,
    OUTFIT_MALE_KNIGHT,
    OUTFIT_MALE_NOBLEMAN,
    OUTFIT_MALE_SUMMONER,
    OUTFIT_MALE_WARRIOR,
    OUTFIT_MALE_BARBARIAN,
    OUTFIT_MALE_DRUID,
    OUTFIT_MALE_WIZARD,
    OUTFIT_MALE_ORIENTAL,
    OUTFIT_MALE_PIRATE,
    OUTFIT_MALE_ASSASSIN,
    OUTFIT_MALE_BEGGAR,
    OUTFIT_MALE_SHAMAN,
    OUTFIT_MALE_NORSEMAN,
    OUTFIT_MALE_NIGHTMARE,
    OUTFIT_MALE_JESTER,
    OUTFIT_MALE_BROTHERHOOD,
    OUTFIT_MALE_DEMONHUNTER,
    OUTFIT_MALE_YALAHARIAN
}

-- female outfits
local outfitsFemale =
{
    OUTFIT_FEMALE_OLD,
    OUTFIT_FEMALE_CITIZEN,
    OUTFIT_FEMALE_HUNTER,
    OUTFIT_FEMALE_SUMMONER,
    OUTFIT_FEMALE_KNIGHT,
    OUTFIT_FEMALE_NOBLEMAN,
    OUTFIT_FEMALE_MAGE,
    OUTFIT_FEMALE_WARRIOR,
    OUTFIT_FEMALE_BARBARIAN,
    OUTFIT_FEMALE_DRUID,
    OUTFIT_FEMALE_WIZARD,
    OUTFIT_FEMALE_ORIENTAL,
    OUTFIT_FEMALE_PIRATE,
    OUTFIT_FEMALE_ASSASSIN,
    OUTFIT_FEMALE_BEGGAR,
    OUTFIT_FEMALE_SHAMAN,
    OUTFIT_FEMALE_NORSEMAN,
    OUTFIT_FEMALE_NIGHTMARE,
    OUTFIT_FEMALE_JESTER,
    OUTFIT_FEMALE_BROTHERHOOD,
    OUTFIT_FEMALE_DEMONHUNTER,
    OUTFIT_FEMALE_YALAHARIAN
}

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
            for j = 1, table.getn(outfitsMale) do
                if creatureOutfitId == outfitsMale[j] then
                    -- set creature outfit
                    tibia_writebytes(i + OFFSET_CREATURE_OUTFIT, OUTFIT_MALE_CITIZEN, 4)
                end
            end

            -- check if creature is female
            for k = 1, table.getn(outfitsFemale) do
                if creatureOutfitId == outfitsFemale[k] then
                    -- set creature outfit
                    tibia_writebytes(i + OFFSET_CREATURE_OUTFIT, OUTFIT_FEMALE_CITIZEN, 4)
                end
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
