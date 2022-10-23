local DocSource = require('updoc.types').DocSource

local mdn = DocSource:new({
    index = 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference',
    lookup = function(self, target, uri)
        local namespace = target.namespace
        local object = target.object

        local url = self.index .. '/Global_Objects/' .. namespace
        if object ~= nil then
            url = url .. '/' .. object
        end

        return url
    end,
})


return mdn
