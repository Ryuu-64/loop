---@class InterfaceMetadataTable
local InterfaceMetadataTable = {}
InterfaceMetadataTable.__index = InterfaceMetadataTable

function InterfaceMetadataTable:__tostring()
    return "InterfaceMetadataTable"
end

InterfaceMetadataTable.interfaceNameTable = {}
InterfaceMetadataTable.nameInterfaceTable = {}
InterfaceMetadataTable.interfaceBaseInterfaceTable = {}

---@param self type
---@param bases table<type>
function InterfaceMetadataTable.AddBases(self, bases)
    InterfaceMetadataTable.interfaceBaseInterfaceTable[self] = bases
end

---@param self type
---@param name string
function InterfaceMetadataTable.Add(self, name)
    InterfaceMetadataTable.interfaceNameTable[self] = name
    InterfaceMetadataTable.nameInterfaceTable[name] = self
end

---@param name string
---@return boolean
function InterfaceMetadataTable.Has(name)
    return InterfaceMetadataTable.nameInterfaceTable[name] ~= nil
end

---@param name string
---@return type
function InterfaceMetadataTable.Get(name)
    return InterfaceMetadataTable.nameInterfaceTable[name]
end

---@param name string
---@return table<type>
function InterfaceMetadataTable.GetBases(name)
    local interface = InterfaceMetadataTable.Get(name)
    return InterfaceMetadataTable.interfaceBaseInterfaceTable[interface]
end

return InterfaceMetadataTable
