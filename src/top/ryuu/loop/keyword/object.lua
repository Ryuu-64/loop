local keyword = require "top.ryuu.loop.internal.keyword"
local runtime = require "top.ryuu.loop.runtime.runtime"
local create_type = runtime.create_type

--Supports all classes in the class hierarchy and provides low-level services to derived classes.
--It is the root of the type hierarchy.
---@class object
--If this is an interface or has no base class null is returned.
--Object is the only Type that does not have a base class.
---@field _base_type object|nil
---@field _type Type
---@field __tostring function():string
local object = create_type("object", keyword.class)

---@generic T:object
---@param a T
---@param b T
function object.__eq(a, b)
    return rawequal(a, b)
end

---@generic T:object
---@param self T The type of the object to be instantiated
---@return T
function object:new(...)
    ---@class T
    local this = {
        _type = self
    }
    setmetatable(this, self)
    return this
end

return object
