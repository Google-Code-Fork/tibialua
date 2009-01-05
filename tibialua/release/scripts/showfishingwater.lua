-- get map
local mapBegin = Tibia:GetMapPointer()
local mapEnd   = mapBegin + (Tibia.Constants.Map.StepTile * Tibia.Constants.Map.MaxTiles)

-- search through map
for i = mapBegin, mapEnd, Tibia.Constants.Map.StepTile do
    -- get tile id address
    local tileIdAddress = i + Tibia.Constants.Map.OffsetTileId

    -- get tile id
    local tileId = tibia_readbytes(tileIdAddress, 4)

    -- check if tile id is water with no fish
    for j = Tibia.Constants.Tiles.WaterNoFishBegin, Tibia.Constants.Tiles.WaterNoFishEnd + 1 do
        if tileId == j then
            -- replace tile id with lava
            tibia_writebytes(tileIdAddress, Tibia.Constants.Tiles.Lava, 4)
        end
    end
end
