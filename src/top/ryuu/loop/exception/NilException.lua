local class = require "top.ryuu.loop.keyword.class"
local Exception = require "top.ryuu.loop.exception.Exception"

---@class NilException:Exception
local NilException = class("NilException", Exception)
function NilException:new(message, inner_exception)
    return NilException:constructor(message, inner_exception)
end

return NilException
