local class = require "top.ryuu.loop.keyword.class"

---@class type:object
---@field _name string
---@field _attribute string
---@field _base_class type If this is an interface or has no base class null is returned. Object is the only Type that does not have a base class.
---@field _interfaces table<type>
local type = class("type")
return type
