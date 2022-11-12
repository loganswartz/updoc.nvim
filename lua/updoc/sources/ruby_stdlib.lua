local DocSource = require('updoc.types').DocSource

local ruby_stdlib = DocSource:new({
    name = 'Ruby Standard Library',
    index = 'https://ruby-doc.com',
    lookup = function(self, target, uri)
        return self.index .. '/stdlib/libdoc/' .. (target.namespace or target.object) .. '/rdoc/index.html'
    end,
    search_path = '/search.html?q=%s',
})

return ruby_stdlib
