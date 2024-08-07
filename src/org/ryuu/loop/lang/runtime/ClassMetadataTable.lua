---@class ClassMetadataTable
local ClassMetadataTable = {}
ClassMetadataTable.__index = ClassMetadataTable
function ClassMetadataTable:__tostring()
    return "ClassMetadataTable"
end

ClassMetadataTable.classNameTable = {}
ClassMetadataTable.nameClassTable = {}
ClassMetadataTable.classBaseClassTable = {}

---@param self type
---@param base type
function ClassMetadataTable.AddBase(self, base)
    ClassMetadataTable.classBaseClassTable[self] = base
end

---@param self type
---@param name string
function ClassMetadataTable.Add(self, name)
    ClassMetadataTable.classNameTable[self] = name
    ClassMetadataTable.nameClassTable[name] = self
end

---@param name string
---@return boolean
function ClassMetadataTable.Has(name)
    return ClassMetadataTable.nameClassTable[name] ~= nil
end

---@param name string
---@return type
function ClassMetadataTable.Get(name)
    return ClassMetadataTable.nameClassTable[name]
end

---@param name string
---@return type
function ClassMetadataTable.GetBase(name)
    local class = ClassMetadataTable.Get(name)
    return ClassMetadataTable.classBaseClassTable[class]
end

return ClassMetadataTable
