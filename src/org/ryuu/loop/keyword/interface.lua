local keyword = require "org.ryuu.loop.internal.keyword"
local createType = require "org.ryuu.loop.internal.createType"
local InterfaceMetadataTable = require "org.ryuu.loop.internal.interface.InterfaceMetadataTable"

---@param name string
---@return type
return function(name)
    ---@type type
    local interface = createType(name, keyword.interface)
    InterfaceMetadataTable.Add(interface, name)
    return interface
end
