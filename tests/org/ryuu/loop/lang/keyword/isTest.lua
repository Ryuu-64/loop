require "org.ryuu.loop.InitializePackagePathForTests"

local is = require "org.ryuu.loop.lang.keyword.is"
local class = require "org.ryuu.loop.lang.keyword.class"
local Assertions = require "org.ryuu.lunit.Assertions"

local function isTest()
    local TestClassForIsTest = class("TestClassForIsTest")
    local obj = TestClassForIsTest:new()

    Assertions.AssertTrue(is(obj, TestClassForIsTest))
    Assertions.Result()
end

isTest()
