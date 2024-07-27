local keyword = require "org.ryuu.loop.lang.keyword"
local ClassImplements = require "org.ryuu.loop.lang.class.ClassImplements"
local InterfaceImplements = require "org.ryuu.loop.lang.interface.InterfaceImplements"
local ArgumentException = require "org.ryuu.loop.exception.ArgumentException"

---
---@param type type
---@param interfaces table<type>
---@return void
local implements = function(type, interfaces)
    if type._type == keyword.class then
        ClassImplements.implements(type, interfaces)
        return
    end

    if type._type == keyword.interface then
        InterfaceImplements.implements(type, interfaces)
        return
    end

    error(tostring(ArgumentException:new("type invalid")))
end

return implements
