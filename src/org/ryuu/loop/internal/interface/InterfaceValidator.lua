local keyword = require "org.ryuu.loop.internal.keyword"
local ArgumentException = require "org.ryuu.loop.exception.ArgumentException"

---@class InterfaceValidator
local InterfaceValidator = {}

function InterfaceValidator.Is(interface)
    return InterfaceValidator.Are({ interface })
end

function InterfaceValidator.Are(interfaces)
    if interfaces == nil then
        return false
    end

    if type(interfaces) ~= "table" then
        return false
    end

    while #interfaces > 0 do
        local current = table.remove(interfaces)

        if current == nil or
            current._name == nil or
            current._type ~= keyword.interface or
            current._interfaces == nil then
            return false
        end

        for i = 1, #current._interfaces do
            table.insert(interfaces, current._interfaces[i])
        end
    end

    return true
end

function InterfaceValidator.GetException(interface)
    if interface == nil then
        return ArgumentException:new("interface is nil")
    end

    if interface._name == nil then
        return ArgumentException:new("interface._name is nil")
    end

    if interface._type ~= keyword.interface then
        return ArgumentException:new("interface._type is not 'interface'")
    end

    --region _interfaces
    if interface._interfaces == nil then
        return ArgumentException:new("interface._interfaces is nil")
    end

    if type(interface._interfaces) ~= "table" then
        return ArgumentException:new("interface._interfaces is not a table")
    end

    local reason = ""
    for i = 1, #interface._interfaces do
        local currInterface = interface._interfaces[i]
        local exception = InterfaceValidator.GetException(currInterface)
        if exception ~= nil then
            reason = reason ..
                "interface._interfaces[" .. i .. "]" ..
                " (" .. currInterface._name .. ") is not a valid interface: " ..
                tostring(exception) .. "\n"
        end
    end
    --endregion

    if reason ~= nil then
        return ArgumentException:new(reason)
    end

    return nil
end

return InterfaceValidator
