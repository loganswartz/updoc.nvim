local DocSource = require('updoc.types').DocSource

local nix_packages = DocSource:new({
    name = 'Nix Packages',
    index = 'https://search.nixos.org',
    search_path = '/packages?query=%s',
})

return nix_packages
