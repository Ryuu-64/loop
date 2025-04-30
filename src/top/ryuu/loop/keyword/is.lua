---Checks if instance is compatible with a given type.
---@generic T object
---@param instance object
---@param type T
---@return boolean
local is = function(instance, type)
    if type == nil then
        return false
    end

    if instance == nil then
        return false
    end

    ---@type Type
    local _type = getmetatable(instance)
    if _type == nil then
        return false
    end

    repeat
        --region class
        if
            _type._attribute == type._attribute and
            _type._name == type._name and
            _type._interfaces == type._interfaces and
            _type.__tostring == type.__tostring
        then
            return true
        end
        --endregion

        --region interface
        for i = 1, #_type._interfaces do
            local interface = _type._interfaces[i]
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

        _type = getmetatable(_type)
    until _type == nil

    return false
end

return is
