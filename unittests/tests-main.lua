--[[
Testing suite doesn't function correctly
Presumably because functions are tied to game logic
]]

module(..., package.seeall)
require ".main"

-- Setup grid with lightweight_spaceship_r
local grid = Grid:new(6, 5)
grid:setCoordinate(1, 1, 1)
grid:setCoordinate(4, 1, 1)
grid:setCoordinate(5, 2, 1)
grid:setCoordinate(1, 3, 1)
grid:setCoordinate(5, 3, 1)
grid:setCoordinate(2, 4, 1)
grid:setCoordinate(3, 4, 1)
grid:setCoordinate(4, 4, 1)
grid:setCoordinate(5, 4, 1)

-- Test if spaceship evolves correctly
function test_evolve()
    local next = main.evolve(grid)

    assert_equal(next:getCoordinate(4, 2), 1)
    assert_equal(next:getCoordinate(5, 2), 1)

    assert_equal(next:getCoordinate(2, 3), 1)
    assert_equal(next:getCoordinate(3, 3), 1)
    assert_equal(next:getCoordinate(5, 3), 1)
    assert_equal(next:getCoordinate(6, 3), 1)

    assert_equal(next:getCoordinate(2, 4), 1)
    assert_equal(next:getCoordinate(3, 4), 1)
    assert_equal(next:getCoordinate(4, 4), 1)
    assert_equal(next:getCoordinate(5, 4), 1)

    assert_equal(next:getCoordinate(3, 5), 1)
    assert_equal(next:getCoordinate(4, 5), 1)
end