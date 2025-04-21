---@generic T:table
---@param proxy_table T
---@return T
local function readonly(proxy_table)
    local metatable = {
        __index = proxy_table,
        __newindex = function()
        end
    }

    local readonly_table = {}
    setmetatable(readonly_table, metatable)
    return readonly_table
end

return readonly
