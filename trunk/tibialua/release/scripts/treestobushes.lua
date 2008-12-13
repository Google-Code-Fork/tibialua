tibia_setstatusbartext("Replacing trees with bushes...")

-- get map
local mapBegin = tibia_getmappointer()
local mapEnd   = mapBegin + (STEP_MAP_TILE * MAX_MAP_TILES)

-- search through map
for i = mapBegin, mapEnd, STEP_MAP_TILE do
    local j = 0

    -- search through map objects on tile
    while j < MAX_MAP_TILE_OBJECTS do
        -- get object id address
        local objectIdAddress = i + OFFSET_MAP_OBJECT_ID + (j * STEP_MAP_OBJECT)

        -- get object id
        local objectId = tibia_readbytes(objectIdAddress, 2)

        -- check if object id is a tree
        for k = 1, table.getn(OBJECT_TREES) do
            if objectId == OBJECT_TREES[k] then
                -- replace object id with a bush
                tibia_writebytes(objectIdAddress, OBJECT_BUSH, 2);
            end
        end

        -- next map object on tile
        j = j + 1
    end
end

tibia_setstatusbartext("Trees To Bushes")
