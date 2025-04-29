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
    describe("when passing function", function()
        it("should handle functions as first-class citizens", function()
            local func = function() return 42 end
            local readonly_func = readonly(func)
            assert.are.equal(42, readonly_func())
            if type(readonly_func) == "function" then
                readonly_func = function() return 0 end
                assert.are_not.equal(42, readonly_func())
            end
        end)
    end)

    describe("when passing coroutine", function()
        it("should query coroutine status", function()
            local co = coroutine.create(function()
                coroutine.yield()
            end)
            local ro_co = readonly(co)
            assert.equal("suspended", ro_co.status)
        end)

        it("should prevent field injection", function()
            local co = readonly(coroutine.create(function() end))
            assert.has_error(function() co.new_field = 42 end)
        end)
    end)

    describe("when passing primitive types", function()
        it("should return origin ", function()
            local nil_val = readonly(nil)
            assert.equal(nil, nil_val)
            local true_val = readonly(true)
            assert.equal(true, true_val)
            local false_val = readonly(false)
            assert.equal(false, false_val)
            local num = readonly(42)
            assert.equal(42, num)
            local str = readonly("string")
            assert.equal("string", str)
        end)
    end)
end)
