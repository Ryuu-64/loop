require "InitializePackagePathForTests"

local is = require "org.ryuu.loop.keyword.is"
local class = require "org.ryuu.loop.keyword.class"
local Assertions = require "org.ryuu.lunit.Assertions"

local function isTest()
    local TestClassForIsTest = class("TestClassForIsTest")
    local obj = TestClassForIsTest:new()

    Assertions.AssertTrue(is(obj, TestClassForIsTest))
    Assertions.Result()
end

isTest()
