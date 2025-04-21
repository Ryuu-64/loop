local are_interfaces = require "top.ryuu.loop.internal.interface.are_interfaces"

---@param interface _type
---@return boolean
return function(interface)
    return are_interfaces({ interface })
end
