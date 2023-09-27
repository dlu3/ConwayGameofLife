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

composer.setVariable( "gridSizeX", 0 )
composer.setVariable( "gridSizeY", 0 )
composer.setVariable( "iterationSpeed", 0 )
composer.setVariable( "randomSeed", 0 )

composer.gotoScene( "scenes.config-scene")