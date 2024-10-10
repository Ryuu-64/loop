local keyword = require "org.ryuu.loop.internal.keyword"
local ClassMetadataTable = require "org.ryuu.loop.internal.class.ClassMetadataTable"
local Exception = require "org.ryuu.loop.exception.Exception"

---@class NilException:Exception
local NilException = setmetatable({}, Exception)
NilException.__index = NilException
NilException._name = "NilException"
NilException._type = keyword.class
NilException._interfaces = {}

ClassMetadataTable.Add(NilException, NilException._name)
ClassMetadataTable.AddBase(NilException, Exception)

return NilException
