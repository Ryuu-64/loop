local keyword = require "org.ryuu.loop.lang.keyword"
local object = require "org.ryuu.loop.lang.keyword.object"

---
---@class Exception:object
---@field message string
---@field innerException Exception
local Exception = setmetatable({}, object)
Exception.__index = Exception
Exception._name = "Exception"
Exception._type = keyword.class
Exception._interfaces = {}

function Exception:__tostring()
    return self._name ..
        "(message=" .. tostring(self.message) .. ", innerException=" .. tostring(self.innerException) .. ")"
end

function Exception:new(message, innerException)
    ---@type Exception
    local this = object.new(self)
    this.message = message
    this.innerException = innerException
    return this
end

return Exception
