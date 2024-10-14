require "InitializePackagePathForTests"

local throw = require "org.ryuu.loop.keyword.throw"
local Exception = require "org.ryuu.loop.exception.Exception"

local exception = Exception:new("foo")

throw(exception)
