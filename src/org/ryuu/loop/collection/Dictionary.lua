local class = require "org.ryuu.loop.lang.keyword.class"
local implements = require "org.ryuu.loop.lang.keyword.implements"
local Collection = require "org.ryuu.loop.collection.Collection"

---@generic K, V
---@class Dictionary:object
---@field pairs table<K, V>
local Dictionary = class("Dictionary")

function Dictionary:new()
    ---@type Dictionary
    local this = Dictionary.base(self)
    this.pairs = {}
    return this
end

---@generic K, V
---@param key K
---@param value V
function Dictionary:Add(key, value)
    self.pairs[key] = value
end

---@generic K, V
---@param key K
---@return V
function Dictionary:Get(key)
    return self.pairs[key]
end

---@generic K
---@param key K
function Dictionary:Remove(key)
    self.pairs[key] = nil
end

---@generic K
---@param key K
function Dictionary:ContainsKey(key)
    return self.pairs[key] ~= nil
end

---@generic V
---@param value V
function Dictionary:ContainsValue(value)
    for _, v in pairs(self.pairs) do
        if v == value then
            return true
        end
    end
    return false
end

--function Dictionary:Count()
--    return #self.pairs
--end

implements(Dictionary, Collection)

return Dictionary
