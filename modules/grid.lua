Grid = {}
Grid.__index = Grid

-- List of relative neighbour coordinates
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

    for _, coordinates in ipairs(pattern) do
        patternX = coordinates[1]
        patternY = coordinates[2]
        if self:getCoordinate(patternX + x, patternY + y) then
            self:setCoordinate(patternX + x, patternY + y, 1) 
         end

    end
end

-- From 19th 12:19 AM
function Grid:setRandomGrid(maxVal)

    -- Validate at composer branch instead
    if maxVal > self.width * self.height then
        error("IO: Number of random cells exceed grid size")
    end

    local iteration = 1
    while iteration < maxVal do
        
        local randX = math.random(1, self.width)
        local randY = math.random(1, self.height)

        while self:getCoordinate(randX, randY) == 1 do
            randX = math.random(1, self.width)
            randY = math.random(1, self.height)
        end

        self:setCoordinate(randX, randY, 1)
        iteration = iteration + 1

    end
    print(iteration)

end