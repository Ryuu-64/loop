package.path = package.path .. ";../src/org/ryuu/loop/keyword/?.lua"
local object = require "top.ryuu.loop.keyword.object"

describe("object Test Suite", function()
    it("should correctly setup metatable relationships", function()
        assert.is_nil(getmetatable(object), "Metatable of object class not properly cleared")
        local instance = object:new()
        assert.are.equal(getmetatable(instance).__index, object, "Subclass metatable does not point to base class")
    end)

    it("should create valid instances through new() method", function()
        local instance = object:new()
        assert.are.equal(getmetatable(instance), object, "Instance metatable not bound to class")
        assert.is_table(instance, "Instance is not a table structure")
    end)

    it("should validate object identity via __eq meta method", function()
        local instance1 = object:new()
        local instance2 = object:new()
        assert.is_true(instance1 == instance1, "Identity comparison failed for same instance")
        assert.is_falsy(instance1 == instance2, "Incorrect equality between different instances")
    end)
end)
