require "InitializePackagePathForTests"

local class = require "org.ryuu.loop.keyword.class"
local interface = require "org.ryuu.loop.keyword.interface"
local ClassImplements = require "org.ryuu.loop.internal.class.ClassImplements"

local classForTest = class("classForTest")
local interfaceForTest = interface("classForTest")

ClassImplements.Implements(classForTest, interfaceForTest)
