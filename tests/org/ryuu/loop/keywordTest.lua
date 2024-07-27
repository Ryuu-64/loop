require "org.ryuu.loop.InitializePackagePathForTests"

local keyword = require "org.ryuu.loop.lang.keyword"
local Assertions = require "org.ryuu.lunit.Assertions"

local function KeywordIsReadonlyTest()
    keyword.class = "foo"
    Assertions.AssertEqual("class", keyword.class)
    Assertions.Result()
end

KeywordIsReadonlyTest()
