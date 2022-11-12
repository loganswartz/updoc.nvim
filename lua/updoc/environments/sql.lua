local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local sql = Environment:new({
    sources = {
        sources.mysql,
    },
    delimiters = { [[\.]] },
})

return sql
