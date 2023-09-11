Grid = {}
Grid.__index = Grid

local coordinates = {
    {x = -1, y = -1}, 
    {x = 0, y = -1}, 
    {x = 1, y = -1}, 
    {x = -1, y = 0},
    {x = 1, y = 0},
    {x = -1, y = 1},
    {x = 0, y = 1},
    {x = 1, y = 1}}

-- Init new grid from arguments
-- Note to self  : int cell looks bad, makes summing easy tho
-- Note to self 2: next time, read up how metatables relate to oop
function Grid:new(width, height)
    local self = setmetatable({}, Grid)

    self.width = width or 0
    self.height = height or 0
    self.array = {}
    
    -- generate 2d array
    for w = 0, width do
        self.array[w] = {}
        for y = 0, height do
            self.array[w][y] = 0
        end
    end

    return self
end

-- Get 8 neighbours of x,y coordinates
function Grid:getNeighbours(x, y)
    local neighbours = {}
    for _, coords in ipairs(coordinates) do
        local xcoord, ycoord = x + coords.x, y + coords.y
        if self.array[ycoord] and self.array[ycoord][xcoord] then
            table.insert(neighbours, self.array[ycoord][xcoord])
        end
    end
    return neighbours
end

-- Set coordinate value
function Grid:setCoordinate(x, y, val)

    if self.array[y][x] then
        self.array[y][x] = val
    end

end

function Grid:getGrid()
    return self.array
end

function Grid:getCoordinate(x, y)
    return self.array[y][x]
end

function Grid:insertPattern(pattern, x, y)

    x = x or 0
    y = y or 0

    for patternX, col in ipairs(pattern) do
        for patternY,_ in ipairs(col) do
            if self.getCoordinate(patternX + x, patternY + y) then
               self.setCoordinate(patternX + x, patternY + y) 
            end
        end
    end
end
