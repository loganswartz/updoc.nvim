---@class HandlerTable
---@field lookup fun(url: string, env: Environment, target: Target)|nil
---@field search fun(url: string, source: DocSource)|nil
---@field hover HoverHandler|nil

---@class Options
---@field show_url_on_open boolean|nil Should the URL be echoed to the user as we open it?
---@field handlers HandlerTable Functions to handle selected links.

---@type Options
local M = {
    show_url_on_open = false,
    handlers = {
        lookup = require('updoc.utils').open_in_browser,
        search = require('updoc.utils').open_in_browser,
        hover = require('updoc.utils').open_in_browser,
    },
}

return M
