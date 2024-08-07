local keyword = require "org.ryuu.loop.lang.keyword"
local ClassMetadataTable = require "org.ryuu.loop.lang.runtime.ClassMetadataTable"

---@class object Supports all classes in the class hierarchy and provides low-level services to derived classes. It is the root of the type hierarchy.
local object = setmetatable({}, nil)
object.__index = object
object._name = "object"
object._type = keyword.class
object._interfaces = {}

function object:__tostring()
    return self._name
end

---@generic T:object
---@param a T
---@param b T
function object.__eq(a, b)
    return rawequal(a, b)
end

---@generic T:object
---@return T
function object:new()
    return setmetatable({}, self)
end

---@generic T:object
---@return T
function object:base()
end

ClassMetadataTable.Add(object, object._name)
ClassMetadataTable.AddBase(object, getmetatable(object))

return object
