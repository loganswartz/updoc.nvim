local DocSource = require('updoc.types').DocSource

local docs_rs = DocSource:new({
    name = 'docs.rs',
    index = 'https://docs.rs',
    lookup = function(self, target, uri)
        return self.index .. '/' .. target.namespace .. (target.object and '#' .. target.object or '')
    end,
    search_path = '/releases/search?query=%s',
})

return docs_rs
