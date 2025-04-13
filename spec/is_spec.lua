package.path = package.path .. ";../src/org/ryuu/loop/keyword/?.lua"
local type = require "org.ryuu.loop.keyword.type"
local object = require "org.ryuu.loop.keyword.object"
local is = require "org.ryuu.loop.keyword.is"

describe("Is Test Suite", function()
    it("type is object", function()
        local type_is_object = is(type, object)
        assert.equal(true, type_is_object)
    end)
end)
