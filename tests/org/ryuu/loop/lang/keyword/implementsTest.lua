require "InitializePackagePathForTests"

local class = require "org.ryuu.loop.keyword.class"
local interface = require "org.ryuu.loop.keyword.interface"
local implements = require "org.ryuu.loop.keyword.implements"

local implementsTestInterface = interface("implementsTestInterface")

local implementsTestClass = class("implementsTestClass")

implements(implementsTestClass, { implementsTestInterface })
implements(implementsTestInterface, nil)
