require "InitializePackagePathForTests"

local Dictionary = require "org.ryuu.loop.collection.Dictionary"
local Assertions = require "org.ryuu.lunit.Assertions"

local dic = Dictionary:new()

Assertions.AssertEqual(0, dic:Count())

dic:Add(1, 1)
Assertions.AssertEqual(1, dic:Count())

Assertions.Result()
