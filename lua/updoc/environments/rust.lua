local Environment = require('updoc.types').Environment
local sources = require('updoc.sources')

local rust = Environment:new({
    sources = {
        sources.rust_stdlib,
        sources.docs_rs,
    },
    delimiters = { [[::]], [[\.]] },
})

return rust
