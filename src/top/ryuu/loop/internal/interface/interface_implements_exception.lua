local is_interface = require "top.ryuu.loop.internal.interface.is_interface"
local get_interface_exception = require "top.ryuu.loop.internal.interface.get_interface_exception"
local ArgumentException = require "top.ryuu.loop.exception.ArgumentException"
local ArgumentNilException = require "top.ryuu.loop.exception.ArgumentNilException"

return function(interfaces)
    if interfaces == nil then
        return ArgumentNilException:new("interfaces is nil")
    end

    if type(interfaces) ~= "table" then
        return ArgumentException:new("interfaces is not table")
    end

    local reason = ""
    for i = 1, #interfaces do
        if not is_interface(interfaces[i]) then
            reason = reason .. get_interface_exception(interfaces[i]).message
        end
    end
    return ArgumentException:new("invalid implements parameters, reason: " .. reason)
end
