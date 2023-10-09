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
local grid = require("modules.grid")

--[[ require("unittests.lunatest")
require("unittests.Mytests") ]]

-- Default values will show up in config scene
composer.setVariable( "gridSizeX", 7 )
composer.setVariable( "gridSizeY", 7 )
composer.setVariable( "iterationSpeed", 1000 )
composer.setVariable( "doRandom", false )
composer.setVariable( "randomSeed", 1234 )

local Grid = grid:new(5, 5)
Grid:set_coordinate(3, 2, 1)
Grid:set_coordinate(3, 3, 1)
Grid:set_coordinate(3, 4, 1)
Grid:set_evolution()


local options = {
    effect = "fade",
    time = 1000
}

composer.gotoScene("scenes.grid-scene", options)