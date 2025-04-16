local keyword = require "top.ryuu.loop.internal.keyword"
local create_type = require "top.ryuu.loop.internal.create_type"
local type_meta_data = require "top.ryuu.loop.internal.type_meta_data"

---@class object Supports all classes in the class hierarchy and provides low-level services to derived classes. It is the root of the type hierarchy.
local object = create_type("object", keyword.class)

---@generic T:object
---@param a T
---@param b T
function object.__eq(a, b)
    return rawequal(a, b)
end

---
---@generic T:object
---@param self type The type of the object to be instantiated
---@return T The instance of the type
function object.new(self)
    local this = {}
    setmetatable(this, self)
    return this
end

-----@param self type The type of the object to be instantiated
function object.constructor(self, ...)
    return self._base_class.new(self, ...)
end

type_meta_data.add(object, object._name)

return object
