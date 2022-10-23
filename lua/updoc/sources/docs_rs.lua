local DocSource = require('updoc.types').DocSource

local docs_rs = DocSource:new({
    index = 'https://docs.rs',
})

return docs_rs
