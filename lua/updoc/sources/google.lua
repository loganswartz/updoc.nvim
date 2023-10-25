local DocSource = require('updoc.types').DocSource

local google = DocSource:new({
    name = 'Google',
    index = 'https://www.google.com',
    search_path = '/search?q=%s',
})

return google
