local DocSource = require('updoc.types').DocSource

local packagist = DocSource:new({
    name = 'Packagist',
    index = 'https://packagist.org',
    search_path = '/?query=%s',
})

return packagist
