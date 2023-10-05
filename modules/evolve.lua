local evolve = {}

-- Empties display objects of children
function evolve.clear_children(object, offset)
    local offset = offset or 0
    while object.numChildren > 0 + offset do
        local child = object[1 + offset]
        if child then child:removeSelf() child = nil end
    end
    return object
end

function evolve.draw_grid(gridObject, displayGroup, cellSize)
    local offset = cellSize / 2
    displayGroup = evolve.clear_children(displayGroup, 1)

    for y, col in ipairs(gridObject:getGrid()) do
        for x, item in ipairs(col) do
            
            if item == 1 then
                local cellObject = display.newCircle(
                    cellSize * x - offset,
                    cellSize * y - offset,
                    cellSize / 2)
                displayGroup:insert(cellObject)

            end
        end
    end
end
