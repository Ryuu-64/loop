local class = require "org.ryuu.loop.keyword.class"
local Exception = require "org.ryuu.loop.exception.Exception"

---@class ArgumentException:Exception
local ArgumentException = class("ArgumentException", Exception)

return ArgumentException
