---Checks if instance is compatible with a given type.
---@generic T:object
---@param instance T
---@param type type
---@return boolean
local is = function(instance, type)
    if type == nil then
        return false
    end

    if instance == nil then
        return false
    end

    ---@type type
    local metatable = getmetatable(instance)
    if metatable == nil then
        return false
    end

    repeat
        --region class
        if
            metatable._type == type._type and
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
                interface._type == type._type and
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
