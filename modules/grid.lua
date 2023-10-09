Grid = {}
Grid.__index = Grid

-- List of relative neighbour coordinates.
local coordinates = {
    {x = -1, y = -1}, 
    {x = 0, y = -1}, 
    {x = 1, y = -1}, 
    {x = -1, y = 0},
    {x = 1, y = 0},
    {x = -1, y = 1},
    {x = 0, y = 1},
    {x = 1, y = 1}}

--- Creates new grid.
-- @param width int: grid width.
-- @param height int: grid height.
-- @return self: Grid object.
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

-- Getters.

--- Gets grid width.
-- @return width int: int representing width.
function Grid:get_width()
    return self.width
end

--- Gets grid height.
-- @return height int: int representing height.
function Grid:get_height()
    return self.height
end

--- Gets Grid's 2D array.
-- @return table: table representing grid's 2D array.
function Grid:get_grid()
    return self.array
end

--- Gets value of grid coordinate.
-- @param x int: position at x.
-- @param y int: position at y.
-- @return int: value at coordinate.
function Grid:get_coordinate(x, y)
    return self.array[y][x]
end

--- Gets 8 neighbouring cells of specific coordinate.
-- @param x int: position at x.
-- @param y int: position at y.
-- @return table: a table containing values of neighbouring cells.
-- FIXME: Isn't grabbing all neighbours correctly
function Grid:get_neighbours(x, y)
    local neighbours = {}
    for i=1, #coordinates do
        local xcoord, ycoord = x + coordinates[i].x, y + coordinates[i].y
        if self.array[ycoord] and self.array[ycoord][xcoord] then -- Check if coordinate exists
            neighbours[#neighbours+1] = self.array[ycoord][xcoord]
        end
    end
    return neighbours
end

-- Setters.

--- Sets value at grid coordinate.
-- @param x int: position at x.
-- @param y int: position at y.
-- @param val int: int to be set, although technically can be any type,
-- will break code if int isn't used
function Grid:set_coordinate(x, y, val)
    if self.array[y][x] then
        self.array[y][x] = val
    end
end

--- Copies array from parameter and sets to self.
-- Assumes array is from grid object.
-- Does not validate size.
-- @param array table: the array to be copied.
function Grid:copy_grid(array)
    for y = 1, #self.array do
        for x = 1, #self.array[y] do
            self:set_coordinate(x, y, array[y][x])
        end
    end
end

--- Randomly sets all grid coordinates to 1s or 0s.
-- @param seed int: random seed number.
function Grid:set_all_random(seed)
    local seed = seed or os.time()
    math.randomseed(seed)
    for y = 1, self.height, 1 do
        for x = 1, self.width, 1 do
            local v = math.floor(math.random(0, 1)) -- Int values only
            self.array[y][x] = v
        end
    end
end

--- Simulate rules of Conway's Game of Life
-- and modify own grid
function Grid:set_evolution()
    for y = 1, #self.array do
        for x = 1, #self.array[y] do

            -- Get and process neighbours
            local sum = 0
            local neighbours = self:get_neighbours(x, y)
            for i = 1, #neighbours do
                sum = sum + neighbours[i]
            end

            -- Apply rules
            if self.array[y][x] == 1 then
                if sum == 2 or sum == 3 then
                    self:set_coordinate(x, y, 1)
                else
                    self:set_coordinate(x, y, 0)
                end

            elseif self.array[y][x] == 0 then
                if sum == 3 then
                    self:set_coordinate(x, y, 1)
                end
            end
        end
    end
end

return Grid