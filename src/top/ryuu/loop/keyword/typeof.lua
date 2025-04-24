local meta_data = require "top.ryuu.loop.internal.meta_data"

---@param object object
---@return Type
return function(object)
    return meta_data.name_type_map[object._name]
end
