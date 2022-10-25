local DocSource = require('updoc.types').DocSource

local php_net = DocSource:new({
    name = 'PHP.net',
    index = 'https://www.php.net',
    lookup = function(self, target, uri)
        error('Lookup not supported for ' .. self.name .. '.')
    end,
    search_path = '/results.php?q=%s',
})

return php_net
