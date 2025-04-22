---@param name string
---@param attribute string
---@return Type
return function(name, attribute)
    local type = {
        _name = name,
        _attribute = attribute,
        _interfaces = {}
    }
    type.__index = type
    return type
end
