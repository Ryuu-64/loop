local keyword = require "top.ryuu.loop.internal.keyword"
local create_class = require "top.ryuu.loop.internal.create_class"
local meta_data = require "top.ryuu.loop.internal.meta_data"
local is_class = require "top.ryuu.loop.internal.class.is_class"
local object = require "top.ryuu.loop.keyword.object"

---@generic T:object
---@generic U:object
---@param name string
---@param base_class T|nil
---@return U
return function(name, base_class)
    if meta_data.has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    -- object is default class
    base_class = base_class or object

    if not is_class(base_class) then
        error("Invalid base class.")
    end

    local new_class = create_class(name, keyword.class)
    new_class._base = base_class
    new_class.__tostring = base_class.__tostring or new_class.__tostring
    setmetatable(new_class, base_class)

    return new_class
end
