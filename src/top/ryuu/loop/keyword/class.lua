local keyword = require "top.ryuu.loop.internal.keyword"
local create_type = require "top.ryuu.loop.internal.create_type"
local type_meta_data = require "top.ryuu.loop.internal.type_meta_data"
local is_class = require "top.ryuu.loop.internal.class.is_class"
local object = require "top.ryuu.loop.keyword.object"

---@generic T:object
---@generic U:object
---@param name string
---@param base_class T|nil
---@return U
return function(name, base_class)
    if type_meta_data.has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    -- object is default class
    base_class = base_class or object

    if not is_class(base_class) then
        error("Invalid base class.")
    end

    local new_type = create_type(name, keyword.class)
    new_type._base = base_class
    new_type.__tostring = base_class.__tostring or new_type.__tostring
    setmetatable(new_type, base_class)

    type_meta_data.add(new_type, name)
    return new_type
end
