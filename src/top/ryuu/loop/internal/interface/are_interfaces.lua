local keyword = require "top.ryuu.loop.internal.keyword"

return function(interfaces)
    if interfaces == nil then
        return false
    end
    if type(interfaces) ~= "table" then
        return false
    end

    local temp_interfaces = {}
    for i = 1, #interfaces do
        temp_interfaces[i] = interfaces[i]
    end

    while #temp_interfaces > 0 do
        local current = table.remove(temp_interfaces)

        if current == nil or
                current._name == nil or
                current._attribute ~= keyword.interface or
                current._interfaces == nil then
            return false
        end

        for i = 1, #current._interfaces do
            table.insert(temp_interfaces, current._interfaces[i])
        end
    end

    return true
end
