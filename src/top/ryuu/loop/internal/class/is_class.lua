local keyword = require "top.ryuu.loop.internal.keyword"


---@generic T:object
---@param base_class T
return function(base_class)
    if type(base_class) ~= "table" then
        return false
    end

    if base_class._name == nil then
        return false
    end

    if base_class._attribute ~= keyword.class then
        return false
    end

    if type(base_class._interfaces) ~= "table" then
        return false
    end

    return true
end
