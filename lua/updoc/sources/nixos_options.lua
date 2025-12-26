local DocSource = require('updoc.types').DocSource

local nixos_options = DocSource:new({
    name = 'NixOS Options',
    index = 'https://search.nixos.org',
    search_path = '/options?query=%s',
})

return nixos_options
