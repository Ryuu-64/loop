require "InitializePackagePathForTests"

local class = require "org.ryuu.loop.keyword.class"
local Assertions = require "org.ryuu.lunit.Assertions"

---@class ClassForClassTest:object
local ClassForClassTest = class("ClassForClassTest")

function ClassForClassTest:new(foo, bar)
    local instance = ClassForClassTest.base(self)
    instance.foo = foo
    instance.bar = bar
    return instance
end

local obj

obj = ClassForClassTest:new(37, 42)
Assertions.AssertEqual(37, obj.foo)
Assertions.AssertEqual(42, obj.bar)

---@class ClassForClassTest2:ClassForClassTest
local ClassForClassTest2 = class("ClassForClassTest2", ClassForClassTest)

function ClassForClassTest2:new(foo, bar)
    return ClassForClassTest2.base(self, foo, bar)
end

obj = ClassForClassTest2:new(37, 42)
Assertions.AssertEqual(37, obj.foo)
Assertions.AssertEqual(42, obj.bar)

Assertions.Result()
