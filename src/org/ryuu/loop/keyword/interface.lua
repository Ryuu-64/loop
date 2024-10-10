local keyword = require "org.ryuu.loop.internal.keyword"
local InterfaceMetadataTable = require "org.ryuu.loop.lang.runtime.InterfaceMetadataTable"

---@param name string
---@return type
return function(name)
    ---@type type
    local interface = {}
    interface._name = name
    interface._type = keyword.interface
    interface._interfaces = {}
    InterfaceMetadataTable.Add(interface, name)
    return interface
end
