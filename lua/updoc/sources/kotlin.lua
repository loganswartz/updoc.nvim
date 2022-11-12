local DocSource = require('updoc.types').DocSource

local kotlin = DocSource:new({
    name = 'Kotlin',
    index = 'https://kotlinlang.org',
    search_path = '/docs/home.html?s=full&q=%s',
})

return kotlin
