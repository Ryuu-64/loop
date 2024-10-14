local keyword = require "org.ryuu.loop.internal.keyword"
local throw = require "org.ryuu.loop.keyword.throw"
local ClassImplements = require "org.ryuu.loop.internal.class.ClassImplements"
local InterfaceImplements = require "org.ryuu.loop.internal.interface.InterfaceImplements"
local ArgumentException = require "org.ryuu.loop.exception.ArgumentException"

--TODO interfaces type and size validation
---@param self type class or interface
---@param interfaces table<type>
---@return void
local implements = function(self, interfaces)
    if self._type == keyword.class then
        ClassImplements.Implements(self, interfaces)
        return
    end

    if self._type == keyword.interface then
        InterfaceImplements.Implements(self, interfaces)
        return
    end

    throw(ArgumentException:new("type invalid"))
end

return implements
