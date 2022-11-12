local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local go = Environment:new({
    sources = {
        sources.go,
    },
    delimiters = { [[\.]] },
})

return go
