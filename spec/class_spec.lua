package.path = package.path .. ";../src/org/ryuu/loop/internal/?.lua"
local class = require "top.ryuu.loop.keyword.class"
local object = require "top.ryuu.loop.keyword.object"
local meta_data = require "top.ryuu.loop.internal.meta_data"

describe("Class 创建功能测试套件", function()
    it("应正确创建继承基类的类型", function()
        local Animal = class("Animal")
        assert.are.equal(getmetatable(Animal), object)
        assert.are.equal(object, Animal._base)
    end)

    it("should extend object by default", function()
        local DefaultClass = class("DefaultClass")
        assert.are.equal(getmetatable(DefaultClass), object)
    end)
end)

describe("异常场景处理测试", function()
    it("应阻止重复类名创建", function()
        class("UniqueClass")

        assert.has_error(
            function()
                class("UniqueClass")
            end,
            "Type already exist, name=UniqueClass."
        )
    end)

    it("应拒绝非类类型作为基类", function()
        local invalidBase = {}
        assert.has_error(
            function()
                class("InvalidBaseClass", invalidBase)
            end,
            "Invalid base class."
        )
    end)
end)

describe("元数据系统集成测试", function()
    it("应在类型元数据系统中注册新类", function()
        local MetaClass = class("MetaClass")
        assert.is_true(meta_data.has("MetaClass"))
        local metadata = meta_data.name_type_map["MetaClass"]
        assert.are.equal(metadata._name, "MetaClass")
    end)
end)

describe("为new传参", function()
    it("", function()
        local ClassA = class("ClassA")
        local self_in_a
        function ClassA:new(a)
            local this = ClassA:constructor()
            this.a = a
            self_in_a = self
            return this
        end

        local ClassB = class("ClassB", ClassA)
        local self_in_b
        function ClassB:new(a, b)
            local this = ClassB:constructor(a)
            this.b = b
            self_in_b = self
            return this
        end

        local ClassC = class("ClassC", ClassB)
        local self_in_c
        function ClassC:new(a, b, c)
            local this = ClassC:constructor(a, b)
            this.c = c
            self_in_c = self
            return this
        end

        local ClassD = class("ClassD", ClassC)
        local self_in_d
        function ClassD:new(a, b, c, d)
            local this = ClassD:constructor(a, b, c)
            this.d = d
            self_in_d = self
            return this
        end

        local instance = ClassD:new("a", "b", "c", "d")
        assert.are.equal("a", instance.a)
        assert.are.equal("b", instance.b)
        assert.are.equal("c", instance.c)
        assert.are.equal("d", instance.d)

        assert.are.equal(self_in_a, ClassB)
        assert.are.equal(self_in_b, ClassC)
        assert.are.equal(self_in_c, ClassD)
        assert.are.equal(self_in_d, ClassD)
    end)
end)

describe("方法继承测试", function()
    it("应继承基类的 __tostring 方法", function()
        local BaseClass = class("BaseClass")
        function BaseClass:__tostring()
            return "BaseClass Instance"
        end

        local ChildClass = class("ChildClass", BaseClass)
        local instance = ChildClass:new()

        assert.are.equal(tostring(instance), "BaseClass Instance")
    end)

    it("应重写父类方法", function()
        ---@class Parent:Class
        local Parent = class("Parent")
        function Parent:greet()
            return "Hello from Parent"
        end

        ---@class Child:Parent
        local Child = class("Child", Parent)
        function Child:greet()
            ---@class Parent
            local base = self._base
            return base.greet(self) .. " and Child"
        end

        local instance = Child:new()
        assert.are.equal(instance:greet(), "Hello from Parent and Child")
    end)
end)
