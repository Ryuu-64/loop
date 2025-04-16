local keyword = require "top.ryuu.loop.internal.keyword"
local create_type = require "top.ryuu.loop.internal.create_type"
local type_meta_data = require "top.ryuu.loop.internal.type_meta_data"
local is_class = require "top.ryuu.loop.internal.class.is_class"
local object = require "top.ryuu.loop.keyword.object"

---@generic T:type
---@param name string
---@param base_class type
---@return T
local function class(name, base_class)
    if type_meta_data.has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    -- object is default class
    base_class = base_class or object

    if not is_class(base_class) then
        error("Invalid base class.")
    end

    ---@type type
    local new_class = create_type(name, keyword.class)
    new_class._base_class = base_class
    new_class.__tostring = base_class.__tostring or new_class.__tostring
    setmetatable(new_class, base_class)

    type_meta_data.add(new_class, name)
    return new_class
end

return class
