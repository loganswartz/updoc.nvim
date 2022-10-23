local DocSource = require('updoc.types').DocSource

local npm = DocSource:new({
    index = 'https://www.npmjs.com',
    lookup = function(self, target, uri)
        return self.index .. '/package/' .. (target.namespace or target.object)
    end
})

return npm
