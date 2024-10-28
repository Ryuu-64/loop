local keyword = require "org.ryuu.loop.internal.keyword"
local createType = require "org.ryuu.loop.internal.createType"
local ClassMetadataTable = require "org.ryuu.loop.internal.class.ClassMetadataTable"

---@class object Supports all classes in the class hierarchy and provides low-level services to derived classes. It is the root of the type hierarchy.
local object = createType("object", keyword.class)
setmetatable(object, nil)

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

---@generic T:object
---@param self type The type of the object to be instantiated
---@return T An instance of the base class for the base method
function object.base(self)
end

ClassMetadataTable.Add(object, object._name)
ClassMetadataTable.AddBase(object, getmetatable(object))

return object
