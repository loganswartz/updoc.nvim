local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local kotlin = Environment:new({
    sources = {
        sources.kotlin,
    },
    delimiters = { [[\.]] },
})

return kotlin
