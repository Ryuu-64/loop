package.path = package.path .. ";../src/org/ryuu/loop/keyword/?.lua"
local type = require "top.ryuu.loop.keyword.type"
local object = require "top.ryuu.loop.keyword.object"
local is = require "top.ryuu.loop.keyword.is"

describe("Is Test Suite", function()
    it("type is object", function()
        local type_is_object = is(type, object)
        assert.equal(true, type_is_object)
    end)
end)
