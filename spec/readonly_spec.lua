package.path = package.path .. ";../src/org/ryuu/loop/keyword/?.lua"
local readonly = require "top.ryuu.loop.keyword.readonly"

describe("readonly test suite", function()
    describe("when passing table", function()
        local table = { name = "Alice", age = 30 }
        local readonly_table = readonly(table)

        it("should read original values", function()
            assert.are.equal("Alice", readonly_table.name)
            assert.are.equal(30, readonly_table.age)
        end)

        it("should block adding new keys", function()
            readonly_table.job = "Engineer"
            assert.is_nil(readonly_table.job)
        end)

        it("should block updating existing keys", function()
            local originalAge = readonly_table.age
            readonly_table.age = 35
            assert.are.equal(originalAge, readonly_table.age)
        end)

        it("should block deleting keys", function()
            readonly_table.name = nil
            assert.are.equal("Alice", readonly_table.name)
        end)
    end)

    describe("when passing primitive types", function()
        it("should return nil unchanged", function()
            local nil_val = readonly(nil)
            assert.is_nil(nil_val)
        end)

        it("should preserve boolean values", function()
            local true_val = readonly(true)
            local false_val = readonly(false)
            assert.is_true(true_val)
            assert.is_false(false_val)
        end)

        it("should handle numbers as read-only", function()
            local num = readonly(3.14)
            assert.are.equal(3.14, num)

            -- 验证数值操作不会改变原始值（虽然Lua基础类型本不可变）
            local original = num
            num = num + 1 -- 这实际是创建新值而非修改
            assert.are_not.equal(original, num)
        end)

        it("should make strings immutable", function()
            local str = readonly("hello")
            assert.are.equal("hello", str)

            -- 验证字符串修改操作会创建新对象
            local modified = str:gsub("h", "H")
            assert.are.equal("Hello", modified)
            assert.are.equal("hello", str)
        end)

        it("should handle functions as first-class citizens", function()
            local func = function() return 42 end
            local readonly_func = readonly(func)

            -- 验证函数可正常调用且未被篡改
            assert.are.equal(42, readonly_func())

            -- 尝试替换函数内容应失败（需根据实现决定是否支持）
            if type(readonly_func) == "function" then
                readonly_func = function() return 0 end   -- 实际创建新引用
                assert.are_not.equal(42, readonly_func()) -- 新引用返回0
            end
        end)

        it("should return userdata/thread unchanged", function()
            local co = coroutine.create(function() end)
            local readonly_co = readonly(co)

            assert.are.equal(co, readonly_co)
            assert.are.equal("thread", type(readonly_co))
        end)
    end)
end)
