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

local displayX = display.contentWidth
local displayY = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local gridSizeX = 50
local gridSizeY = 50

local minCellSize = 2
local maxCellSize = 20
local cellSize = math.min(displayX / gridSizeX, displayY / gridSizeY)
-- Clamp cell size
local drawCellSize = (cellSize > maxCellSize and maxCellSize) or 
                     (cellSize < minCellSize and minCellSize) or
                     (cellSize)

local gridGroup = display.newGroup()
gridGroup.x = centerX - (drawCellSize*gridSizeX)/2
gridGroup.y = centerY - (drawCellSize*gridSizeY)/2


-- Empties display objects of children
function clear_children(object)

    while object.numChildren > 0 do
        local child = object[1]
        if child then child:removeSelf() end
    end

    return object
end

function draw_grid(gridObject)
    local offset = drawCellSize / 2
    gridGroup = clear_children(gridGroup)

    for y, col in ipairs(gridObject:getGrid()) do
        for x, item in ipairs(col) do
            
            if item == 1 then
                local cellObject = display.newCircle(
                    drawCellSize * x - offset,
                    drawCellSize * y - offset,
                    drawCellSize / 2)
                gridGroup:insert(cellObject)

            end
        end
    end
end

-- Iterate evolution
-- -- Holy balls this was a cluster headache
function evolve(grid)
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

function test()
    next = evolve(next)
    draw_grid(next)
end

timer.performWithDelay(100, test, 50)
