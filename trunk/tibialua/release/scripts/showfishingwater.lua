-- get map
local mapBegin = tibia_getmappointer()
local mapEnd   = mapBegin + (STEP_MAP_TILE * MAX_MAP_TILES)

-- search through map
for i = mapBegin, mapEnd, STEP_MAP_TILE do
    -- get tile id address
    local tileIdAddress = i + OFFSET_MAP_TILE_ID

    -- get tile id
    local tileId = tibia_readbytes(tileIdAddress, 4)

    -- check if tile id is water with no fish
    for j = TILE_WATER_NO_FISH_BEGIN, TILE_WATER_NO_FISH_END + 1 do
        if tileId == j then
            -- replace tile id with lava
            tibia_writebytes(tileIdAddress, TILE_LAVA, 4)
        end
    end
end
