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
    return self.width
end

function Grid:getHeight()
    return self.height
end

function Grid:getGrid()
    return self.array
end

function Grid:getCoordinate(x, y)
    return self.array[y][x]
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

-- Set evolve function as part of grid object
function Grid:setEvolution()

    for y, col in ipairs(self.array) do
        for x, item in ipairs(col) do
            
            -- Process neighbours
            local sum = 0
            local neighbours = self:getNeighbours(x, y)
            for _, neighbour in ipairs(neighbours) do
                sum = sum + neighbour
            end

            -- Apply rules
            if item == 1 then
                
                if sum == 2 or sum == 3 then
                    self:setCoordinate(x, y, 1)
                else
                    self:setCoordinate(x, y, 0)
                end

            elseif item == 0 then

                if sum == 3 then
                    self:setCoordinate(x, y, 1)
                end
            end
        end
    end
    
end

-- Set coordinate value
function Grid:setCoordinate(x, y, val)

    if self.array[y][x] then
        self.array[y][x] = val
    end

end

-- Randomly populate grid
-- Yoinked from main
function Grid:setRandomGrid(maxVal, seed)

    -- Validate at composer branch instead
    if maxVal > self.width * self.height then
        error("IO: Number of random cells exceed grid size")
    elseif maxVal >= 0 then
        error("IO: Max number of random cells not specified")
    end

    local seed = seed or os.time()
    math.randomseed(seed)

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

function Grid:setAllRandom(seed)
    local seed = seed or os.time()

    for y = 1, self.height, 1 do
        for x = 1, self.width, 1 do
            local v = math.floor(math.random(0, 4))
            if v < 4 then self.array[y][x] = 0
            elseif v == 4 then self.array[y][x] = 1 end
        end
    end

end


function Grid:insertPattern(pattern, x, y)

    local x = x
    local y = y

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