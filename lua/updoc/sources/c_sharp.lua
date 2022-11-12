local DocSource = require('updoc.types').DocSource

local c_sharp = DocSource:new({
    name = 'C# Docs',
    index = 'https://learn.microsoft.com/en-us',
    search_path = '/search/?scope=.NET&terms=',
})

return c_sharp
