local keyword = require "top.ryuu.loop.internal.keyword"

---@param class type
return function(class)
    if type(class) ~= "table" then
        return false
    end

    if class._name == nil then
        return false
    end

    if class._attribute ~= keyword.class then
        return false
    end

    if type(class._interfaces) ~= "table" then
        return false
    end

    return true
end
