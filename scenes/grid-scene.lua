local composer = require( "composer" )
local grid =     require( "modules.grid" )
local pattern =  require( "modules.pattern" )

local scene = composer.newScene()
local widget = require("widget")
local native = require("native")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local is_playing = false
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
local nextGrid = Grid:new(width, height)

local gridGroup = display.newGroup()
local controlGroup = display.newGroup()  

--- Clears children from a DisplayObject
-- @param group group object
-- @param offset highest index to not be removed
local function clear_children(group, offset)
    while group.numChildren > offset do
        local child = group[offset+1]
        if child then child:removeSelf() child = nil end
    end
end

--- Draws grid onto screen
-- @param gridObject the grid to be read from
-- @param displayGroup the display to draw grid into
local function draw_grid(gridObject, displayGroup)
    local offset = finalCellSize / 2 -- account for central anchor position
    local gridArray = gridObject:get_grid()
    clear_children(displayGroup, 1)

    for y = 1, #gridArray do
        for x = 1, #gridArray[y] do
            if gridArray[y][x] == 1 then
                -- Render grid cells as circles
                local cellObject = display.newCircle(
                    finalCellSize * x - offset,
                    finalCellSize * y - offset,
                    finalCellSize / 2)
                displayGroup:insert(cellObject)
            end
        end
    end
end

--- Functions to iterate per cycle
-- @param grid the grid to be evolved
-- @param group the group to be drawn in
local function iterate(grid, group)
    print("iterate")
    grid:set_evolution() 
    draw_grid(grid, group) 
end

--- Encloses iterate for use in timer functions
local function iterateClosure()
    return iterate(nextGrid, gridGroup)
end

--- Listener for evolution button
-- @param event tap event
local function play_life(event)
    local button = event.target
    if is_playing == false then
        timer.performWithDelay( iterationSpeed, iterateClosure, -1, "play" )
        button:setLabel(stop)
        is_playing = true
    elseif is_playing == true then
        timer.pause("play")
        button:setLabel(start)
        is_playing = false
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

    if params.random then startGrid:set_all_random(randomSeed) end
    nextGrid = startGrid
    draw_grid(nextGrid, gridGroup)

    --- Button for starting game
    local buttonPlay = widget.newButton( 
        {
            id = "button_StartEvolution",
            label = start,
            x = display.contentCenterX,
            y = display.contentCenterY + 200,
            width = 80,
            height = 40,
            -- Shape properties
            shape = "roundedRect",
            fillColor = { default = {1, 1, 1, 1}, over = {1, 1, 1, 0.7}},
            onRelease = play_life
        }
    )

    --- Button for restarting game
    local buttonRestart = widget.newButton( 
        {
            id = "button_StartEvolution",
            label = "Restart",
            x = display.contentCenterX - 100,
            y = display.contentCenterY + 200,
            width = 80,
            height = 40,
            -- Shape properties
            shape = "roundedRect",
            fillColor = { default = {1, 1, 1, 1}, over = {1, 1, 1, 0.7}},
            onRelease = function()
                timer.cancel( "play" )
                clear_children(gridGroup, 1)
                nextGrid = startGrid
                draw_grid(startGrid, gridGroup)
            end
        }
    )

    --- Button for creating new grid
    local buttonNewGrid = widget.newButton( 
        {
            id = "button_StartEvolution",
            label = "New Grid",
            x = display.contentCenterX + 100,
            y = display.contentCenterY + 200,
            width = 80,
            height = 40,
            -- Shape properties
            shape = "roundedRect",
            fillColor = { default = {1, 1, 1, 1}, over = {1, 1, 1, 0.7}},
            onRelease = function(event)
                timer.cancel( "play" )
                sceneGroup:removeSelf()
                composer.gotoScene("scenes.config-scene")
            end
        }
    )
  
    controlGroup:insert(buttonPlay)
    controlGroup:insert(buttonRestart)
    controlGroup:insert(buttonNewGrid)
    

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

