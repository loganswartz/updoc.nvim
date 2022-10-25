local DocSource = require('updoc.types').DocSource

local npm = DocSource:new({
    name = 'NPM',
    index = 'https://www.npmjs.com',
    lookup = function(self, target, uri)
        return self.index .. '/package/' .. (target.namespace or target.object)
    end,
    search_path = '/search?q=%s',
})

return npm
