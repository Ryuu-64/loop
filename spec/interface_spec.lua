package.path = package.path .. ";../src/org/ryuu/loop/internal/?.lua"
local keyword = require "top.ryuu.loop.internal.keyword"
local type_meta_data = require "top.ryuu.loop.internal.type_meta_data"
local interface = require "top.ryuu.loop.keyword.interface"

describe("interface 功能", function()
    before_each(function()
        type_meta_data.clear()
    end)

    describe("传入名称时", function()
        it("应该正常创建接口", function()
            local MyInterface = interface("MyInterface")
            assert.are.equal("MyInterface", MyInterface._name)
            assert.are.equal(keyword.interface, MyInterface._attribute)
            assert.are.equal(nil, MyInterface._base)
            assert.are.equal(#MyInterface._interfaces, 0)
            assert.is_table(MyInterface._interfaces)
        end)
    end)
end)
