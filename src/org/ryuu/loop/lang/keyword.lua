local readonly = require "org.ryuu.loop.lang.keyword.readonly"

---
---@class keyword readonly
---@field interface string type keyword
---@field class string type keyword
---@field this string access keyword
---@field readonly string modifier
---@field is string operator
---@field object string type keyword
local keyword = {}
keyword.interface = "interface";
keyword.class = "class";
keyword.this = "this";
keyword.readonly = "readonly";
keyword.is = "is";
keyword.object = "object";
return readonly(keyword)
