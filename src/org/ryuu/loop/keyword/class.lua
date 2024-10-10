local keyword = require "org.ryuu.loop.internal.keyword"
local object = require "org.ryuu.loop.keyword.object"
local ClassMetadataTable = require "org.ryuu.loop.internal.class.ClassMetadataTable"
local ClassValidator = require "org.ryuu.loop.internal.class.ClassValidator"

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
    local newClass = {
        _name = name,
        _type = keyword.class,
        _interfaces = {}
    }
    newClass.__index = newClass
    --endregion
    ClassMetadataTable.Add(newClass, name)

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

    --endregion
    ClassMetadataTable.AddBase(newClass, baseClass)

    return newClass
end

return class
