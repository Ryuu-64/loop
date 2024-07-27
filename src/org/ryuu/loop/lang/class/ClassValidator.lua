﻿local keyword = require "org.ryuu.loop.lang.keyword"

local ClassValidator = {}

function ClassValidator.Is(class)
    if type(class) ~= "table" then
        return false
    end

    if class._name == nil then
        return false
    end

    if class._type ~= keyword.class then
        return false
    end

    if type(class._interfaces) ~= "table" then
        return false
    end

    return true
end

return ClassValidator
