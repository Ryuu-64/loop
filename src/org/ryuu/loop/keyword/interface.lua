local keyword = require "org.ryuu.loop.internal.keyword"
local create_type = require "org.ryuu.loop.internal.create_type"
local type_meta_data = require "org.ryuu.loop.internal.type_meta_data"

---@param name string
---@return type
return function(name)
    if type_meta_data.Has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    ---@type type
    local interface = create_type(name, keyword.interface)
    type_meta_data.Add(interface, name)
    return interface
end
