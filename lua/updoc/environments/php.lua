local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local php = Environment:new({
    sources = {
        sources.php_net,
        sources.packigist,
    },
    delimiters = { [[\.]], [[->]], [[::]] },
})

return php
