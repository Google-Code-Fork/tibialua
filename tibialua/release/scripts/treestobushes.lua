tibia_setstatusbartext("Replacing trees with bushes...")

-- get map
local mapBegin = tibia_getmappointer()
local mapEnd   = mapBegin + (STEP_MAP_TILE * MAX_MAP_TILES)

-- number of trees replaced
local numTreesReplaced = 0

-- search through map
for i = mapBegin, mapEnd, STEP_MAP_TILE do
    -- get tile object count address
    local tileObjectCountAddress = i + OFFSET_MAP_TILE_OBJECT_COUNT

    -- get tile object count
    local tileObjectCount = tibia_readbytes(tileObjectCountAddress, 4)

    -- search through map objects on tile
    for j = 0, tileObjectCount do
        -- get object id address
        local objectIdAddress = i + OFFSET_MAP_OBJECT_ID + (j * STEP_MAP_OBJECT)

        -- get object id
        local objectId = tibia_readbytes(objectIdAddress, 4)

        -- check if object id is a tree
        for k = 1, table.getn(OBJECT_TREES) do
            if objectId == OBJECT_TREES[k] then
                -- replace object id with a bush
                tibia_writebytes(objectIdAddress, OBJECT_BUSH, 4);

                -- increment number of trees replaced
                numTreesReplaced = numTreesReplaced + 1
            end
        end
    end
end

tibia_setstatusbartext("Trees To Bushes! Replaced " .. numTreesReplaced .. " tree(s) with bushes.")
