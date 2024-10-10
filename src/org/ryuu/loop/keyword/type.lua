---@class type:object
---@field _name string
---@field _type string type keyword
---@field _interfaces table
local type = {
    _name = "type",
    _type = "class",
    _interfaces = {}
}

function type:__tostring()
    return self._name
end

---@generic T:object
---@param a T
---@param b T
function type.__eq(a, b)
    return rawequal(a, b)
end

return type
