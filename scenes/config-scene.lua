local composer = require( "composer" )
local widget = require("widget")
local native = require("native")
local validate = require("modules.validate")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- label and field sizes and positions.
local labelWidth = 100
local labelHeight = 0
local fieldWidth = 100
local fieldHeight = 30
local centerOffsetMultiplier = 0.6 -- Pushes objects away from centre.

-- range values for validation
local minWidth = 1
local maxWidth = 200
local minHeight = 1
local maxHeight = 200
local minSpeed = 1
local maxSpeed = math.huge
local minSeed = 0 
local maxSeed = math.huge

--- Closure function for specifically setting doRandom composer variable.
-- Includes hiding relevent objects.
-- @param event event: the SwitchWidget.
-- @param composerTarget string: name of composer variable.
-- @param ...: handle visibility of variable widgets
-- FIXME: sometimes fails to set visibility, variable logic will still work regardless.
local function handleRandomListener(event, composerTarget, ...)
    if event.target.isOn == true then
        composer.setVariable( composerTarget, true )
        for _, v in ipairs(arg) do
            v.isVisible = true
        end
    elseif event.target.isOn == false then
        composer.setVariable( composerTarget, false)
        for _, v in ipairs(arg) do
            v.isVisible = false
        end
    end
end

--- Closure function for setting composer variables from textfields.
-- Includes validation function.
-- @param event event: userInput event.
-- @param composerTarget string: name of composer variable.
-- @param min int: minimum int.
-- @param max int: maximum int.
-- @param output TextObject: label for displaying errors (optional).
local function variableListener(event, composerTarget, min, max, button, output)
    if event.phase == "ended" or event.phase == "submitted" or event.phase == "editing" then
        local val = validate.validate_range(event.target.text, min, max)
        if val.bool then
            button:setEnabled(true)
            button.fillColor = { default = {1, 0, 0, 1} }
            composer.setVariable( composerTarget, event.target.text )
        else
            button:setEnabled(false)
            button.fillColor = { default = {1, 0.1, 0.7, 0.4} }
            if output then output.text = val.output end
        end
    end
end

--- Width.

-- Label for grid width.
local textGridX = display.newText(
    {
        text = "Grid Width: ",
        align = "right",
        width = labelWidth,
        height = labelHeight,
        x = display.contentCenterX - labelWidth * centerOffsetMultiplier,
        y = display.contentCenterY - 240
    }
)
-- Text input for grid width.
local textfield_GridX = native.newTextField( 
    display.contentCenterX + fieldWidth * centerOffsetMultiplier,
    display.contentCenterY - 240,
    fieldWidth,
    fieldHeight )
textfield_GridX.inputType = "number"
textfield_GridX.text = tostring(composer.getVariable("gridSizeX"))

--- Height.

-- Label for grid height.
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

-- Text input for grid height.
local textfield_GridY = native.newTextField( 
    display.contentCenterX + fieldWidth * centerOffsetMultiplier,
    display.contentCenterY - 190,
    fieldWidth,
    fieldHeight
)
textfield_GridY.inputType = "number"
textfield_GridY.text = tostring(composer.getVariable("gridSizeY"))

--- Iteration speed.

-- Label for iteration speed.
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

-- Text input for iteration speed.
local textfield_IterationSpeed = native.newTextField( 
    display.contentCenterX + fieldWidth * centerOffsetMultiplier,
    display.contentCenterY - 140,
    fieldWidth,
    fieldHeight
)
textfield_IterationSpeed.inputType = "number"
textfield_IterationSpeed.text = tostring(composer.getVariable("iterationSpeed"))

--- Random cell generation.

-- Label for random cell generation.
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

-- Checkbox for random cell generation.
local switch_DoRandom = widget.newSwitch(
    {
        x = display.contentCenterX + 30,
        y = display.contentCenterY - 90,
        style = "checkbox"
    }
)

-- Random seed.

--- Label for random seed.
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

-- Text input for random seed.
local textfield_RandomSeed = native.newTextField(
    display.contentCenterX + fieldWidth * centerOffsetMultiplier,
    display.contentCenterY - 40,
    fieldWidth,
    fieldHeight
)
textfield_RandomSeed.inputType = "number"
textfield_RandomSeed.text = tostring(composer.getVariable("randomSeed"))

--- Button to start life simulation.
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
                effect = "crossFade",
                time = 500
            })
        end
    }
)
buttonStartGame.fillColor = { default = {1, 0, 0, 1}, over = {1, 0.1, 0.7, 0.4}}

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
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

    

    textfield_GridX:addEventListener(
        "userInput", 
        function(target) variableListener(target, "gridSizeX", minWidth, maxWidth, buttonStartGame, nil) end
    )
    textfield_GridY:addEventListener(
        "userInput", 
        function(target) variableListener(target, "gridSizeY", minHeight, maxHeight, buttonStartGame, nil) end
    )
    textfield_IterationSpeed:addEventListener(
        "userInput", 
        function(target) variableListener(target, "iterationSpeed", minSpeed, maxSpeed, buttonStartGame, nil) end
    )
    switch_DoRandom:addEventListener(
        "tap", 
        function(target) handleRandomListener(target, "doRandom" ,textRandomSeed, textfield_RandomSeed) end
    )
    textfield_RandomSeed:addEventListener(
        "userInput", 
        function(target) variableListener(target, "randomSeed", minSeed, maxSeed, buttonStartGame, nil) end
    )

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        switch_DoRandom.isOn = false

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

        -- Native objects do not remove themselves automatically.
        textfield_GridX:removeSelf()
        textfield_GridY:removeSelf()
        textfield_IterationSpeed:removeSelf()
        textfield_RandomSeed:removeSelf()


    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    composer.removeScene( "scenes.config-scene", false )

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