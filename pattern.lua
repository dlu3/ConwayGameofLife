Pattern = {}
Pattern.__index = Pattern

local patterns = {
   glider_r = {
        {3, 1},
        {1, 2},
        {3, 2},
        {2, 3},
        {3, 3}},
    lightweight_spaceship_r = {
        {1, 1},
        {4, 1},
        {5, 2},
        {1, 3},
        {5, 3},
        {2, 4},
        {3, 4},
        {4, 4},
        {5, 4}}
}

-- Get from local table
function Pattern:getPattern(patternName)
    return patterns[patternName]
end