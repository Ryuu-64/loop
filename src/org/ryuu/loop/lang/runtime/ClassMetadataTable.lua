---@class ClassMetadataTable
local ClassMetadataTable = {}
ClassMetadataTable.__index = ClassMetadataTable
function ClassMetadataTable:__tostring()
    return "ClassMetadataTable"
end

ClassMetadataTable.classNameTable = {}
ClassMetadataTable.nameClassTable = {}
ClassMetadataTable.classBaseClassTable = {}

---
---@param class type
---@param baseClass type
function ClassMetadataTable.AddBase(class, baseClass)
    ClassMetadataTable.classBaseClassTable[class] = baseClass
end

---
---@param class type
---@param name string
function ClassMetadataTable.Add(class, name)
    ClassMetadataTable.classNameTable[class] = name
    ClassMetadataTable.nameClassTable[name] = class
end

---
---@param name string
function ClassMetadataTable.Has(name)
    return ClassMetadataTable.nameClassTable[name] ~= nil
end

---
---@param name string
---@return type
function ClassMetadataTable.Get(name)
    return ClassMetadataTable.nameClassTable[name]
end

---
---@param name string
---@return type
function ClassMetadataTable.GetBase(name)
    local class = ClassMetadataTable.Get(name)
    return ClassMetadataTable.classBaseClassTable[class]
end

return ClassMetadataTable
