module(..., package.seeall)

local pattern = Pattern

function test_pattern_exists()
    assert_true(pattern)
end

function test_pattern_not_exists()
    assert_nil(pattern:getPattern("foo"))
end

function test_pattern_get_blinker_h()
    assert_table(pattern:getPattern("blinker_h"))
    assert_len(3, pattern:getPattern("blinker_h"))
end