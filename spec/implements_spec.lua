local implements = require "top.ryuu.loop.keyword.implements"
local interface = require "top.ryuu.loop.keyword.interface"
local class = require "top.ryuu.loop.keyword.class"
local meta_data = require "top.ryuu.loop.internal.meta_data"

describe("Implements test suite", function()
    before_each(function()
        meta_data.clear()
    end)

    describe("When passing classes and interfaces", function()
        it("should implement interface", function()
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
        it("should throw error when class doesn't implement interface functions", function()
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
        it("should implement multiple interfaces", function()
            local InterfaceA = interface("InterfaceA")
            function InterfaceA.functionA()
            end

            local InterfaceB = interface("InterfaceB")
            function InterfaceB.functionB()
            end

            local MyClass = class("MyClass")
            function MyClass.functionA()
            end

            function MyClass.functionB()
            end

            assert.has_no.errors(function()
                implements(MyClass, { InterfaceA, InterfaceB })
            end)
        end)
        it("should inherit interface implementation from base class", function()
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
        it("should implement all functions in interface inheritance chain", function()
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
    describe("Method signature validation", function()
        it("should throw error when parameter count mismatch", function()
            local ParamInterface = interface("ParamInterface")
            function ParamInterface.func(a, b)
            end

            local ParamClass = class("ParamClass")
            function ParamClass.func(a)
            end

            assert.has_error(
                function()
                    implements(ParamClass, { ParamInterface })
                end,
                "Exception(message=invalid implements parameters, inner_exception=Exception(message=Error implementing interfaces 'ParamInterface' for 'ParamClass': Can't implement interface 'ParamInterface': Function 'func' is not implemented: Incorrect number of arguments. Expected 2 arguments,but 1 was provided.))"
            )
        end)
    end)
end)
