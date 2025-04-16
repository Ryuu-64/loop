package.path = package.path .. ";../src/org/ryuu/loop/internal/?.lua"
local interface = require "top.ryuu.loop.keyword.interface"
local keyword = require "top.ryuu.loop.internal.keyword"

describe("Interface Test Suite", function()
    it("should create class", function()
        local MyInterface = interface("MyInterface")
        assert.are.equal("MyInterface", MyInterface._name)
        assert.are.equal(keyword.interface, MyInterface._attribute)
        assert.is_table(MyInterface._interfaces)
        assert.are.equal(#MyInterface._interfaces, 0)
    end)
end)
