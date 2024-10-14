---@generic T:Exception
local throw = function(exception)
    local exceptionToString = tostring(exception)
    error(exceptionToString)
end

return throw
