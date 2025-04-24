package.path = package.path .. ";../src/org/ryuu/loop/internal/?.lua"
local keyword = require "top.ryuu.loop.internal.keyword"
local create_class = require "top.ryuu.loop.internal.create_class"

describe("Create Type Test Suite", function()
    it("should create class", function()
        local MyClass = create_class("MyClass", keyword.class)
        assert.are.equal("MyClass", MyClass._name)
        assert.are.equal("class", MyClass._attribute)
        assert.is_table(MyClass._interfaces)
        assert.are.equal(#MyClass._interfaces, 0)
    end)

    it("should create interface", function()
        local MyInterface = create_class("MyInterface", keyword.interface)
        assert.are.equal("MyInterface", MyInterface._name)
        assert.are.equal("interface", MyInterface._attribute)
        assert.is_table(MyInterface._interfaces)
        assert.are.equal(#MyInterface._interfaces, 0)
    end)
end)
