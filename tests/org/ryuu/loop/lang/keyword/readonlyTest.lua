require "InitializePackagePathForTests"

local class = require "org.ryuu.loop.keyword.class"
local object = require "org.ryuu.loop.keyword.object"
local readonly = require "org.ryuu.loop.keyword.readonly"
local Assertions = require "org.ryuu.lunit.Assertions"

---
---@class ClassForReadonlyTest:object
---@field foo number
local ClassForReadonlyTest = class("ClassForReadonlyTest")

---@return ClassForReadonlyTest
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

local function ReadonlyMetatableCantModifyTest()
    ---@type ClassForReadonlyTest
    local readonlyObj = readonly(ClassForReadonlyTest:new())
    readonlyObj._name = 1
    Assertions.AssertEqual("ClassForReadonlyTest", readonlyObj._name)
    Assertions.Result()
end

local function ReadonlyTablesMemberTest()
    local readonlyObj = readonly({ foo = 37 })
    readonlyObj.foo = 1
    Assertions.AssertEqual(37, readonlyObj.foo)
    Assertions.Result()
end

local function ReadonlyTablesMetatableTest()
    local table = {}
    local metaTable = {
        foo = 37
    }
    setmetatable(table, metaTable)
    local readonlyObj = readonly(table)

    table.foo = 42
    Assertions.AssertEqual(42, readonlyObj.foo)
    Assertions.Result()
end

local function ReadonlyTablesInnerTableTest()
    local table = {
        innerTable = {
            foo = 37
        }
    }
    local readonlyObj = readonly(table)
    readonlyObj.innerTable.foo = 42
    Assertions.AssertEqual(42, readonlyObj.innerTable.foo)
    Assertions.Result()
end

ReadonlyCantModifyTest()
ReadonlyMetatableCantModifyTest()

ReadonlyTablesMemberTest()
ReadonlyTablesMetatableTest()
ReadonlyTablesInnerTableTest()
