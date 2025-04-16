local keyword = require "top.ryuu.loop.internal.keyword"
local throw = require "top.ryuu.loop.keyword.throw"
local class_implements = require "top.ryuu.loop.internal.class.class_implements"
local interface_implements = require "top.ryuu.loop.internal.interface.interface_implements"
local ArgumentException = require "top.ryuu.loop.exception.ArgumentException"

--TODO interfaces type and size validation
---@param self type class or interface
---@param interfaces table<type>
---@return void
local implements = function(self, interfaces)
    if self._attribute == keyword.class then
        class_implements(self, interfaces)
        return
    end

    if self._attribute == keyword.interface then
        interface_implements(self, interfaces)
        return
    end

    throw(ArgumentException:new("type invalid"))
end

return implements
