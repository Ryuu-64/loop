local keyword = require "org.ryuu.loop.lang.keyword"
local ClassMetadataTable = require "org.ryuu.loop.lang.runtime.ClassMetadataTable"

---
---@class object Supports all classes in the class hierarchy and provides low-level services to derived classes. It is the root of the type hierarchy.
local object = setmetatable({}, nil)
object.__index = object
object._name = "object"
object._type = keyword.class
object._interfaces = {}

function object:__tostring()
    return self._name
end

---
---@param a object
---@param b object
function object.__eq(a, b)
    return rawequal(a, b)
end

---
--- constructor
---@return object
function object:new()
    return setmetatable({}, self)
end

function object:base()
end

ClassMetadataTable.Add(object, object._name)
ClassMetadataTable.AddBase(object, getmetatable(object))

return object
