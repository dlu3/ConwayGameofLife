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

local playing = false
local minCellSize = 1
local maxCellSize = 20

local start = "Start"
local stop = "Stop"

local width = composer.getVariable( "gridSizeX" )
local height = composer.getVariable( "gridSizeY" )
local iterationSpeed = composer.getVariable( "iterationSpeed" )
local randomSeed = composer.getVariable( "randomSeed" )

-- clamp cell sizes
local smallestCellSize = math.min(
    display.contentWidth / width, 
    display.contentHeight / height )
local finalCellSize = (smallestCellSize > maxCellSize and maxCellSize) or 
                     (smallestCellSize < minCellSize and minCellSize) or
                     (smallestCellSize)

local startGrid = Grid:new(width, height)
local gridGroup = display.newGroup()
local controlGroup = display.newGroup()  

-- Display grid
local function draw_grid(gridObject, displayGroup)
    local offset = finalCellSize / 2

    -- Merge children clearer into function
    while displayGroup.numChildren > 1 do
        local child = displayGroup[2]
        if child then child:removeSelf() child = nil end
    end

    for y, col in ipairs(gridObject:getGrid()) do
        for x, item in ipairs(col) do
            
            if item == 1 then
                local cellObject = display.newCircle(
                    finalCellSize * x - offset,
                    finalCellSize * y - offset,
                    finalCellSize / 2)
                displayGroup:insert(cellObject)

            end
        end
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    local params = event.params
    
    -- Code here runs when the scene is first created but has not yet appeared on screen

    
    gridGroup.x = display.contentCenterX - (finalCellSize * width) * 0.5
    gridGroup.y = 0

    local background = display.newRect(
        finalCellSize * width/ 2,
        finalCellSize * height / 2,
        finalCellSize * width,
        finalCellSize * height )
    background.strokeWidth = 3
    background:setFillColor(0)
    background:setStrokeColor(1, 0, 0)
    gridGroup:insert(background)

    if params.random then startGrid:setAllRandom(randomSeed) end
    local nextGrid = startGrid
    draw_grid(nextGrid, gridGroup)
    
    timer.performWithDelay( 
        iterationSpeed, 
        function() 
            nextGrid:setEvolution() 
            draw_grid(nextGrid, gridGroup) end, 
        -1, 
        "play")
    timer.pause("play")

    local buttonPlay = widget.newButton( 
        {
            id = "button_StartEvolution",
            label = start,
            x = display.contentCenterX,
            y = display.contentCenterY + 200,
            width = 100,
            height = 50,
            -- Shape properties
            shape = "roundedRect",
            onRelease = function(event)
                if playing == false then
                    timer.resume("play")
                    event.target:setLabel(stop)
                    playing = true
                elseif playing == true then
                    timer.pause("play")
                    event.target:setLabel(start)
                    playing = false
                end
                
            end
        }
    )
    buttonPlay.fillColor = { default = {1, 0.2, 0.5, 0.7}, over = {1, 0.2, 0.5, 1}}
    buttonPlay.shape = "roundedRect"

    controlGroup:insert(buttonPlay)

end

-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    local params = event.params

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

