local keyword = require "top.ryuu.loop.internal.keyword"
local create_type = require "top.ryuu.loop.internal.create_type"
local type_meta_data = require "top.ryuu.loop.internal.type_meta_data"

---@param name string
---@return _type
local interface = function(name)
    if type_meta_data.has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    ---@type _type
    local interface = create_type(name, keyword.interface)
    type_meta_data.add(interface, name)
    return interface
end

return interface
