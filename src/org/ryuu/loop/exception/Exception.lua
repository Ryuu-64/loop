local class = require "org.ryuu.loop.keyword.class"

---@class Exception:object
---@field message string
---@field innerException Exception
local Exception = class("Exception")

function Exception:__tostring()
    local exceptionToString = self._name .. "("
    if self.message ~= nil then
        exceptionToString = exceptionToString .. "message=" .. tostring(self.message)
    end
    if self.innerException ~= nil then
        exceptionToString = exceptionToString .. ", innerException=" .. tostring(self.innerException)
    end
    exceptionToString = exceptionToString .. ")"
    return exceptionToString
end

---@generic T:Exception
---@field message string
---@field innerException T
---@return T
function Exception:new(message, innerException)
    ---@type Exception
    local this = Exception.constructor(self)
    this.message = message
    this.innerException = innerException
    return this
end

return Exception
