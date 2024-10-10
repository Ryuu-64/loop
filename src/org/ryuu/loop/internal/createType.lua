---@param _name string
---@param _type string
return function(_name, _type)
    local type = {
        _name = _name,
        _type = _type,
        _interfaces = {}
    }
    type.__index = type
    return type
end
