local keyword = require "top.ryuu.loop.internal.keyword"
local create_class = require "top.ryuu.loop.internal.create_class"

---@class object
--Supports all classes in the class hierarchy and provides low-level services to derived classes.
--It is the root of the type hierarchy.
---@field _base object
---@field _type Type
--If this is an interface or has no base class null is returned.
--Object is the only Type that does not have a base class.
---@field _name string
--Access from object's type.
---@field __tostring function():string
local object = create_class("object", keyword.class)

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
    ---@class object
    local this = {
        _type = self
    }
    setmetatable(this, self)
    return this
end

---@param self Type The type of the object to be instantiated
function object:constructor(...)
    return self._base.new(self, ...)
end

function object:getType(...)
    return self._type
end

return object
