local DocSource = require('updoc.types').DocSource

local nixos_wiki = DocSource:new({
    name = 'NixOS Wiki',
    index = 'https://wiki.nixos.org/w',
    search_path = '/index.php?search=%s',
})

return nixos_wiki
