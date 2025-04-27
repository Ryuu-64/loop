package.path = package.path .. ";../src/org/ryuu/loop/keyword/?.lua"
local object = require "top.ryuu.loop.keyword.object"
local class = require "top.ryuu.loop.keyword.class"
local meta_data = require "top.ryuu.loop.internal.meta_data"

describe("Object test suite", function()
    before_each(function()
        meta_data.clear()
    end)

    describe("new()", function()
        it("should create instance with correct metatable setup", function()
            local instance = object:new()
            assert.is_table(instance, "instance should be a table")
            assert.are.equal(instance._type, object, "_type should point to object")
            assert.are_not.equal(instance, object, "instance should not be object")
            assert.are.equal(getmetatable(instance), object, "metatable should point to object")
            assert.are.equal(getmetatable(instance).__index, object, "__index should point to object")
        end)
    end)

    describe("__eq", function()
        it("should return true for same instance references", function()
            local a = object:new()
            local b = a
            assert.is_true(a == b, "identical references should be equal")
        end)

        it("should return false for different instances", function()
            local a = object:new()
            local b = object:new()
            assert.is_false(a == b, "不同实例应不相等")
        end)
    end)

    describe("inheritance", function()
        it("subclass instances should inherit from object", function()
            local Child = class("Child")
            local instance = Child:new()
            assert.are.equal(instance._type, Child, "_type should point to subclass")
            assert.are.equal(instance._type._base, object, "base class should be object")
        end)
    end)

    describe("constructor()", function()
        it("should invoke base class new function", function()
            local Child = class("Child")
            spy.on(object, "new")
            Child:new()
            assert.spy(object.new).was.called_with(match.is_ref(Child))
        end)

        it("should passing parameters to base classes", function()
            local ClassA = class("ClassA")
            function ClassA:new(foo)
                local instance = ClassA:constructor()
                instance.foo = foo
                return instance
            end

            local ClassB = class("ClassB", ClassA)
            function ClassB:new(foo, bar)
                local instance = ClassB:constructor(foo)
                instance.bar = bar
                return instance
            end

            spy.on(ClassB, "new")
            spy.on(ClassA, "new")
            ClassB:new(37, 42)
            assert.spy(ClassB.new)
                .was.called_with(
                match.is_ref(ClassB),
                37,
                42
            )
            assert.spy(ClassA.new)
                .was.called_with(
                match.is_ref(ClassB),
                37
            )
        end)
    end)

    describe("exception handling", function()
        it("should throw error when non-object calls new()", function()
            assert.has_error(
                function()
                    object.new("invalid_self")
                end,
                -- todo throw custom error instead
                "bad argument #2 to 'setmetatable' (nil or table expected, got string)"
            )
        end)
    end)
end)
