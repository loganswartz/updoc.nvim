local DocSource = require('updoc.types').DocSource

local luarocks = DocSource:new({
    name = 'Luarocks',
    index = 'https://luarocks.org',
    search_path = '/search?q=%s',
})

return luarocks
