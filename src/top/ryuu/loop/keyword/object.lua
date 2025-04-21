local keyword = require "top.ryuu.loop.internal.keyword"
local create_type = require "top.ryuu.loop.internal.create_type"
local type_meta_data = require "top.ryuu.loop.internal.type_meta_data"

---@class object
--Supports all classes in the class hierarchy and provides low-level services to derived classes.
--It is the root of the type hierarchy.
---@field _base object
--If this is an interface or has no base class null is returned.
--Object is the only Type that does not have a base class.
---@field _name string
--Access from object's type.
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
    ---@class object
    local this = {}
    setmetatable(this, self)
    return this
end

---@param self _type The type of the object to be instantiated
function object:constructor(...)
    return self._base.new(self, ...)
end

type_meta_data.add(object, "object")

return object
