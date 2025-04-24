local keyword = require "top.ryuu.loop.internal.keyword"
local create_class = require "top.ryuu.loop.internal.create_class"
local meta_data = require "top.ryuu.loop.internal.meta_data"

---@generic T:object
---@param name string
---@return T
return function(name)
    if meta_data.has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    return create_class(name, keyword.interface)
end
