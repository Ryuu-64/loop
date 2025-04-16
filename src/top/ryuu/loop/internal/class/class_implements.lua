local throw = require "top.ryuu.loop.keyword.throw"
local are_interfaces = require "top.ryuu.loop.internal.interface.are_interfaces"
local is_interface = require "top.ryuu.loop.internal.interface.is_interface"
local is_class = require "top.ryuu.loop.internal.class.is_class"
local ArgumentException = require "top.ryuu.loop.exception.ArgumentException"

local function get_function_info_map(type_table)
    local queue = { type_table }
    local info_map = {}

    local count = 0
    while #queue > 0 do
        local current_class_or_interface = table.remove(queue)
        count = count + 1
        for name, value in pairs(current_class_or_interface) do
            -- _base_class is field in "type"
            if name == "_base_class" and type(value) == "table" then
                table.insert(queue, value)
            elseif type(value) == "function" then
                local info = debug.getinfo(value, "u")
                info_map[name] = {
                    isvararg = info.isvararg,
                    nparams = info.nparams
                }
            end
        end
    end
    return info_map
end

local function is_class_and_interface_valid(class, interface)
    if not is_class(class) then
        return false
    end

    if not is_interface(interface) then
        return false
    end

    local class_info_map = get_function_info_map(class)
    local interface_info_map = get_function_info_map(interface)

    for interface_name, interface_info in pairs(interface_info_map) do
        local class_info = class_info_map[interface_name]
        if class_info == nil then
            return false
        end

        if class_info.isvararg ~= interface_info.isvararg then
            return false
        end

        if class_info.nparams ~= interface_info.nparams then
            return false
        end
    end

    return true
end

local function function_invalid_reason(function_name, class_info, infoInInterface)
    local reason = ""
    if class_info == nil then
        reason = "No such function."
    else
        if class_info.isvararg ~= infoInInterface.isvararg then
            reason = reason .. "Incorrect 'Variable Number of Arguments'. " ..
                    "Expected " .. tostring(infoInInterface.isvararg) .. "," ..
                    " but " .. tostring(class_info.isvararg) .. " was provided."
        end
        if class_info.nparams ~= infoInInterface.nparams then
            reason = reason .. "Incorrect number of arguments. " ..
                    "Expected " .. infoInInterface.nparams .. " arguments," ..
                    "but " .. class_info.nparams .. " was provided."
        end
    end

    if reason == "" then
        return reason
    end

    return "Function '" .. function_name .. "' is not implemented: " .. reason
end

local function interface_invalid_message(class, interface)
    if not is_class(class) then
        return "not a class"
    end

    if not is_interface(interface) then
        return "not a interface"
    end

    local class_info_map = get_function_info_map(class)
    local interface_info_map = get_function_info_map(interface)
    local function_reason = ""
    for function_name, infoInInterface in pairs(interface_info_map) do
        local class_info = class_info_map[function_name]
        local reason = function_invalid_reason(function_name, class_info, infoInInterface)
        if reason ~= "" then
            function_reason = function_reason .. reason
        end
    end

    if function_reason == "" then
        return ""
    end

    local interfaceReason = "Can't implement interface '" .. interface._name .. "': "
    return interfaceReason .. function_reason
end

local function get_all_interfaces(interfaces)
    local all = {}
    local cur = {}
    for i = 1, #interfaces do
        table.insert(cur, interfaces[i])
    end

    repeat
        local interface = cur[1]
        for i = 1, #interface._interfaces do
            table.insert(cur, interface._interfaces[i])
        end
        table.insert(all, interface)
        table.remove(cur, 1)
    until #cur == 0

    return all
end

local function is_valid(class, interfaces)
    if type(interfaces) ~= "table" then
        return false
    end

    if #interfaces == 0 then
        return false
    end

    local all_interfaces = get_all_interfaces(interfaces)
    for i = 1, #all_interfaces do
        local interface = all_interfaces[i]
        if not is_class_and_interface_valid(class, interface) then
            return false
        end
    end

    return true
end

local function get_exception(class, interfaces)
    if type(interfaces) ~= "table" then
        return ArgumentException:new("interfaces is not type of table")
    end

    if not are_interfaces(interfaces) then
        return ArgumentException:new("interfaces should be a table of interface, not a interface")
    end

    if #interfaces == 0 then
        return ArgumentException:new("interfaces is empty")
    end

    --region interfaces name
    local interfaceNameList = {}
    for i = 1, #interfaces do
        table.insert(interfaceNameList, "'" .. interfaces[i]._name .. "'")
    end
    local interfaceNameString = table.concat(interfaceNameList, ", ")
    --endregion

    local allInterfaces = get_all_interfaces(interfaces)
    local messages = ""
    for i = 1, #allInterfaces do
        local interface = allInterfaces[i]
        messages = messages .. interface_invalid_message(class, interface)
    end

    return ArgumentException:new(
            "Error implementing interfaces " .. interfaceNameString .. " for '" .. class._name .. "': " .. messages
    )
end

return function(class, interfaces)
    if not is_valid(class, interfaces) then
        local inner_exception = get_exception(class, interfaces)
        local exception = ArgumentException:new("invalid implements parameters", inner_exception)
        throw(exception)
    end

    class._interfaces = interfaces
end
