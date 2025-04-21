---@class type_meta_data
local type_meta_data = {
    type_name_map = {},
    name_type_map = {}
}
type_meta_data.__index = type_meta_data

---@param self object
---@param name string
function type_meta_data.add(self, name)
    type_meta_data.type_name_map[self] = name
    type_meta_data.name_type_map[name] = self
end

---@param name string
---@return boolean
function type_meta_data.has(name)
    return type_meta_data.name_type_map[name] ~= nil
end

function type_meta_data.clear()
    type_meta_data.type_name_map = {}
    type_meta_data.name_type_map = {}
end

return type_meta_data
