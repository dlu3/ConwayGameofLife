local composer = require( "composer" )
local widget = require("widget")
local native = require("native")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local labelWidth = 100
local labelHeight = 0
local fieldWidth = 100
local fieldHeight = 30

local centerOffsetMultiplier = 0.6

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
            align = "right",
            width = labelWidth,
            height = labelHeight,
            x = display.contentCenterX - labelWidth * centerOffsetMultiplier,
            y = display.contentCenterY - 240,

        }
    )
    local textfield_GridX = native.newTextField( 
        display.contentCenterX + fieldWidth * centerOffsetMultiplier,
        display.contentCenterY - 240,
        fieldWidth,
        fieldHeight 
    )
    textfield_GridX.inputType = "number"
    textfield_GridX.text = tostring(composer.getVariable("gridSizeX"))

    -- Height
     local textGridY = display.newText(
        {
            text = "Grid Height: ",
            align = "right",
            width = labelWidth,
            height = labelHeight,
            x = display.contentCenterX - labelWidth * centerOffsetMultiplier,
            y = display.contentCenterY - 190,
        }
    )
    local textfield_GridY = native.newTextField( 
        display.contentCenterX + fieldWidth * centerOffsetMultiplier,
        display.contentCenterY - 190,
        fieldWidth,
        fieldHeight
    )
    textfield_GridY.inputType = "number"
    textfield_GridY.text = tostring(composer.getVariable("gridSizeY"))

    
    -- Speed
    local textIterationSpeed = display.newText(
        {
            text = "Iteration speed: ",
            align = "right",
            width = labelWidth,
            height = labelHeight,
            x = display.contentCenterX - labelWidth * centerOffsetMultiplier,
            y = display.contentCenterY - 140,
        }
    )
    local textfield_IterationSpeed = native.newTextField( 
        display.contentCenterX + fieldWidth * centerOffsetMultiplier,
        display.contentCenterY - 140,
        fieldWidth,
        fieldHeight
    )
    textfield_IterationSpeed.inputType = "number"
    textfield_IterationSpeed.text = tostring(composer.getVariable("iterationSpeed"))

    -- -- Random -- --
    -- Check Random
    local textDoRandom = display.newText(
        {
            text = "Do Random?",
            align = "right",
            width = labelWidth,
            height = labelHeight,
            x = display.contentCenterX - labelWidth * centerOffsetMultiplier,
            y = display.contentCenterY -90,
        }
    )
    local switch_DoRandom = widget.newSwitch(
        {
            x = display.contentCenterX + 30,
            y = display.contentCenterY - 90,
            style = "checkbox"
        }
    )

    -- Seed Option
    local textRandomSeed = display.newText(
        {
            text = "Random seed: ",
            align = "right",
            width = labelWidth,
            height = labelHeight,
            x = display.contentCenterX - labelWidth * centerOffsetMultiplier,
            y = display.contentCenterY - 40,
        }
    )
    local textfield_RandomSeed = native.newTextField(
        display.contentCenterX + fieldWidth * centerOffsetMultiplier,
        display.contentCenterY - 40,
        fieldWidth,
        fieldHeight
    )
    textfield_RandomSeed.inputType = "number"
    textfield_RandomSeed.text = tostring(composer.getVariable("randomSeed"))
    

    -- Start button
    local buttonStartGame = widget.newButton( 
        {
            id = "button_StartGame",
            label = "Start Generation",
            x = display.contentCenterX,
            y = display.contentCenterY + 200,
            width = 150,
            height = 50,
            shape = "roundedRect",
            onRelease = function(event)
                composer.gotoScene("scenes.grid-scene", 
                {
                    effect = "fade",
                    time = 1000,
                    params = {
                        width = composer.getVariable("gridSizeX"),
                        height = composer.getVariable("gridSizeY"),
                        speed = composer.getVariable("iterationSpeed"),
                        random = switch_DoRandom.isOn
                }
                })
                composer.removeScene("scenes.config-scene")
            end
        }
    )
    buttonStartGame.fillColor = { default = {1, 0, 0, 1}, over = {1, 0.1, 0.7, 0.4}}

    sceneGroup:insert(textGridX)
    sceneGroup:insert(textGridY)
    sceneGroup:insert(textIterationSpeed)
    sceneGroup:insert(textDoRandom)
    sceneGroup:insert(textRandomSeed)

    sceneGroup:insert(textfield_GridX)
    sceneGroup:insert(textfield_GridY)
    sceneGroup:insert(textfield_IterationSpeed)
    sceneGroup:insert(switch_DoRandom)
    sceneGroup:insert(textfield_RandomSeed)

    sceneGroup:insert(buttonStartGame)

    textfield_RandomSeed.isVisible = false
    textRandomSeed.isVisible = false

    -- Switch handler
    local function handleRandomListener(event)
        if event.target.isOn == true then
            textRandomSeed.isVisible = true
            textfield_RandomSeed.isVisible = true
            
        elseif event.target.isOn == false then
            textRandomSeed.isVisible = false
            textfield_RandomSeed.isVisible = false
        end
    end

    

    -- anonymous function and closure
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
    switch_DoRandom:addEventListener("tap", handleRandomListener)
    textfield_RandomSeed:addEventListener("userInput", function(target) variableListener(target, "randomSeed") end)

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