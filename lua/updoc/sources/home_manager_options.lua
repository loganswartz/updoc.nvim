local DocSource = require('updoc.types').DocSource

local home_manager_options = DocSource:new({
    name = 'Home Manager Options',
    index = 'https://home-manager-options.extranix.com',
    search_path = '/?query=%s',
})

return home_manager_options
