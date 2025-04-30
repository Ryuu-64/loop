local meta_data = require "top.ryuu.loop.runtime.meta_data"

---@generic T:object
---@param name string
---@param attribute string
---@return T|object|Type
return function(name, attribute)
    ---@class Type
    local _type = {
        _name = name,
        _attribute = attribute,
        _interfaces = {},
        _base_type = nil
    }
    _type.__index = _type
    meta_data.add(name, _type)
    return _type
end
