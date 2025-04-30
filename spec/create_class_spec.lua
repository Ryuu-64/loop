package.path = package.path .. ";../src/org/ryuu/loop/internal/?.lua"
local keyword = require "top.ryuu.loop.internal.keyword"
local runtime = require "top.ryuu.loop.runtime.runtime"
local create_type = runtime.create_type

describe("Create type test suite", function()
    it("should create class type", function()
        local MyClass = create_type("MyClass", keyword.class)
        assert.are.equal("MyClass", MyClass._name)
        assert.are.equal("class", MyClass._attribute)
        assert.is_table(MyClass._interfaces)
        assert.are.equal(#MyClass._interfaces, 0)
    end)

    it("should create interface type", function()
        local MyInterface = create_type("MyInterface", keyword.interface)
        assert.are.equal("MyInterface", MyInterface._name)
        assert.are.equal("interface", MyInterface._attribute)
        assert.is_table(MyInterface._interfaces)
        assert.are.equal(#MyInterface._interfaces, 0)
    end)
end)
