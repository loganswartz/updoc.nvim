local ui = require('updoc.ui')
local utils = require('updoc.utils')
local Environment = require('updoc.types').Environment

local M = {}

function M.lookup(type)
    local env = Environment.get(type)
    if env == nil then
        vim.notify("No doc environment found for filetype '" .. vim.bo.filetype .. "'!")
        return
    end

    local function callback(input)
        local url = env:lookup(env:parse(input))
        if url == nil then
            vim.notify('Failed to find documentation.')
        else
            vim.notify("Opening '" .. url .. "'...")
            utils.open_link(url)
        end
    end

    local input = ui.make_lookup_prompt("[Find Docs]", callback)
    return input:mount()
end

function M.setup()
end

return M
