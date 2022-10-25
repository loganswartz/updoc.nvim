local DocSource = require('updoc.types').DocSource

local mdn = DocSource:new({
    name = 'MDN',
    index = 'https://developer.mozilla.org',
    lookup = function(self, target, uri)
        local namespace = target.namespace
        local object = target.object
        local subpath = '/docs/Web/JavaScript/Reference/Global_Objects/'

        local url = self.index .. subpath .. namespace
        if object ~= nil then
            url = url .. '/' .. object
        end

        return url
    end,
    search_path = '/search?q=%s',
})


return mdn
