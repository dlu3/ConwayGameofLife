-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--[[
    TODO:
        Allow random or user-input start state
        Allow pauses/restarts
        Allow simulation stop
        Allow to back to start
        Allor random seeds for init simulation state
        Allow saves
        Allow adjustment of iteration speed
]]

local composer = require( "composer" )

require("unittests.lunatest")
require("unittests.Mytests")

-- Default values will show up in config scene
composer.setVariable( "gridSizeX", 20 )
composer.setVariable( "gridSizeY", 20 )
composer.setVariable( "iterationSpeed", 100 )
composer.setVariable( "doRandom", true )
composer.setVariable( "randomSeed", 1234 )

local options = {
    effect = "fade",
    time = 500
}

composer.gotoScene("scenes.config-scene", options)