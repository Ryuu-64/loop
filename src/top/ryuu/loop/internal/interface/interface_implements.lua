local throw = require "top.ryuu.loop.keyword.throw"
local are_interfaces = require "top.ryuu.loop.internal.interface.are_interfaces"
local get_interface_exception = require "top.ryuu.loop.internal.interface.get_interface_exception"

---@param self _type
---@param bases table<_type>
return function(self, bases)
    if not are_interfaces(bases) then
        local exception = get_interface_exception(bases)
        throw(exception)
    end

    self._interfaces = bases
end
