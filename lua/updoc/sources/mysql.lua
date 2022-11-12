local DocSource = require('updoc.types').DocSource

local mysql = DocSource:new({
    name = 'MySQL Reference',
    index = 'https://dev.mysql.com',
    search_path = '/doc/search?q=%s',
})

return mysql
