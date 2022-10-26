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

### Configuration

The following are the default options:

```lua
{
    show_url_on_open = false,  -- when opening a URL, show it in a notification as well
}
```

No options are required, pass any overrides to `setup()`.

## Usage

```lua
-- get search results for a source
require('updoc').search()

-- lookup a specific namespace or object for the current environment
require('updoc').lookup()

-- open one of the links found in the LSP hover text
require('updoc').show_hover_links()
```
