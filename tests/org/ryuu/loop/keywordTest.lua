local a = 0

function change()
    a = 32313123123
end

function pri()
    print(a)
end

change()
pri()

function m1()
    local x = 1
    return function()
        x = x + 1
        print(x)
    end
end

local m2 = m1()
local m3 = m1

m1()()
m1()()
m1()()

m2()
m2()
m2()

m3()()
m3()()
m3()()

print(m1 == m1)
print(m1 == m2)
print(m1 == m3)

require "InitializePackagePathForTests"

local keyword = require "org.ryuu.loop.internal.keyword"
local Assertions = require "org.ryuu.lunit.Assertions"

local function KeywordIsReadonlyTest()
    keyword.class = "foo"
    Assertions.AssertEqual("class", keyword.class)
    Assertions.Result()
end

KeywordIsReadonlyTest()
