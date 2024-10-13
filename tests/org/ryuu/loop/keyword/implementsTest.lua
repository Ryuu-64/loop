require "InitializePackagePathForTests"

local class = require "org.ryuu.loop.keyword.class"
local interface = require "org.ryuu.loop.keyword.interface"
local implements = require "org.ryuu.loop.keyword.implements"

local implementsTestInterface0 = interface("implementsTestInterface0")
local implementsTestInterface1 = interface("implementsTestInterface1")

local implementsTestClass = class("implementsTestClass")

implements(implementsTestInterface0, { implementsTestInterface1 })
implements(implementsTestClass, { implementsTestInterface0 })
