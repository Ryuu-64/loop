﻿local keyword = require "org.ryuu.loop.internal.keyword"
local ClassMetadataTable = require "org.ryuu.loop.internal.class.ClassMetadataTable"
local ArgumentException = require "org.ryuu.loop.exception.ArgumentException"

---@class ArgumentNilException:Exception
local ArgumentNilException = setmetatable({}, ArgumentException)
ArgumentNilException.__index = ArgumentNilException
ArgumentNilException._name = "ArgumentNilException"
ArgumentNilException._type = keyword.class
ArgumentNilException._interfaces = {}

ClassMetadataTable.Add(ArgumentNilException, ArgumentNilException._name)
ClassMetadataTable.AddBase(ArgumentNilException, ArgumentException)

return ArgumentNilException