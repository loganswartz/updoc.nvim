local DocSource = require('updoc.types').DocSource

local python_stdlib = DocSource:new({
    name = 'Python Standard Library',
    index = 'https://docs.python.org/3',
    lookup = function(self, target, uri)
        local namespace = target.namespace
        local object = target.object

        local url = self.index .. '/library/' .. namespace .. '.html'
        if object ~= nil then
            url = url .. '#' .. namespace .. '.' .. object
        end

        return url
    end,
    search_path = '/search.html?q=%s',
})

return python_stdlib
