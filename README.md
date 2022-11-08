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

If you want prettier UI elements, set up a custom `vim.ui.{input,select}` (or
use something like `dressing.nvim`). All the selection / input prompts use those
functions, so it should get picked up automatically.

## Usage

```lua
-- Open one of the links found in the LSP hover text
require('updoc').show_hover_links()

-- Prompt to choose a source, and then get search results for that source
require('updoc').search()

-- Get search results for a specific source (see helpers section below)
require('updoc').search('python_stdlib')
-- As a convenience, an additional `search_fn` is provided to allow easy
-- creation of a closure for searching a specific source. For example, this is
-- handy when registering keymaps:
--
--   vim.keymap.set('n', '<C-p>', require('updoc').search_fn('python_stdlib'))
--
-- This is equivalent to:
--
--   vim.keymap.set('n', '<C-p>', function() require('updoc').search('python_stdlib') end)

-- Lookup a specific namespace or object for the current environment
require('updoc').lookup()
```

There's also some convenience functions to give you some useful information for
set up your configuration:

```lua
-- Print the internal names of all available sources (these are all the valid
-- options to pass to `search()`)
require('updoc').print_available_sources()
```
