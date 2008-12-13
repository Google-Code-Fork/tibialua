-- initialize the pseudo random number generator
math.randomseed(os.time())

-- to number with commas
function to_numberwithcommas(value)
    local newValue = value
    while true do  
        newValue, found = string.gsub(newValue, "^(-?%d+)(%d%d%d)", '%1,%2')
        if found == 0 then break end
    end
    return newValue
end
