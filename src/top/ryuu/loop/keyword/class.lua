local keyword = require "top.ryuu.loop.internal.keyword"
local create_type = require "top.ryuu.loop.internal.create_type"
local meta_data = require "top.ryuu.loop.internal.meta_data"
local is_class = require "top.ryuu.loop.internal.class.is_class"
local object = require "top.ryuu.loop.keyword.object"

---@param name string
---@param base object|nil
---@return Type
return function(name, base)
    if meta_data.has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    -- object is default class
    base = base or object

    if not is_class(base) then
        error("Invalid base class.")
    end

    local _type = create_type(name, keyword.class)
    _type._base = base
    _type.__tostring = base.__tostring or _type.__tostring
    setmetatable(_type, base)

    return _type
end
