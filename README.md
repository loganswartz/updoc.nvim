# updoc.nvim

Open documentation for anything you're working on.

## Installation

With packer.nvim:

```lua
use {
    'loganswartz/updoc.nvim',
    requires = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'MunifTanjim/nui.nvim',
    },
    config = function()
        require('updoc').setup()
    end,
}
```
## Usage

```lua
-- get search results for a source
require('updoc').search()

-- lookup a specific namespace or object for the current environment
require('updoc').lookup()
```
