local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local javascript = Environment:new({
    sources = {
        sources.mdn,
        sources.npm,
    },
    delimiters = { [[\.]] },
})

return javascript
