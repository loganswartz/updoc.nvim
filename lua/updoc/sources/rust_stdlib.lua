local DocSource = require('updoc.types').DocSource

local rust_stdlib = DocSource:new({
    name = 'Rust Standard Library',
    index = 'https://docs.rs/rustc-std-workspace-std/latest/std',
    lookup = function(self, target, uri)
        return self.index .. '/' .. target.namespace .. (target.object and '#' .. target.object or '')
    end,
    search_path = '/?search=%s',
})

return rust_stdlib
