local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local python = Environment:new({
    sources = {
        sources.python_stdlib,
        sources.pypi,
    },
    delimiters = { [[\.]] },
})

return python
