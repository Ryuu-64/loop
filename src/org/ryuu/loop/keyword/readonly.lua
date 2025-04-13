---@generic T
---@param proxyTable T
---@return T
local function readonly(proxyTable)
    local metatable = {
        __index = proxyTable,
        __newindex = function(table, key, newValue)
            --print(string.format(
            --    "attempt to modify a read-only table, %s, key: %s, value: %s, new value: %s.",
            --    tostring(table),
            --    tostring(key),
            --    tostring(table[key]),
            --    tostring(newValue)
            --))
        end
    }

    local readonlyTable = {}
    setmetatable(readonlyTable, metatable)
    return readonlyTable
end

return readonly
