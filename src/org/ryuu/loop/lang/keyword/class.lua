local keyword = require "org.ryuu.loop.lang.keyword"
local object = require "org.ryuu.loop.lang.keyword.object"
local ClassMetadataTable = require "org.ryuu.loop.lang.runtime.ClassMetadataTable"
local ClassValidator = require "org.ryuu.loop.lang.class.ClassValidator"

---
---@return type
return function(name, extend)
    --region create class
    if ClassMetadataTable.Has(name) then
        error("name already exist, name=" .. name)
    end

    ---@type type
    local class = {}
    class.__index = class
    class._name = name
    class._type = keyword.class
    class._modifiers = {}
    class._interfaces = {}
    ClassMetadataTable.Add(class, name)
    --endregion

    --region class extend
    if extend == nil then
        extend = object
    end

    if not ClassValidator.Is(extend) then
        error("extend is not a class, extend=" .. tostring(extend))
    end

    setmetatable(class, extend)
    if extend.__tostring ~= nil then
        class.__tostring = extend.__tostring
    end
    ClassMetadataTable.AddBase(class, extend)
    --endregion

    return class
end
