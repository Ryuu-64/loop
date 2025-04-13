local throw = require "org.ryuu.loop.keyword.throw"
local InterfaceValidator = require "org.ryuu.loop.internal.interface.InterfaceValidator"
local ArgumentException = require "org.ryuu.loop.exception.ArgumentException"
local ArgumentNilException = require "org.ryuu.loop.exception.ArgumentNilException"

---@class InterfaceImplements
local InterfaceImplements = {}

local function GetException(interfaces)
    if interfaces == nil then
        return ArgumentNilException:new("interfaces is nil")
    end

    if type(interfaces) ~= "table" then
        return ArgumentException:new("interfaces is not table")
    end

    local reason = ""
    for i = 1, #interfaces do
        if not InterfaceValidator.Is(interfaces[i]) then
            reason = reason .. InterfaceValidator.GetException(interfaces[i]).message
        end
    end
    return ArgumentException:new("invalid implements parameters, reason: " .. reason)
end

---@param self type
---@param bases table<type>
function InterfaceImplements.Implements(self, bases)
    if not InterfaceValidator.Are(bases) then
        local exception = GetException(bases)
        throw(exception)
    end

    self._interfaces = bases
end

return InterfaceImplements
