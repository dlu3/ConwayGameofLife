-- Empties display objects of children
function clear_children(object, offset)
    local offset = offset or 0
    while object.numChildren > 0 + offset do
        local child = object[1 + offset]
        if child then child:removeSelf() child = nil end
    end
    return object
end

function draw_grid(gridObject)
    local offset = drawCellSize / 2
    gridGroup = clear_children(gridGroup, 1)

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
