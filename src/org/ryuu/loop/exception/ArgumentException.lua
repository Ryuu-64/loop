﻿local Exception = require "org.ryuu.loop.exception.Exception"
local class = require "org.ryuu.loop.lang.keyword.class"

---@class ArgumentException:Exception
local ArgumentException = class("ArgumentException", Exception)
return ArgumentException