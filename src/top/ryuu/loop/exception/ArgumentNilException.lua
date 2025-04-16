local class = require "top.ryuu.loop.keyword.class"
local ArgumentException = require "top.ryuu.loop.exception.ArgumentException"

---@class ArgumentNilException:ArgumentException
return class("ArgumentNilException", ArgumentException)
