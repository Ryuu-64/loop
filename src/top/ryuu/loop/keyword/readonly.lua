---@generic T:table|function|thread
---@param value T
---@return T
return function(value)
    local value_type = type(value)
    if value_type == "table" then
        return setmetatable({}, {
            __index = value,
            __newindex = function(_, k, v)
                print(("attempt to modify readonly field '%s'"):format(tostring(k)), 2)
            end,
            __pairs = function() return next, value, nil end,
            __ipairs = function() return ipairs(value) end
        })
    elseif value_type == "function" then
        return setmetatable({}, {
            __call = function(_, ...)
                return value(...)
            end,
            __index = function(_, k)
                print(("attempt to access function field '%s'"):format(k))
            end,
            __newindex = function() error("attempt to modify readonly function") end
        })
    elseif value_type == "thread" then
        return setmetatable({}, {
            __index = function(_, k)
                if k == "status" then
                    return coroutine.status(value)
                end
                print(("attempt to access thread field '%s'"):format(k))
            end,

            __newindex = function(_, k, v)
                error(("attempt to modify readonly thread field '%s'"):format(k))
            end,

            __pairs = function() return next, {}, nil end,
            __ipairs = function() return ipairs({}) end,

            __tostring = function()
                return tostring(value):gsub("thread", "readonly_thread")
            end
        })
        -- TODO
        --elseif value_type == "boolean" then
    else
        return value
    end
end
