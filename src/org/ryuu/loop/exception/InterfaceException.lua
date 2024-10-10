local keyword = require "org.ryuu.loop.internal.keyword"
local ClassMetadataTable = require "org.ryuu.loop.internal.class.ClassMetadataTable"
local Exception = require "org.ryuu.loop.exception.Exception"

---@class InterfaceException:Exception
local InterfaceException = setmetatable({}, Exception)
InterfaceException.__index = InterfaceException
InterfaceException._name = "InterfaceException"
InterfaceException._type = keyword.class
InterfaceException._interfaces = {}

ClassMetadataTable.Add(InterfaceException, InterfaceException._name)
ClassMetadataTable.AddBase(InterfaceException, Exception)

return InterfaceException
