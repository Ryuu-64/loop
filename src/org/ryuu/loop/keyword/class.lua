local keyword = require "org.ryuu.loop.internal.keyword"
local create_type = require "org.ryuu.loop.internal.create_type"
local type_meta_data = require "org.ryuu.loop.internal.type_meta_data"
local ClassValidator = require "org.ryuu.loop.internal.class.ClassValidator"
local object = require "org.ryuu.loop.keyword.object"

---@generic T:type
---@param name string
---@param base_class type
---@return T
local function class(name, base_class)
    if type_meta_data.Has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    --region create class
    ---@type type
    local new_class = create_type(name, keyword.class)
    --endregion
    type_meta_data.Add(new_class, name)

    --region extend
    -- object is default class
    base_class = base_class or object

    if not ClassValidator.Is(base_class) then
        error("Invalid base class.")
    end

    setmetatable(new_class, base_class)

    new_class.base = base_class
    new_class.__tostring = base_class.__tostring or new_class.__tostring

    --endregion

    return new_class
end

return class
