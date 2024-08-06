require "InitializePackagePathForTests"

local Assertions = require "org.ryuu.lunit.Assertions"
local object = require "org.ryuu.loop.lang.keyword.object"
local class = require "org.ryuu.loop.lang.keyword.class"

local function equalsTest()
    local a = object:new()
    local b = object:new()
    Assertions.AssertNotEqual(a, b)
    Assertions.AssertNotRawEqual(a, b)
    Assertions.Result()
end

local function overrideNewTest()
    ---
    ---@class ClassForOverrideNewTest: Object
    ---@field foo number
    ---@field bar number
    local ClassForOverrideNewTest = class("ClassForOverrideNewTest")

    function ClassForOverrideNewTest:new(foo, bar)
        ---@type ClassForOverrideNewTest
        local this = object:new()
        this.foo = foo
        this.bar = bar
        return this
    end

    local obj = ClassForOverrideNewTest:new(37, 42)
    Assertions.AssertEqual(37, obj.foo)
    Assertions.AssertEqual(42, obj.bar)
    Assertions.Result()
end

equalsTest()
overrideNewTest()
