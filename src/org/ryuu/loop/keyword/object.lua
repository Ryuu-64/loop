local keyword = require "org.ryuu.loop.internal.keyword"
local createType = require "org.ryuu.loop.internal.createType"
local ClassMetadataTable = require "org.ryuu.loop.internal.class.ClassMetadataTable"

---@class object Supports all classes in the class hierarchy and provides low-level services to derived classes. It is the root of the type hierarchy.
---@field _name string string
---@field _type string string
---@field _interfaces table table
local object = createType("object", keyword.class)
setmetatable(object, nil)

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
