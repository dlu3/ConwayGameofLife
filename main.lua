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

composer.setVariable( "gridSizeX", 10 )
composer.setVariable( "gridSizeY", 10 )
composer.setVariable( "iterationSpeed", 500 )
composer.setVariable( "randomSeed", 1234 )

composer.gotoScene( "scenes.grid-scene")