local s = require 'say'
local pretty = require 'pl.pretty'
local io = io
local type = type
local string_format = string.format
local string_gsub = string.gsub
local io_write = io.write
local io_flush = io.flush
local pairs = pairs

return function(options)
    local busted = require 'busted'
    local handler = require 'busted.outputHandlers.base'()

    local successDot = '+'
    local failureDot = '-'
    local errorDot = '*'
    local pendingDot = '.'

    local pendingDescription = function(pending)
        local name = pending.name

        local string = s('output.pending') .. ' -> ' ..
                pending.trace.short_src .. ' @ ' ..
                pending.trace.currentline ..
                '\n' .. name

        if type(pending.message) == 'string' then
            string = string .. '\n' .. pending.message
        elseif pending.message ~= nil then
            string = string .. '\n' .. pretty.write(pending.message)
        end

        return string
    end

    local failureMessage = function(failure)
        local string = failure.randomseed and ('Random seed: ' .. failure.randomseed .. '\n') or ''
        if type(failure.message) == 'string' then
            string = string .. failure.message
        elseif failure.message == nil then
            string = string .. 'Nil error'
        else
            string = string .. pretty.write(failure.message)
        end

        return string
    end

    local failureDescription = function(failure, isError)
        local string = s('output.failure') .. ' -> '
        if isError then
            string = s('output.error') .. ' -> '
        end

        if not failure.element.trace or not failure.element.trace.short_src then
            string = string ..
                    failureMessage(failure) .. '\n' ..
                    failure.name
        else
            string = string ..
                    failure.element.trace.short_src .. ' @ ' ..
                    failure.element.trace.currentline .. '\n' ..
                    failure.name .. '\n' ..
                    failureMessage(failure)
        end

        if options.verbose and failure.trace and failure.trace.traceback then
            string = string .. '\n' .. failure.trace.traceback
        end

        return string
    end

    local statusString = function()
        local successString = s('output.success_plural')
        local failureString = s('output.failure_plural')
        local pendingString = s('output.pending_plural')
        local errorString = s('output.error_plural')

        local sec = handler.getDuration()
        local successes = handler.successesCount
        local pendings = handler.pendingsCount
        local failures = handler.failuresCount
        local errors = handler.errorsCount

        if successes == 0 then
            successString = s('output.success_zero')
        elseif successes == 1 then
            successString = s('output.success_single')
        end

        if failures == 0 then
            failureString = s('output.failure_zero')
        elseif failures == 1 then
            failureString = s('output.failure_single')
        end

        if pendings == 0 then
            pendingString = s('output.pending_zero')
        elseif pendings == 1 then
            pendingString = s('output.pending_single')
        end

        if errors == 0 then
            errorString = s('output.error_zero')
        elseif errors == 1 then
            errorString = s('output.error_single')
        end

        local formattedTime = string_gsub(string_format('%.6f', sec), '([0-9])0+$', '%1')

        return successes .. ' ' .. successString .. ' / ' ..
                failures .. ' ' .. failureString .. ' / ' ..
                errors .. ' ' .. errorString .. ' / ' ..
                pendings .. ' ' .. pendingString .. ' : ' ..
                formattedTime .. ' ' .. s('output.seconds')
    end

    local test_end_results = {}
    handler.testEnd = function(element, parent, status, debug)
        local resultDot = successDot
        if status == 'pending' then
            resultDot = pendingDot
        elseif status == 'failure' then
            resultDot = failureDot
        elseif status == 'error' then
            resultDot = errorDot
        end

        table.insert(test_end_results, resultDot)
        return nil, true
    end

    handler.suiteStart = function(suite, count, total)
        local runString = (total > 1 and '\nRepeating all tests (run %u of %u) . . .\n\n' or '')
        io_write(string_format(runString, count, total))
        io_flush()

        return nil, true
    end

    handler.suiteEnd = function()
        io_write('\n' .. table.concat(test_end_results, ""))
        test_end_results = {}

        io_write('\n')
        io_write(statusString() .. '\n')

        for i, pending in pairs(handler.pendings) do
            io_write('\n')
            io_write(pendingDescription(pending) .. '\n')
        end

        for i, err in pairs(handler.failures) do
            io_write('\n')
            io_write(failureDescription(err) .. '\n')
        end

        for i, err in pairs(handler.errors) do
            io_write('\n')
            io_write(failureDescription(err, true) .. '\n')
        end

        return nil, true
    end

    handler.error = function(element, parent, message, debug)
        io_write(errorDot)
        io_flush()

        return nil, true
    end

    busted.subscribe({ 'test', 'end' }, handler.testEnd, { predicate = handler.cancelOnPending })
    busted.subscribe({ 'suite', 'start' }, handler.suiteStart)
    busted.subscribe({ 'suite', 'end' }, handler.suiteEnd)
    busted.subscribe({ 'error', 'file' }, handler.error)
    busted.subscribe({ 'failure', 'file' }, handler.error)
    busted.subscribe({ 'error', 'describe' }, handler.error)
    busted.subscribe({ 'failure', 'describe' }, handler.error)

    return handler
end