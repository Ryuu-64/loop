---@generic T:Exception
local throw = function(exception)
    local exception_to_string = tostring(exception)
    error(exception_to_string)
end

return throw
