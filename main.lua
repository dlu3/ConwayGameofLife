-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--[[

    Allow random or user-input start state
    Allow pauses/restarts
    Allow simulation stop
    Allow to back to start
    Allor random seeds for init simulation state
    Allow saves
    Allow adjustment of iteration speed

    Cells --> Grid --> Display

    Cells/Grid do not store display information, handled by Display
    Cell checking for    

]]

local composer = require( "composer" )

-- Default values will show up in config scene
composer.setVariable( "gridSizeX", 20 )
composer.setVariable( "gridSizeY", 20 )
composer.setVariable( "iterationSpeed", 100 )
composer.setVariable( "randomSeed", 1234 )

composer.gotoScene( "scenes.config-scene")