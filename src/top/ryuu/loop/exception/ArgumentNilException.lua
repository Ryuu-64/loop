﻿local class = require "top.ryuu.loop.keyword.class"
local ArgumentException = require "top.ryuu.loop.exception.ArgumentException"

---@class ArgumentNilException:ArgumentException
local ArgumentNilException = class("ArgumentNilException", ArgumentException)
return ArgumentNilException
