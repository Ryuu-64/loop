local meta_data = require "top.ryuu.loop.internal.meta_data"

---@param name string
---@param attribute string
---@return Type
return function(name, attribute)
    local _type = {
        _name = name,
        _attribute = attribute,
        _interfaces = {}
    }
    _type.__index = _type
    meta_data.add(name, _type)
    return _type
end
