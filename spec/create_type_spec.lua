package.path = package.path .. ";../src/org/ryuu/loop/internal/?.lua"
local keyword = require "org.ryuu.loop.internal.keyword"
local create_type = require "org.ryuu.loop.internal.create_type"

describe("Create Type Test Suite", function()
    it("should create class", function()
        local MyClass = create_type("MyClass", keyword.class)
        assert.are.equal("MyClass", MyClass._name)
        assert.are.equal("class", MyClass._type)
        assert.is_table(MyClass._interfaces)
        assert.are.equal(#MyClass._interfaces, 0)
    end)

    it("should create interface", function()
        local MyInterface = create_type("MyInterface", keyword.interface)
        assert.are.equal("MyInterface", MyInterface._name)
        assert.are.equal("interface", MyInterface._type)
        assert.is_table(MyInterface._interfaces)
        assert.are.equal(#MyInterface._interfaces, 0)
    end)
end)
