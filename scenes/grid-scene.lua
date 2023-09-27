local composer = require( "composer" )
local grid =     require(" modules.grid ")
local pattern =  require( "modules.pattern" )
local display =  require( "modules.display" )


local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Init variables
local displayX = display.contentWidth
local displayY = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local gridSizeX = composer.getVariable( "gridSizeX" )
local gridSizeY = composer.getVariable( "gridSizeY" )

local minCellSize = 1
local maxCellSize = 20
local cellSize = math.min(
    displayX / gridSizeX, 
    displayY / gridSizeY )

-- clamp cell sizes
local drawCellSize = (cellSize > maxCellSize and maxCellSize) or 
                     (cellSize < minCellSize and minCellSize) or
                     (cellSize)

local gridObject = Grid:new(gridSizeX, gridSizeY)

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local backgroundSizeX = drawCellSize * gridSizeX
    local backgroundSizeY = drawCellSize * gridSizeY
    local background = display.newRect(
        backgroundSizeX / 2,
        backgroundSizeY / 2,
        backgroundSizeX,
        backgroundSizeY )
    background.strokeWidth = 3
    background:setFillColor(0)
    background:setStrokeColor(1, 0, 0)
    sceneGroup:insert(background)

    

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

