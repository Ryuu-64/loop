local keyword = require "top.ryuu.loop.internal.keyword"
local create_type = require "top.ryuu.loop.internal.create_type"
local meta_data = require "top.ryuu.loop.internal.meta_data"

---@generic T:object
---@param name string
---@return T
return function(name)
    if meta_data.has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    return create_type(name, keyword.interface)
end
