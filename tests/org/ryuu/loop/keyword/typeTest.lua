require "InitializePackagePathForTests"

local type = require "org.ryuu.loop.keyword.type"
local object = require "org.ryuu.loop.keyword.object"
local is = require "org.ryuu.loop.keyword.is"
local Assertions = require "org.ryuu.lunit.Assertions"

local isType = is(type, object)

Assertions.AssertTrue(isType)
Assertions.Result()
