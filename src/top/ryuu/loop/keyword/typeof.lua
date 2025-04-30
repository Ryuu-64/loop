local runtime = require "top.ryuu.loop.runtime.runtime"
local meta_data = runtime.meta_data

---@param object object
---@return object
return function(object)
    return meta_data.name_type_map[object._name]
end
