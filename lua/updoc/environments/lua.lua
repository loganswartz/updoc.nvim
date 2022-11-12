local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local lua = Environment:new({
    sources = {
        sources.luarocks,
    },
    delimiters = { [[\.]] },
})

return lua
