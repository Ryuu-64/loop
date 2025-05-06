local keyword = require "top.ryuu.loop.internal.keyword"
local create_type = require "top.ryuu.loop.runtime.create_type"
local is_type = require "top.ryuu.loop.runtime.is_type"

describe("is_type test suite", function()
    it("should return true if is type", function()
        local MyClass = create_type("MyClass", keyword.class)
        local status, message = is_type(MyClass)
        assert.is_true(status)
    end)
end)
