local DocSource = require('updoc.types').DocSource

local rust_stdlib = DocSource:new({
    index = 'https://docs.rs/rustc-std-workspace-std/latest/std',
})

return rust_stdlib
