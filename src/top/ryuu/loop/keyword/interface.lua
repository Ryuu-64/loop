local keyword = require "top.ryuu.loop.internal.keyword"
local runtime = require "top.ryuu.loop.runtime.runtime"
local create_type = runtime.create_type
local meta_data = runtime.meta_data

---@generic T:object
---@param name string
---@return T
return function(name)
    if meta_data.has(name) then
        error("Type already exist, name=" .. name .. ".")
    end

    return create_type(name, keyword.interface)
end
