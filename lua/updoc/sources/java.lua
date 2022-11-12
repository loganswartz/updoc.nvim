local DocSource = require('updoc.types').DocSource

local java = DocSource:new({
    name = 'Java Oracle Docs',
    index = 'https://docs.oracle.com',
    search_path = '/search/?category=java&q=%s',
})

return java
