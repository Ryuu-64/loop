package.path = package.path .. ";../src/org/ryuu/loop/keyword/?.lua"
local readonly = require "top.ryuu.loop.keyword.readonly"

describe("readonly table", function()
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
