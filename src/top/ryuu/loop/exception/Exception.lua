local class = require "top.ryuu.loop.keyword.class"

---@class Exception:object
---@field message string
---@field inner_exception Exception
local Exception = class("Exception")

function Exception:__tostring()
    local string = self._name .. "("
    if self.message ~= nil then
        string = string .. "message=" .. tostring(self.message)
    end
    if self.inner_exception ~= nil then
        string = string .. ", inner_exception=" .. tostring(self.inner_exception)
    end
    string = string .. ")"
    return string
end

---@generic T:Exception
---@field message string
---@field innerException T
---@return T
function Exception:new(message, inner_exception)
    ---@type Exception
    local this = Exception:constructor()
    this.message = message
    this.inner_exception = inner_exception
    return this
end

return Exception
