local composer = require( "composer" )
local widget = require("widget")
local native = require("native")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


-- 
-- widget function events 
--

local function event_start_generation(event)
   
    
    composer.gotoScene( "scenes.grid-scene" )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local buttonGroup = display.newGroup()


    local textGridX = display.newText(
        {
            text = "Grid size X: ",
            x = display.contentCenterX,
            y = display.contentCenterY - 240,
        }
    )
    local textfield_GridX = native.newTextField( 
        display.contentCenterX,
        display.contentCenterY - 200,
        100,
        40 )
    textfield_GridX.inputType = "number"
    textfield_GridX.text = "1"

     local textGridY = display.newText(
        {
            text = "Grid size Y: ",
            x = display.contentCenterX,
            y = display.contentCenterY - 140,
        }
    )
    local textfield_GridY = native.newTextField( 
        display.contentCenterX,
        display.contentCenterY - 100,
        100,
        20
     )
    
    local textIterationSpeed = display.newText(
        {
            text = "Iteration speed: ",
            x = display.contentCenterX,
            y = display.contentCenterY - 40,
        }
    )
    local textfield_IterationSpeed = native.newTextField( 
        display.contentCenterX,
        display.contentCenterY,
        100,
        20
     )

     local textRandomSeed = display.newText(
        {
            text = "Random seed: ",
            x = display.contentCenterX,
            y = display.contentCenterY + 60,
        }
    )
    local textFieldRandomSeed = native.newTextField(
        display.contentCenterX,
        display.contentCenterY + 100,
        200,
        100
     )

    local buttonStartGame = widget.newButton( 
        {
            id = "button_StartGame",
            label = "Start Generation",
            x = display.contentCenterX,
            y = display.contentCenterY + 200,
            width = 200,
            height = 100
        }
    )

    -- anonymous functions and closures
    local function textListener(event, composerTarget)
        if event.phase == "ended" or event.phase == "submitted" then
            composer.setVariable( composerTarget, event.target.text )
            print(composerTarget.." "..composer.getVariable( composerTarget ))
            return
        end
    end

    textfield_GridX:addEventListener("userInput", function(target) textListener(target, "gridSizeX") end)
    textfield_GridY:addEventListener("userInput", function(target) textListener(target, "gridSizeY") end)
    textfield_IterationSpeed:addEventListener("userInput", function(target) textListener(target, "iterationSpeed") end)

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