local meta_data = require "top.ryuu.loop.internal.meta_data"

---@class Class:object
---@field _name string
---@field _attribute string
---@field _interfaces table<Class>
---@param name string
---@param attribute string
---@return Class
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
