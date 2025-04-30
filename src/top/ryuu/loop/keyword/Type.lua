local class = require "top.ryuu.loop.keyword.class"

---@class Type:object
---@field _name string
---@field _attribute string
---@field _interfaces table<Type>
---@field _base_type Type
return class("Type")
