local keyword = require "top.ryuu.loop.internal.keyword"
local runtime = require "top.ryuu.loop.runtime.runtime"
local create_type = runtime.create_type
local is_class = require "top.ryuu.loop.internal.class.is_class"
local object = require "top.ryuu.loop.keyword.object"
local meta_data = runtime.meta_data

---@generic T:object
---@param name string
---@param _base_type object|nil
---@return T
return function(name, _base_type)
    if meta_data.has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    -- object is default class
    _base_type = _base_type or object

    if not is_class(_base_type) then
        error("Invalid base class.")
    end

    local _type = create_type(name, keyword.class)
    _type._base_type = _base_type
    _type.__tostring = _base_type.__tostring or _type.__tostring
    setmetatable(_type, _base_type)

    return _type
end
