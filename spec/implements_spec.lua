local implements = require "top.ryuu.loop.keyword.implements"
local interface = require "top.ryuu.loop.keyword.interface"
local class = require "top.ryuu.loop.keyword.class"
local runtime = require "top.ryuu.loop.runtime.runtime"
local meta_data = runtime.meta_data

describe("Implements test suite", function()
    before_each(function()
        meta_data.clear()
    end)

    describe("When passing class and interfaces", function()
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
                "ArgumentException(message=invalid implements parameters, inner_exception=ArgumentException(message=Error implementing interfaces 'MyInterface' for 'MyClass': Can't implement interface 'MyInterface': Function 'foo' is not implemented: No such function.))"
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
                    "ArgumentException(message=invalid implements parameters, inner_exception=ArgumentException(message=Error implementing interfaces 'ParamInterface' for 'ParamClass': Can't implement interface 'ParamInterface': Function 'func' is not implemented: Incorrect number of arguments. Expected 2 arguments,but 1 was provided.))"
                )
            end)
        end)
    end)

    describe("When passing interface and interfaces", function()
        it("should implements", function()
            local ChildInterface = interface("ChildInterface")
            local BaseInterface = interface("BaseInterface")
            assert.has_no.errors(function()
                implements(ChildInterface, { BaseInterface })
            end)
        end)

        it("should throw error when interface invalid", function()
            local MyInterface = interface("MyInterface")
            local InvalidInterface = {}
            assert.has_error(
                function()
                    implements(InvalidInterface, { MyInterface })
                end,
                "ArgumentException(message=parameter is not type, \"_name\" is nil, \"_attribute\" is nil, \"_interfaces\" type is not table.)"
            )
        end)

        it("should throw error when non-table interfaces", function()
            local MyInterface = interface("MyInterface")
            assert.has_error(
                function() implements(MyInterface, "foo") end,
                "ArgumentException(message=\"interfaces\" type is not table.)"
            )
        end)

        it("should throw error when interfaces element is not type", function()
            local MyInterface = interface("MyInterface")
            assert.has_error(
                function() implements(MyInterface, { {} }) end,
                "ArgumentException(message=invalid interfaces element, inner_exception=ArgumentException(message=parameter is not type, \"_name\" is nil, \"_attribute\" is nil, \"_interfaces\" type is not table.))"
            )
        end)
    end)
end)
