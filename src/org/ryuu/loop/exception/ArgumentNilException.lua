local class = require "org.ryuu.loop.keyword.class"
local ArgumentException = require "org.ryuu.loop.exception.ArgumentException"

---@class ArgumentNilException:ArgumentException
local ArgumentNilException = class("ArgumentNilException", ArgumentException)

return ArgumentNilException
