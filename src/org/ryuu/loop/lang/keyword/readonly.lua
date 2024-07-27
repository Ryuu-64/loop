---
---@param proxyTable table
---@return table
return function(proxyTable)
    local metatable = {
        __index = proxyTable,
        __newindex = function(table, key, newValue)
            print(string.format(
                "attempt to modify a read-only table, %s, key: %s, value: %s, new value: %s.",
                tostring(table),
                tostring(key),
                tostring(table[key]),
                tostring(newValue)
            ))
        end
    }

    local readonlyTable = {}
    setmetatable(readonlyTable, metatable)

    --region try add modifier
    local proxyMetaTable = getmetatable(proxyTable)
    if
        proxyMetaTable ~= nil and
        proxyMetaTable._type ~= nil and
        proxyMetaTable._name ~= nil and
        type(proxyMetaTable._modifiers) == "table" and
        proxyMetaTable._interfaces ~= nil and
        proxyMetaTable.__tostring ~= nil
    then
        table.insert(proxyMetaTable._modifiers, "readonly")
        metatable._readonly = "_readonly"
    end
    --endregion
    return readonlyTable  
end
