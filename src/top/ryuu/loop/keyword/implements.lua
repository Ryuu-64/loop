local keyword = require "top.ryuu.loop.internal.keyword"
local is_type = require "top.ryuu.loop.runtime.is_type"
local throw = require "top.ryuu.loop.keyword.throw"
local class_implements = require "top.ryuu.loop.internal.class.class_implements"
local interface_implements = require "top.ryuu.loop.internal.interface.interface_implements"
local ArgumentException = require "top.ryuu.loop.exception.ArgumentException"

---@param _type Type class or interface
---@param interfaces table<Type>
---@return nil
local implements = function(_type, interfaces)
    local type_is_type, type_is_type_message = is_type(_type)
    if not type_is_type then
        throw(ArgumentException:new(type_is_type_message))
    end

    if type(interfaces) ~= "table" then
        throw(ArgumentException:new("\"interfaces\" type is not table."))
    elseif true then
        for _, interface in ipairs(interfaces) do
            local interface_is_type, interface_is_type_message = is_type(interface)
            if not interface_is_type then
                local internal_exception = ArgumentException:new(interface_is_type_message)
                throw(ArgumentException:new("invalid interfaces element", internal_exception))
            end
        end
    end

    if _type._attribute == keyword.class then
        class_implements(_type, interfaces)
        return
    end

    if _type._attribute == keyword.interface then
        interface_implements(_type, interfaces)
        return
    end
end

return implements
