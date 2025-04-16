local implements = require "top.ryuu.loop.keyword.implements"
local interface = require "top.ryuu.loop.keyword.interface"
local class = require "top.ryuu.loop.keyword.class"
local type_meta_data = require "top.ryuu.loop.internal.type_meta_data"

describe("implements 功能", function()
    before_each(function()
        type_meta_data.clear()
    end)

    describe("传入类和接口时", function()
        it("类应该 implements 接口", function()
            local MyInterface = interface("MyInterface")
            function MyInterface.foo()
            end
            local MyClass = class("MyClass")
            function MyClass.foo()
            end
            assert.has_no.errors(function()
                implements(MyClass, { MyInterface })
            end)
        end)
        it("当类没有实现接口的方法时，应当报错", function()
            local MyInterface = interface("MyInterface")
            function MyInterface.foo()
            end
            local MyClass = class("MyClass")
            assert.has_error(
                    function()
                        implements(MyClass, { MyInterface })
                    end,
                    "Exception(message=invalid implements parameters, inner_exception=Exception(message=Error implementing interfaces 'MyInterface' for 'MyClass': Can't implement interface 'MyInterface': Function 'foo' is not implemented: No such function.))"
            )
        end)
        it("类应该 implements 多个接口", function()
            local InterfaceA = interface("InterfaceA")
            function InterfaceA.methodA()
            end
            local InterfaceB = interface("InterfaceB")
            function InterfaceB.methodB()
            end

            local MyClass = class("MyClass")
            function MyClass.methodA()
            end
            function MyClass.methodB()
            end
            assert.has_no.errors(function()
                implements(MyClass, { InterfaceA, InterfaceB })
            end)
        end)
        it("类应该从基类实现借口", function()
            local MyInterface = interface("InterfaceE")
            function MyInterface.foo()
            end
            local BaseClass = class("BaseClass")
            function BaseClass.foo()
            end
            local ChildClass = class("ClassE", BaseClass)
            implements(BaseClass, { MyInterface })
            assert.has_no.errors(function()
                implements(ChildClass, { MyInterface })
            end)
        end)
        it("类应实现接口继承链中的所有方法", function()
            local BaseInterface = interface("BaseInterface")
            function BaseInterface.baseFunction()
            end

            local ChildInterface = interface("ChildInterface", BaseInterface)
            function ChildInterface.childFunction()
            end

            local MyClass = class("MyClass")
            function MyClass.baseFunction()
            end
            function MyClass.childFunction()
            end
            assert.has_no.errors(function()
                implements(MyClass, { ChildInterface })
            end)
        end)
    end)
    describe("方法签名校验", function()
        it("应检测参数数量不一致", function()
            local ParamInterface = interface("ParamInterface")
            function ParamInterface.method(a, b)
            end

            local ParamClass = class("ParamClass")
            function ParamClass.method(a)
            end

            assert.has_error(
                    function()
                        implements(ParamClass, { ParamInterface })
                    end,
                    "Exception(message=invalid implements parameters, inner_exception=Exception(message=Error implementing interfaces 'ParamInterface' for 'ParamClass': Can't implement interface 'ParamInterface': Function 'method' is not implemented: Incorrect number of arguments. Expected 2 arguments,but 1 was provided.))"
            )
        end)
    end)
end)
