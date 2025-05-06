---@param _type Type
---@return boolean, string
return function(_type)
    if _type == nil then
        return false, "parameter is nil."
    end

    local status = true
    local reasons = {}
    if _type._name == nil then
        status = false
        table.insert(reasons, "\"_name\" is nil")
    end

    if _type._attribute == nil then
        status = false
        table.insert(reasons, "\"_attribute\" is nil")
    end

    if _type._interfaces == nil then
        status = false
        table.insert(reasons, "\"_interfaces\" is nil")
    elseif type(_type._interfaces) ~= "table" then
        status = false
        table.insert(reasons, "\"_interfaces\" type is not table")
    end

    local message = ""
    if not status then
        message = "parameter is not type, "
        message = message .. table.concat(reasons, ", ")
        message = message .. "."
    end
    return status, message
end
