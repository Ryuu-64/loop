local class = require "org.ryuu.loop.keyword.class"
local Exception = require "org.ryuu.loop.exception.Exception"

---@class NilException:Exception
local NilException = class("NilException", Exception)

return NilException
