local DocSource = require('updoc.types').DocSource

local julia = DocSource:new({
    name = 'Julia',
    index = 'https://docs.julialang.org',
    search_path = '/en/v1/search/?q=%s',
})

return julia
