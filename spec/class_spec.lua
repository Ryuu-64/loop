package.path = package.path .. ";../src/org/ryuu/loop/internal/?.lua"
local class = require "top.ryuu.loop.keyword.class"
local object = require "top.ryuu.loop.keyword.object"
local runtime = require "top.ryuu.loop.runtime.runtime"
local meta_data = runtime.meta_data

describe("Class test suite", function()
    describe("Class creation tests", function()
        it("should create a class inheriting from the base class", function()
            local Animal = class("Animal")
            assert.are.equal(getmetatable(Animal), object)
            assert.are.equal(object, Animal._base_type)
        end)

        it("should extend object by default", function()
            local DefaultClass = class("DefaultClass")
            assert.are.equal(getmetatable(DefaultClass), object)
        end)
    end)

    describe("Exception handling tests", function()
        it("should prevent creating duplicate class names", function()
            class("UniqueClass")

            assert.has_error(
                function()
                    class("UniqueClass")
                end,
                "Type already exist, name=UniqueClass."
            )
        end)

        it("should reject non-class as base classes", function()
            local invalidBase = {}
            assert.has_error(
                function()
                    class("InvalidBaseClass", invalidBase)
                end,
                "Invalid base class."
            )
        end)
    end)

    describe("Meta-data system integration tests", function()
        it("should register new class in meta-data system", function()
            local MetaClass = class("MetaClass")
            assert.is_true(meta_data.has("MetaClass"))
            local metadata = meta_data.name_type_map["MetaClass"]
            assert.are.equal(metadata._name, "MetaClass")
        end)
    end)

    describe("new() tests", function()
        it("should passing parameters for new()", function()
            local ClassA = class("ClassA")
            local self_in_a
            function ClassA:new(a)
                local instance = ClassA._base_type.new(self)
                instance.a = a
                self_in_a = self
                return instance
            end

            local ClassB = class("ClassB", ClassA)
            local self_in_b
            function ClassB:new(a, b)
                local instance = ClassB._base_type.new(self, a)
                instance.b = b
                self_in_b = self
                return instance
            end

            local ClassC = class("ClassC", ClassB)
            local self_in_c
            function ClassC:new(a, b, c)
                local instance = ClassC._base_type.new(self, a, b)
                instance.c = c
                self_in_c = self
                return instance
            end

            local ClassD = class("ClassD", ClassC)
            local self_in_d
            function ClassD:new(a, b, c, d)
                local instance = ClassD._base_type.new(self, a, b, c)
                instance.d = d
                self_in_d = self
                return instance
            end

            local instance = ClassD:new("a", "b", "c", "d")
            assert.are.equal("a", instance.a)
            assert.are.equal("b", instance.b)
            assert.are.equal("c", instance.c)
            assert.are.equal("d", instance.d)

            assert.are.equal(self_in_a, ClassD)
            assert.are.equal(self_in_b, ClassD)
            assert.are.equal(self_in_c, ClassD)
            assert.are.equal(self_in_d, ClassD)
        end)
    end)

    describe("inheritance test", function()
        it("should inherit the base class's __tostring function", function()
            local BaseClass = class("BaseClass")
            function BaseClass:__tostring()
                return "BaseClass Instance"
            end

            local ChildClass = class("ChildClass", BaseClass)
            local instance = ChildClass:new()

            assert.are.equal("BaseClass Instance", tostring(instance))
        end)

        it("should override parent class fucntion", function()
            ---@class Parent:Class
            local Parent = class("Parent")
            function Parent:greet()
                return "Hello from Parent"
            end

            ---@class Child:Parent
            local Child = class("Child", Parent)
            function Child:greet()
                ---@class Parent
                local base = self._base_type
                return base.greet(self) .. " and Child"
            end

            local instance = Child:new()
            assert.are.equal(instance:greet(), "Hello from Parent and Child")
        end)
    end)
end)
