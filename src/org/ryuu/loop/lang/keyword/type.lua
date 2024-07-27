---
---@generic T:object
---@class type
---@field _name string
---@field _type string type keyword
---@field _modifiers table modifier keywords
---@field _interfaces table
local type = {}
type._name = "type"
type._type = "class"
type._modifiers = {}
type._interfaces = {}
return type
