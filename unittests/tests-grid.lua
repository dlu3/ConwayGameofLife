module(..., package.seeall)

-- Setup grid with blinker_v
local grid = Grid:new(7, 7)
grid:setCoordinate(4, 3, 1)
grid:setCoordinate(4, 4, 1)
grid:setCoordinate(4, 5, 1)

function test_grid_exists()
    assert_true(grid)
end

function test_grid_blinker_exists()
    assert_equal(grid:getCoordinate(4, 3), 1)
    assert_equal(grid:getCoordinate(4, 4), 1)
    assert_equal(grid:getCoordinate(4, 5), 1)
end

-- assert neighbour functions
local function getSum(table)
    local sum = 0
    for i=1, #table do
        sum = sum + table[i]
    end
    return sum
end

function test_grid_neighbour_return()
    assert_table(grid:getNeighbours(4, 4))
end

function test_grid_neighbour_blinker()
    assert_equal(getSum(grid:getNeighbours(4, 3)), 1)
    assert_equal(getSum(grid:getNeighbours(4, 4)), 2)
    assert_equal(getSum(grid:getNeighbours(4, 5)), 1)

    assert_equal(getSum(grid:getNeighbours(3, 4)), 3)
    assert_equal(getSum(grid:getNeighbours(5, 4)), 3)
end

function test_grid_neighbour_edge()
    assert_equal(#grid:getNeighbours(1, 1), 8)
    assert_equal(#grid:getNeighbours(2, 1), 8)
end

