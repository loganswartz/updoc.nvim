local DocSource = require('updoc.types').DocSource

local php_net = DocSource:new({
    name = 'PHP.net',
    index = 'https://www.php.net',
    search_path = '/results.php?q=%s',
})

return php_net
