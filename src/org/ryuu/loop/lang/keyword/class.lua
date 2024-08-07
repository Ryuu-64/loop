local keyword = require "org.ryuu.loop.lang.keyword"
local object = require "org.ryuu.loop.lang.keyword.object"
local ClassMetadataTable = require "org.ryuu.loop.lang.runtime.ClassMetadataTable"
local ClassValidator = require "org.ryuu.loop.lang.class.ClassValidator"

---@generic T:type
---@param name string
---@param baseClass type
---@return T
local function class(name, baseClass)
    if ClassMetadataTable.Has(name) then
        error("name already exist, className=" .. name)
    end

    --region create class
    ---@type type
    local newClass = {}
    newClass.__index = newClass
    newClass._name = name
    newClass._type = keyword.class
    newClass._interfaces = {}
    ClassMetadataTable.Add(newClass, name)
    --endregion

    --region extend
    -- object is default class
    baseClass = baseClass or object

    if not ClassValidator.Is(baseClass) then
        error("base class is not a valid class, baseClass=" .. tostring(baseClass))
    end

    setmetatable(newClass, baseClass)

    --base
    newClass.base = baseClass.new

    -- inherit __tostring
    newClass.__tostring = baseClass.__tostring or newClass.__tostring

    ClassMetadataTable.AddBase(newClass, baseClass)
    --endregion

    return newClass
end

return class
