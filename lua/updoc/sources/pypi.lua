local DocSource = require('updoc.types').DocSource

local pypi = DocSource:new({
    name = 'PyPI',
    index = 'https://pypi.org',
    lookup = function(self, target, uri)
        return self.index .. '/project/' .. (target.namespace or target.object)
    end,
    search_path = '/search/?q=%s',
})

return pypi
