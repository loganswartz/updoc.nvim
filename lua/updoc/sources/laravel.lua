local DocSource = require('updoc.types').DocSource

local laravel = DocSource:new({
    name = 'Laravel',
    index = 'https://api.laravel.com/docs/master',
    search_path = '/search.html?search=%s',
})

return laravel
