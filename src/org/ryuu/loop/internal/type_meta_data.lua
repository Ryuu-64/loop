---@class type_meta_data
local type_meta_data = {
    type_name_map = {},
    name_type_map = {}
}
type_meta_data.__index = type_meta_data

function type_meta_data:__tostring()
    return "meta_data"
end

---@param self type
---@param name string
function type_meta_data.Add(self, name)
    type_meta_data.type_name_map[self] = name
    type_meta_data.name_type_map[name] = self
end

---@param name string
---@return boolean
function type_meta_data.Has(name)
    return type_meta_data.name_type_map[name] ~= nil
end

return type_meta_data
