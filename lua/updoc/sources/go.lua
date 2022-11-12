local DocSource = require('updoc.types').DocSource

local go = DocSource:new({
    name = 'Go Packages',
    index = 'https://pkg.go.dev',
    search_path = '/search?q=%s',
})

return go
