﻿local keyword = require "org.ryuu.loop.lang.keyword"
local MetadataTable = require "org.ryuu.loop.lang.runtime.ClassMetadataTable"
local Exception = require "org.ryuu.loop.exception.Exception"

---@class NilException:Exception
local NilException = setmetatable({}, Exception)
NilException.__index = NilException
NilException._name = "NilException"
NilException._type = keyword.class
NilException._interfaces = {}

MetadataTable.Add(NilException, NilException._name)
MetadataTable.AddBase(NilException, Exception)

return NilException