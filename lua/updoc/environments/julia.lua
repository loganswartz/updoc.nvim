local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local julia = Environment:new({
    sources = {
        sources.julia,
    },
    delimiters = { [[\.]] },
})

return julia
