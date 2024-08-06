require "InitializePackagePathForTests"

local class = require "org.ryuu.loop.lang.keyword.class"
local Assertions = require "org.ryuu.lunit.Assertions"

local ClassForClassTest = class("ClassForClassTest")


local FunctionDeepToString = function(self)
    local info = debug.getinfo(self, "uS")
    local paramLength = info.nparams
    local isVarArg = info.isvararg
    local params = {}
    for i = 1, paramLength do
        table.insert(params, "param" .. i)
    end

    if isVarArg then
        table.insert(params, "...")
    end

    local paramsString = table.concat(params, ", ")
    return string.format("function(%s) %s", paramsString, tostring(self))
end



function ClassForClassTest:new(foo, bar)
    print(self, foo, bar)
    local instance = ClassForClassTest.base(self)
    instance.foo = foo
    instance.bar = bar
    return instance
end

local obj

obj = ClassForClassTest:new(37, 42)
Assertions.AssertEqual(37, obj.foo)
Assertions.AssertEqual(42, obj.bar)

local ClassForClassTest2 = class("ClassForClassTest2", ClassForClassTest)

function ClassForClassTest2:new(foo, bar)
    print(FunctionDeepToString(ClassForClassTest2.base))
    return ClassForClassTest2.base(self, foo, bar)
end

obj = ClassForClassTest2:new(37, 42)
Assertions.AssertEqual(37, obj.foo)
Assertions.AssertEqual(42, obj.bar)

Assertions.Result()
