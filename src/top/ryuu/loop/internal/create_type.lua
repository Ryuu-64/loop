---@param _name string
---@param _attribute string
---@return type
local create_type = function(_name, _attribute)
    ---@type type
    local type = {
        _name = _name,
        _attribute = _attribute,
        _interfaces = {}
    }
    type.__index = type
    return type
end

return create_type
