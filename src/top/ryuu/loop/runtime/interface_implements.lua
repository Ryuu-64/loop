local keyword = require "top.ryuu.loop.internal.keyword"
local ArgumentException = require "top.ryuu.loop.exception.ArgumentException"

---@param interface Type
---@param bases table<Type>
return function(interface, bases)
    return pcall(function()
        if interface == nil then
            error(ArgumentException:new("interface is nil"))
        end

        if interface._name == nil then
            error(ArgumentException:new("interface._name is nil"))
        end

        if interface._attribute ~= keyword.interface then
            return ArgumentException:new("interface._attribute is not 'interface'")
        end

        --region _interfaces
        if interface._interfaces == nil then
            return ArgumentException:new("interface._interfaces is nil")
        end

        if type(interface._interfaces) ~= "table" then
            return ArgumentException:new("interface._interfaces is not a table")
        end
        --endregion
    end)
end
