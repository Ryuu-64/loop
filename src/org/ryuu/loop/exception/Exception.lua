local class = require "org.ryuu.loop.keyword.class"

---@class Exception:object
---@field message string
---@field innerException Exception
local Exception = class("Exception")

function Exception:__tostring()
    return self._name ..
        "(message=" .. tostring(self.message) .. ", innerException=" .. tostring(self.innerException) .. ")"
end

---@return Exception
function Exception:new(message, innerException)
    ---@type Exception
    local this = Exception.base(self)
    this.message = message
    this.innerException = innerException
    return this
end

return Exception
