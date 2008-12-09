local function number_with_commas(value)
    local newValue = value
    while true do  
        newValue, found = string.gsub(newValue, "^(-?%d+)(%d%d%d)", '%1,%2')
        if found == 0 then break end
    end
    return newValue
end

tibia_setstatusbartext("Experience needed to level up: " .. number_with_commas(tibia_calcexptolevelup()))
