require "InitializePackagePathForTests"

local Exception = require "org.ryuu.loop.exception.Exception"

local a = Exception:new("foo")
print(a)
