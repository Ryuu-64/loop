---Checks if instance is compatible with a given type.
---@param instance object
---@param type Type
---@return boolean
local is = function(instance, type)
    if type == nil then
        return false
    end

    if instance == nil then
        return false
    end

    ---@type Type
    local metatable = getmetatable(instance)
    if metatable == nil then
        return false
    end

    repeat
        --region class
        if
            metatable._attribute == type._attribute and
            metatable._name == type._name and
            metatable._interfaces == type._interfaces and
            metatable.__tostring == type.__tostring
        then
            return true
        end
        --endregion

        --region interface
        for i = 1, #metatable._interfaces do
            local interface = metatable._interfaces[i]
            if
                interface._attribute == type._attribute and
                interface._name == type._name and
                interface._interfaces == type._interfaces and
                interface.__tostring == type.__tostring
            then
                return true
            end
        end
        --endregion

        metatable = getmetatable(metatable)
    until metatable == nil

    return false
end

return is
