---@generic T:Exception
local throw = function(exception)
    error(exception)
end

return throw
