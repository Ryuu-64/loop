---@generic T:Exception
---@param exception T
return function(exception)
    local exception_to_string = tostring(exception)
    error(exception_to_string)
end
