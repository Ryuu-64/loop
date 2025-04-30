package.path = package.path .. ";../src/org/ryuu/loop/internal/?.lua"
local keyword = require "top.ryuu.loop.internal.keyword"
local interface = require "top.ryuu.loop.keyword.interface"
local runtime = require "top.ryuu.loop.runtime.runtime"
local meta_data = runtime.meta_data

describe("Interface test suite", function()
    before_each(function()
        meta_data.clear()
    end)

    describe("when passing name", function()
        it("should create interface", function()
            local MyInterface = interface("MyInterface")
            assert.are.equal("MyInterface", MyInterface._name)
            assert.are.equal(keyword.interface, MyInterface._attribute)
            assert.are.equal(nil, MyInterface._base_type)
            assert.are.equal(#MyInterface._interfaces, 0)
            assert.is_table(MyInterface._interfaces)
        end)
    end)
end)
