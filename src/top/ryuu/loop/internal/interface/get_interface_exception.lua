local keyword = require "top.ryuu.loop.internal.keyword"
local ArgumentException = require "top.ryuu.loop.exception.ArgumentException"

---@return Exception
local get_interface_exception
get_interface_exception = function(interface)
    if interface == nil then
        return ArgumentException:new("interface is nil")
    end

    if interface._type == nil then
        return ArgumentException:new("interface._type is nil")
    end

    if interface._type._name == nil then
        return ArgumentException:new("interface._name is nil")
    end

    if interface._type._attribute ~= keyword.interface then
        return ArgumentException:new("interface._attribute is not 'interface'")
    end

    --region _interfaces
    if interface._type._interfaces == nil then
        return ArgumentException:new("interface._interfaces is nil")
    end

    if type(interface._type._interfaces) ~= "table" then
        return ArgumentException:new("interface._interfaces is not a table")
    end

    local reason_string = ""
    for i = 1, #interface._type._interfaces do
        local currInterface = interface._type._interfaces[i]
        local exception = get_interface_exception(currInterface)
        if exception ~= nil then
            reason_string = reason_string ..
                "interface._interfaces[" .. i .. "]" ..
                " (" .. currInterface._name .. ") is not a valid interface: " ..
                tostring(exception) .. "\n"
        end
    end
    --endregion
    if reason_string ~= nil then
        return ArgumentException:new(reason_string)
    end

    return nil
end

return get_interface_exception
