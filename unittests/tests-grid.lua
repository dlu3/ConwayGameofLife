module(..., package.seeall)
local grid = require("modules.grid")

-- Init values
local width = lunatest.random_int(5, 200)
local height = lunatest.random_int(5, 200)

--- Helper functions

--- Sums integers in a table
-- @param table table: array of values.
-- @return sum int: sum of integers.
local function getSum(table)
    local sum = 0
    for i=1, #table do
        sum = sum + table[i]
    end
    return sum
end

-- Setup grid with blinker_v
local grid = grid:new(width, height)
grid:set_coordinate(4, 3, 1)
grid:set_coordinate(4, 4, 1)
grid:set_coordinate(4, 5, 1)

function test_grid_exists()
    assert_true(grid)
end

-- Getters

function test_grid_blinker_exists()
    assert_equal(grid:get_coordinate(4, 3), 1)
    assert_equal(grid:get_coordinate(4, 4), 1)
    assert_equal(grid:get_coordinate(4, 5), 1)
end

function test_grid_width()
    assert_equal(grid:get_width(), width)
end

function test_grid_height()
    assert_equal(grid:get_height(), height)
end

-- Assert table return by getting its length
function test_grid_neighbour_return()
    assert_gte(1, #grid:get_neighbours(4, 4))
end

-- Assert sum of neighbours are correct
function test_grid_neighbour_blinker()
    assert_equal(getSum(grid:get_neighbours(4, 3)), 1)
    assert_equal(getSum(grid:get_neighbours(4, 4)), 2)
    assert_equal(getSum(grid:get_neighbours(4, 5)), 1)

    assert_equal(getSum(grid:get_neighbours(3, 4)), 3)
    assert_equal(getSum(grid:get_neighbours(5, 4)), 3)
end

function test_grid_neighbour_edge()
    assert_equal(getSum(grid:get_neighbours(1, 1)), 0)
    assert_equal(getSum(grid:get_neighbours(2, 1)), 0)
end

