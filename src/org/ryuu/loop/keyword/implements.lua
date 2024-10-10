local keyword = require "org.ryuu.loop.internal.keyword"
local ClassImplements = require "org.ryuu.loop.internal.class.ClassImplements"
local InterfaceImplements = require "org.ryuu.loop.internal.interface.InterfaceImplements"
local ArgumentException = require "org.ryuu.loop.exception.ArgumentException"

--TODO interfaces type and size validation
---@param self type class or interface
---@param interfaces table<type>
---@return void
local implements = function(self, interfaces)
    if self._type == keyword.class then
        ClassImplements.implements(self, interfaces)
        return
    end

    if self._type == keyword.interface then
        InterfaceImplements.implements(self, interfaces)
        return
    end

    error(tostring(ArgumentException:new("type invalid")))
end

return implements
