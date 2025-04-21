---@param _name string
---@param _attribute string
---@return _type
return function(_name, _attribute)
    local type = {
        _name = _name,
        _attribute = _attribute,
        _interfaces = {}
    }
    type.__index = type
    return type
end
