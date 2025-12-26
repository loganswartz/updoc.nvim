# updoc.nvim

Open documentation for anything you're working on.

## Installation

Here's a simple example setup with lazy.nvim:

```lua
use {
    'loganswartz/updoc.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    keys = {
        { '<C-k>', function() require('updoc').show_hover_links() end },
        { '<leader>ds', function() require('updoc').search() end },
    },
    config = function()
        require('updoc').setup()
    end,
    -- or just `config = true`
}
```

### Configuration

The following are the default options:

```lua
{
    show_url_on_open = false,  -- when opening a URL, show it in a notification as well
    handlers = {  -- these all have slightly different signatures, check options.lua for types
        lookup = require('updoc.utils').open_in_browser,
        search = require('updoc.utils').open_in_browser,
        hover = require('updoc.utils').open_in_browser,
    },
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

-- Lookup a specific namespace or object for the current environment.
require('updoc').lookup()
-- `lookup` is a bit finnicky at the moment, and typically requires some extra
-- information to work at all:
--
--   1. a predictable URL scheme for the source
--   2. some pre-existing knowledge of the layout of the doc source
--
-- I have some ideas for improving this in the future, but currently there's
-- only a few sources that are actually useful at all in this mode (namely:
-- 'python_stdlib', 'rust_stdlib', 'docs_rs', and one or two others)
```

There's also some convenience functions to give you some useful information for
set up your configuration:

```lua
-- Print the internal names of all available sources (these are all the valid
-- options to pass to `search()`)
require('updoc').print_available_sources()
```
