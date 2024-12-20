---@param _name string
---@param _type string
---@return type
local createType = function(_name, _type)
    ---@type type
    local type = {
        _name = _name,
        _type = _type,
        _interfaces = {}
    }
    type.__index = type
    return type
end

return createType
