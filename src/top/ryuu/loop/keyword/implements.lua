local keyword = require "top.ryuu.loop.internal.keyword"
local is_type = require "top.ryuu.loop.runtime.is_type"
local throw = require "top.ryuu.loop.keyword.throw"
local class_implements = require "top.ryuu.loop.internal.class.class_implements"
local interface_implements = require "top.ryuu.loop.internal.interface.interface_implements"
local ArgumentException = require "top.ryuu.loop.exception.ArgumentException"

-- TODO interfaces validation
---@param type Type class or interface
---@param interfaces table<Type>
---@return nil
local implements = function(type, interfaces)
    local status, message = is_type(type)
    if not status then
        throw(ArgumentException:new(message))
    end

    if type._attribute == keyword.class then
        class_implements(type, interfaces)
        return
    end

    if type._attribute == keyword.interface then
        interface_implements(type, interfaces)
        return
    end
end

return implements
