Tibia:SetStatusbarText("Replacing trees with bushes...")

-- get map
local mapBegin = Tibia:GetMapPointer()
local mapEnd   = mapBegin + (Tibia.Constants.Map.StepTile * Tibia.Constants.Map.MaxTiles)

-- number of trees replaced
local numTreesReplaced = 0

-- search through map
for i = mapBegin, mapEnd, Tibia.Constants.Map.StepTile do
    -- get tile object count address
    local tileObjectCountAddress = i + Tibia.Constants.Map.OffsetTileObjectCount

    -- get tile object count
    local tileObjectCount = tibia_readbytes(tileObjectCountAddress, 4)

    -- search through map objects on tile
    for j = 0, tileObjectCount do
        -- get object id address
        local objectIdAddress = i + Tibia.Constants.Map.OffsetObjectId + (j * Tibia.Constants.Map.StepObject)

        -- get object id
        local objectId = tibia_readbytes(objectIdAddress, 4)

        -- check if object id is a tree
        for k = 1, table.getn(Tibia.Constants.Objects.Trees) do
            if objectId == Tibia.Constants.Objects.Trees[k] then
                -- replace object id with a bush
                tibia_writebytes(objectIdAddress, Tibia.Constants.Objects.Bush, 4);

                -- increment number of trees replaced
                numTreesReplaced = numTreesReplaced + 1
            end
        end
    end
end

Tibia:SetStatusbarText("Trees To Bushes! Replaced " .. numTreesReplaced .. " tree(s) with bushes.")
