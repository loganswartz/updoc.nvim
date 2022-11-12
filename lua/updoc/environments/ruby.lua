local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local ruby = Environment:new({
    sources = {
        sources.ruby_stdlib,
        sources.rubygems,
    },
    delimiters = { [[\.]] },
})

return ruby
