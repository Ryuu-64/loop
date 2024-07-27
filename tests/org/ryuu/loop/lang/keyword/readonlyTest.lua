require "org.ryuu.loop.InitializePackagePathForTests"

local class = require "org.ryuu.loop.lang.keyword.class"
local object = require "org.ryuu.loop.lang.keyword.object"
local readonly = require "org.ryuu.loop.lang.keyword.readonly"
local Assertions = require "org.ryuu.lunit.Assertions"

---
---@class ClassForReadonlyTest:object
---@field foo number
local ClassForReadonlyTest = class("ClassForReadonlyTest")

function ClassForReadonlyTest:new()
    ---@type ClassForReadonlyTest
    local this = object.new(self)
    this.foo = 37
    return this
end

local function ReadonlyCantModifyTest()
    local readonlyObj = readonly(ClassForReadonlyTest:new())
    readonlyObj.foo = 1
    Assertions.AssertEqual(37, readonlyObj.foo)
    Assertions.Result()
end

local function ReadonlyModifiersTest()
    local readonlyObj = readonly(ClassForReadonlyTest:new())
    Assertions.AssertEqual("readonly", readonlyObj._modifiers[1])
    Assertions.Result()
end

local function ReadonlyMetatableCantModifyTest()
    ---@type ClassForReadonlyTest
    local readonlyObj = readonly(ClassForReadonlyTest:new())
    readonlyObj._name = 1
    Assertions.AssertEqual("ClassForReadonlyTest", readonlyObj._name)
    Assertions.Result()
end

ReadonlyCantModifyTest()
ReadonlyModifiersTest()
ReadonlyMetatableCantModifyTest()
