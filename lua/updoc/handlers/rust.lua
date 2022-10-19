local DocSource = require('updoc.types').DocSource

local Source = DocSource:new({
    stdlib_index = 'https://docs.rs/rustc-std-workspace-std/latest/std',
    thirdparty_index = 'https://docs.rs',
})

return Source
