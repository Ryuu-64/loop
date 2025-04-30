---@class meta_data
local meta_data = {
    type_name_map = {},
    name_type_map = {}
}
meta_data.__index = meta_data

---@param type object
---@param name string
function meta_data.add(name, type)
    meta_data.name_type_map[name] = type
    meta_data.type_name_map[type] = name
end

---@param name string
---@return boolean
function meta_data.has(name)
    return meta_data.name_type_map[name] ~= nil
end

function meta_data.clear()
    meta_data.type_name_map = {}
    meta_data.name_type_map = {}
end

return meta_data
