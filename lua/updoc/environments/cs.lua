local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local cs = Environment:new({
    sources = {
        sources.c_sharp,
    },
    delimiters = { [[\.]] },
})

return cs
