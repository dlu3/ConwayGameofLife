Pattern = {}
Pattern.__index = Pattern

local patterns = {
    blinker_h = {
        {1, 1},
        {2, 1},
        {3, 1}
    },
    blinker_v = {
        {1, 1},
        {1, 2},
        {1, 3}
    },
    block = {
        {1, 1},
        {2, 1},
        {1, 2},
        {2, 2}
    },
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