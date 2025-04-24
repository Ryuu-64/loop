local meta_data = require "top.ryuu.loop.internal.meta_data"

---@generic T:object
---@param name string
---@param attribute string
---@return T
return function(name, attribute)
    local class = {
        _name = name,
        _attribute = attribute,
        _interfaces = {}
    }
    class.__index = class
    meta_data.add(name, class)
    return class
end
