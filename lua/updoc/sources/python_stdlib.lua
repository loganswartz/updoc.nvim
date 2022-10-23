local DocSource = require('updoc.types').DocSource

local python_stdlib = DocSource:new({
    index = 'https://docs.python.org/3/library',
    lookup = function(self, target, uri)
        print(vim.inspect(target))
        local namespace = target.namespace
        local object = target.object

        local url = self.index .. '/' .. namespace .. '.html'
        if object ~= nil then
            url = url .. '#' .. namespace .. '.' .. object
        end

        return url
    end,
})

return python_stdlib
