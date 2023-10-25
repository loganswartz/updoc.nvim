local DocSource = require('updoc.types').DocSource

local duck_duck_go = DocSource:new({
    name = 'DuckDuckGo',
    index = 'https://www.duckduckgo.com',
    search_path = '/?q=%s',
})

return duck_duck_go
