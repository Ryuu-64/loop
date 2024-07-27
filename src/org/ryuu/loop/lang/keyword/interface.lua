local keyword = require "org.ryuu.loop.lang.keyword"

---@param name string
---@return type
return function(name)
    ---@type type
    local interface = {}
    interface._name = name
    interface._type = keyword.interface
    interface._modifiers = {}
    interface._interfaces = {}
    return interface
end
