local readonly = require "org.ryuu.loop.keyword.readonly"

---@class keyword readonly
---@field interface string type keyword
---@field class string type keyword
---@field object string type keyword
---@field readonly string modifier
---@field is string operator
---@field throw string statement
local keyword = {
    interface = "interface",
    class = "class",
    object = "object",
    readonly = "readonly",
    is = "is",
    throw = "throw"
}
return readonly(keyword)
