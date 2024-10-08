﻿local InterfaceMetadataTable = require "org.ryuu.loop.internal.interface.InterfaceMetadataTable"
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
        if not InterfaceValidator.is(interfaces[i]) then
            reason = reason .. InterfaceValidator.GetException(interfaces[i]).message
        end
    end
    return ArgumentException:new("invalid implements parameters, reason: " .. reason)
end

--TODO validate implements

---@param self type
---@param bases table<type>
function InterfaceImplements.implements(self, bases)
    if not InterfaceValidator.are(bases) then
        error(tostring(GetException(bases)))       
    end

    self._interfaces = bases
    InterfaceMetadataTable.AddBases(self, bases)
end

return InterfaceImplements
