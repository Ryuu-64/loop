﻿local throw = require "org.ryuu.loop.keyword.throw"
local InterfaceValidator = require "org.ryuu.loop.internal.interface.InterfaceValidator"
local ClassValidator = require "org.ryuu.loop.internal.class.ClassValidator"
local ArgumentException = require "org.ryuu.loop.exception.ArgumentException"

---@class ClassImplements
local ClassImplements = {}

local function GetFunctionInfoTable(classOrInterface)
    local functionInfoTable = {}
    for name, value in pairs(classOrInterface) do
        if type(value) == "function" then
            local info = debug.getinfo(value, "u")
            functionInfoTable[name] = {
                isVarArg = info.isvararg,
                paramsCount = info.nparams
            }
        end
    end

    return functionInfoTable
end

local function ClassInterfaceValidator(class, interface)
    if not ClassValidator.Is(class) then
        return false
    end

    if not InterfaceValidator.Is(interface) then
        return false
    end

    local interfaceTable = GetFunctionInfoTable(interface)
    local classTable = GetFunctionInfoTable(class)

    for name, info in pairs(interfaceTable) do
        local infoInClass = classTable[name]
        if infoInClass == nil then
            return false
        elseif infoInClass.isVarArg ~= info.isVarArg then
            return false
        elseif infoInClass.paramsCount ~= info.paramsCount then
            return false
        end
    end

    return true
end

local function FunctionInvalidReason(functionName, infoInClass, infoInInterface)
    local reason = ""
    if infoInClass == nil then
        reason = string.rep(" ", 4) .. "No such function.\n"
    else
        if infoInClass.isVarArg ~= infoInInterface.isVarArg then
            reason = reason .. string.rep(" ", 4) .. "Incorrect 'Variable Number of Arguments'. " ..
                "Expected " .. tostring(infoInInterface.isVarArg) .. "," ..
                " but " .. tostring(infoInClass.isVarArg) .. " was provided.\n"
        end
        if infoInClass.paramsCount ~= infoInInterface.paramsCount then
            reason = reason .. string.rep(" ", 4) .. "Incorrect number of arguments. " ..
                "Expected " .. infoInInterface.paramsCount .. " arguments," ..
                "but " .. infoInClass.paramsCount .. " was provided.\n"
        end
    end

    if reason == "" then
        return reason
    end

    return
        string.rep(" ", 2) .. "Function '" .. functionName .. "' is not implemented:\n" ..
        reason .. "\n"
end

local function InterfaceInvalidMessage(class, interface)
    if not ClassValidator.Is(class) then
        return "not a class"
    end

    if not InterfaceValidator.Is(interface) then
        return "not a interface"
    end

    local infoListInInterface = GetFunctionInfoTable(interface)
    local infoListInClass = GetFunctionInfoTable(class)
    local interfaceReason = "Can't implement interface '" .. interface._name .. "':\n"
    local functionReason = ""
    for name, infoInInterface in pairs(infoListInInterface) do
        local infoInClass = infoListInClass[name]
        local reason = FunctionInvalidReason(name, infoInClass, infoInInterface)
        if reason ~= "" then
            functionReason = functionReason .. reason
        end
    end

    if functionReason == "" then
        return ""
    end

    return interfaceReason .. functionReason
end

local function GetAllInterfaces(interfaces)
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

local function IsValid(class, interfaces)
    if type(interfaces) ~= "table" then
        return false
    end

    if #interfaces == 0 then
        return false
    end

    local allInterfaces = GetAllInterfaces(interfaces)
    for i = 1, #allInterfaces do
        local interface = allInterfaces[i]
        if not ClassInterfaceValidator(class, interface) then
            return false
        end
    end

    return true
end

local function GetException(class, interfaces)
    if type(interfaces) ~= "table" then
        return ArgumentException:new("interfaces is not type of table")
    end

    if InterfaceValidator.Are(interfaces) then
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

    local allInterfaces = GetAllInterfaces(interfaces)
    local messages = ""
    for i = 1, #allInterfaces do
        local interface = allInterfaces[i]
        messages = messages .. InterfaceInvalidMessage(class, interface)
    end

    return ArgumentException:new(
        "Error implementing interfaces " .. interfaceNameString .. " for '" .. class._name .. "': " .. messages
    )
end

function ClassImplements.Implements(class, interfaces)
    if not IsValid(class, interfaces) then
        local innerException = GetException(class, interfaces)
        local exception = ArgumentException:new("invalid implements parameters", innerException)
        throw(exception)
    end

    class._interfaces = interfaces
end

return ClassImplements
