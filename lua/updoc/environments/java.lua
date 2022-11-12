local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local java = Environment:new({
    sources = {
        sources.java,
    },
    delimiters = { [[\.]] },
})

return java
