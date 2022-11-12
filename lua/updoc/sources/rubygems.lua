local DocSource = require('updoc.types').DocSource

local rubygems = DocSource:new({
    name = 'RubyGems',
    index = 'https://rubygems.org',
    search_path = '/search?query=%s',
})

return rubygems
