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

    -- Width
    local textGridX = display.newText(
        {
            text = "Grid Width: ",
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

    -- Height
     local textGridY = display.newText(
        {
            text = "Grid Height: ",
            x = display.contentCenterX,
            y = display.contentCenterY - 140,
        }
    )
    local textfield_GridY = native.newTextField( 
        display.contentCenterX,
        display.contentCenterY - 100,
        100,
        40
    )
    
    -- Speed
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

    -- Seed
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

    -- Start
    local buttonStartGame = widget.newButton( 
        {
            id = "button_StartGame",
            label = "Start Generation",
            x = display.contentCenterX,
            y = display.contentCenterY + 200,
            width = 200,
            height = 100,
            onRelease = function(event)
                composer.gotoScene("scenes.grid-scene", 
            {
                effect = "fade",
                time = 500,
                params = {
                    width = composer.getVariable("gridSizeX"),
                    height = composer.getVariable("gridSizeY"),
                    speed = composer.getVariable("iterationSpeed")
                }
            })
            end
        }
    )

    -- anonymous functions and closures
    local function variableListener(event, composerTarget)
        if event.phase == "ended" or event.phase == "submitted" then
            composer.setVariable( composerTarget, event.target.text )
            print(composerTarget.." "..composer.getVariable( composerTarget ))
            return
        end
    end
    
    textfield_GridX:addEventListener("userInput", function(target) variableListener(target, "gridSizeX") end)
    textfield_GridY:addEventListener("userInput", function(target) variableListener(target, "gridSizeY") end)
    textfield_IterationSpeed:addEventListener("userInput", function(target) variableListener(target, "iterationSpeed") end)


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