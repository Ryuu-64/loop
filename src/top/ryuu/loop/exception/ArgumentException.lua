﻿local class = require "top.ryuu.loop.keyword.class"
local Exception = require "top.ryuu.loop.exception.Exception"

---@class ArgumentException:Exception
local ArgumentException = class("ArgumentException", Exception)
return ArgumentException
