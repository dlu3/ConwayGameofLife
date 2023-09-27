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
function Grid:new(width, height)
    local self = setmetatable({}, Grid)

    self.width = width or 1
    self.height = height or 1
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

function Grid:getWidth()
    return self.x
end

function Grid:getHeight()
    return self.y
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

    x = x
    y = y

    for _, coordinates in ipairs(pattern) do
        patternX = coordinates[1]
        patternY = coordinates[2]

        print(patternX.." "..patternY)

        if self:getCoordinate(patternX + x, patternY + y) then
            self:setCoordinate(patternX + x, patternY + y, 1) 
         end

    end
end
