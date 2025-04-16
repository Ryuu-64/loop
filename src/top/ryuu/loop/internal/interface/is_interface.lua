local are_interfaces = require "top.ryuu.loop.internal.interface.are_interfaces"

return function(interface)
    return are_interfaces({ interface })
end
