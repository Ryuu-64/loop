local class = require "top.ryuu.loop.keyword.class"

---@class Exception:Type
---@field message string
---@field inner_exception Exception|nil
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
---@param message string
---@param inner_exception T|nil
---@return T
function Exception:new(message, inner_exception)
    ---@class Exception
    local this = Exception:constructor()
    this.message = message
    this.inner_exception = inner_exception
    return this
end

return Exception
