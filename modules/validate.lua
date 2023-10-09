Validate = {}

--- Validate input if within number range,
-- assumes input is always natural number.
-- @param size int: input number.
-- @param min int: minimum number.
-- @param max int: maximum number.
-- @return table of output and error label if applicable.
function Validate.validate_range(size, min, max)
    local output = {}
    local size = tonumber(size) or 0 -- textfield filters non-number text but not empties
    local sizeHigh = "Size is too high"
    local sizeLow = "Size is too low"

    if size > max then
        output.bool = false
        output.output = sizeHigh
        return output
    elseif size < min then
        output.bool = false
        output.output = sizeLow
        return output
    end

    output.bool = true
    return output
end

return Validate