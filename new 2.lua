require "cell"
require "grid"

local displayX = display.contentWidth
local displayY = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local gridSizeX = 5
local gridSizeY = 5
local cellSize = 20
local maxWidth = 200
local maxHeight = 200

local gridGroup = display.newGroup()
gridGroup.x = centerX - (cellSize*gridSizeX)/2
gridGroup.y = centerY - maxHeight

-- Draws grid
function display_grid(array)

end

for x=1, gridSizeX do
    for y=1, gridSizeY do

        local offset = cellSize / 2

        local cell = display.newCircle(
			cellSize*x-offset, 
			cellSize*y-offset, 
			cellSize/2)
        gridGroup:insert(cell)
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