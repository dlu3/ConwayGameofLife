-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--[[

    Allow random or user-input start state
    Allow pauses/restarts
    Allow simulation stop
    Allow to back to start
    Allor random seeds for init simulation state
    Allow saves
    Allow adjustment of iteration speed

    Cells --> Grid --> Display

    Cells/Grid do not store display information, handled by Display
    Cell checking for    


]]

require "cell"
require "grid"

local gridSizeX = 5
local gridSizeY = 5

-- Draws grid
function draw_grid(array)
    for _, y in ipairs(array:getGrid()) do
        local row = {}
        for _, item in ipairs(y) do
            
            if item == 1 then
                table.insert(row, "#")
            else
                table.insert(row, "O")
            end

        end

        print( table.concat(row, " "))
    end
end

-- Iterate evolution
-- -- Holy balls this was a cluster headache
function iterate(grid)
    local current = grid:getGrid()
    local next = Grid:new(gridSizeX, gridSizeY)
    
    for y, col in ipairs(current) do
        local row = {}
        for x, item in ipairs(col) do
            
            -- Process neighbours
            local sum = 0
            local neighbours = grid:getNeighbours(x, y)
            for _, neighbour in ipairs(neighbours) do
                sum = sum + neighbour
            end

            -- Apply rules
            if item == 1 then
                
                if sum == 2 or sum == 3 then
                    next:setCoordinate(x, y, 1)
                else
                    next:setCoordinate(x, y, 0)
                end

            elseif item == 0 then

                if sum == 3 then
                    next:setCoordinate(x, y, 1)
                end
            end
        end
    end
    return next
end

local gridObject = Grid:new(gridSizeX, gridSizeY)

--[[ gridObject:setCoordinate(3, 2, 1)
gridObject:setCoordinate(3, 3, 1)
gridObject:setCoordinate(3, 4, 1) ]]

gridObject:setCoordinate(1, 1, 1)
gridObject:setCoordinate(2, 2, 1)
gridObject:setCoordinate(3, 2, 1)
gridObject:setCoordinate(1, 3, 1)
gridObject:setCoordinate(2, 3, 1)

local next = gridObject
print("starting:")
draw_grid(next)
print("")

for i=1, 5 do
    print("iteration: "..i)
    next = iterate(next)
    draw_grid(next)
    print("")
end