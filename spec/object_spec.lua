package.path = package.path .. ";../src/org/ryuu/loop/keyword/?.lua"
local object = require "top.ryuu.loop.keyword.object"
local class = require "top.ryuu.loop.keyword.class"
local meta_data = require "top.ryuu.loop.internal.meta_data"

describe("object 基类测试", function()
    before_each(function()
        meta_data.clear()
    end)

    -- 基础实例化测试
    describe("new() 方法", function()
        it("应正确创建实例并设置元表", function()
            local instance = object:new()
            assert.is_table(instance, "实例应为表")
            assert.are.equal(instance._type, object, "_type 属性应指向 object 类")
            assert.are_not.equal(instance, object, "instance 本身不应该是 object 类")
            assert.are.equal(getmetatable(instance), object, "元表应指向 object 类")
            assert.are.equal(getmetatable(instance).__index, object, "")
        end)
    end)

    -- 相等性测试
    describe("__eq 元方法", function()
        it("相同实例应返回 true", function()
            local a = object:new()
            local b = a
            assert.is_true(a == b, "相同引用应相等")
        end)

        it("不同实例应返回 false", function()
            local a = object:new()
            local b = object:new()
            assert.is_false(a == b, "不同实例应不相等")
        end)
    end)

    -- 继承测试
    describe("继承机制", function()
        it("子类实例应继承 object 属性", function()
            local Child = class("Child")
            local instance = Child:new()
            assert.are.equal(instance._type, Child, "_type 应指向子类")
            assert.are.equal(instance._type._base, object, "基类应为 object")
        end)
    end)

    -- 构造函数测试
    describe("constructor() 方法", function()
        it("应调用基类的 new 方法", function()
            local Child = class("Child")
            spy.on(object, "new")
            Child:new()
            assert.spy(object.new).was.called_with(match.is_ref(Child))
        end)

        it("应传递构造参数到基类", function()
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

    -- 异常场景测试
    describe("异常处理", function()
        it("非对象类型调用 new 应报错", function()
            assert.has_error(
                function()
                    object.new("invalid_self")
                end,
                -- todo
                "bad argument #2 to 'setmetatable' (nil or table expected, got string)"
            )
        end)
    end)
end)
