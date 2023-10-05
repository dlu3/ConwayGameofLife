local composer = require( "composer" )
local grid =     require( "modules.grid" )
local pattern =  require( "modules.pattern" )
local evolve =   require( "modules.evolve" )


local scene = composer.newScene()
local widget = require("widget")
local native = require("native")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Init variables
local displayX = display.contentWidth
local displayY = display.contentHeight

local width = composer.getVariable( "gridSizeX" )
local height = composer.getVariable( "gridSizeY" )
local iterationSpeed = composer.getVariable( "iterationSpeed" )
local randomSeed = composer.getVariable( "randomSeed" )

local minCellSize = 1
local maxCellSize = 20
local cellSize = math.min(
    displayX / width, 
    displayY / height )

-- clamp cell sizes
local drawCellSize = (cellSize > maxCellSize and maxCellSize) or 
                     (cellSize < minCellSize and minCellSize) or
                     (cellSize)

local gridObject = Grid:new(width, height)

local function draw_grid(gridObject, displayGroup, cellSize)
    local offset = cellSize / 2

    -- Merge children clearer into function
    while displayGroup.numChildren > 1 do
        local child = displayGroup[2]
        if child then child:removeSelf() child = nil end
    end

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

local function iterate(grid, display)
    grid:setEvolution()
    draw_grid(grid, display, drawCellSize)
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local gridGroup = display.newGroup()
    gridGroup.x = display.contentCenterX - (drawCellSize * width) * 0.5
    gridGroup.y = 0

    local controlGroup = display.newGroup()    

    local background = display.newRect(
        drawCellSize * width/ 2,
        drawCellSize * height / 2,
        drawCellSize * width,
        drawCellSize * height )
    background.strokeWidth = 3
    background:setFillColor(0)
    background:setStrokeColor(1, 0, 0)
    gridGroup:insert(background)

    local buttonPlay = widget.newButton( 
        {
            id = "button_StartEvolution",
            label = "Start Evolution",
            x = display.contentCenterX,
            y = display.contentCenterY + 200,
            width = 200,
            height = 100,
            onRelease = function(event)
                timer.performWithDelay( 500, iterate(gridObject, gridGroup), 200 )
            end
        }
    )

    gridObject:setAllRandom()
    draw_grid(gridObject, gridGroup, drawCellSize)

end

-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        


    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen



    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

