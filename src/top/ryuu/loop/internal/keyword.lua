local readonly = require "top.ryuu.loop.keyword.readonly"

---@class keyword:table readonly
---@field interface string type keyword
---@field class string type keyword
---@field object string type keyword
---@field readonly string modifier
---@field is string operator
---@field throw string statement
---@field base string access keyword
return readonly({
    --region type keyword
    interface = "interface",
    class = "class",
    object = "object",
    --endregion
    readonly = "readonly",
    is = "is",
    throw = "throw",
    base = "_base"
})
