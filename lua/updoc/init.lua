local ui = require('updoc.ui')
local utils = require('updoc.utils')
local Environment = require('updoc.types').Environment

local M = {}

local show_url_on_open = false

function M.lookup(type)
    local env = Environment.get(type)
    if env == nil then
        vim.notify("No doc environment found for filetype '" .. env .. "'!")
        return
    end

    local function callback(input)
        local url = env:lookup(env:parse(input))
        if url == nil then
            vim.notify('Failed to find documentation.')
            return
        end

        if show_url_on_open then
            vim.notify("Opening '" .. url .. "'...")
        end
        utils.open_link(url)
    end

    local input = ui.make_lookup_prompt("[Find Docs]", callback)
    return input:mount()
end

function M.search(name)
    local source = require('updoc.sources')[name]
    if source == nil then
        vim.notify("Source '" .. name .. "' could not be found!")
        return
    end

    local function callback(query)
        local url = source:search(query)
        if url == nil then
            vim.notify('Failed to find documentation.')
            return
        end

        if show_url_on_open then
            vim.notify("Opening '" .. url .. "'...")
        end
        utils.open_link(url)
    end

    local input = ui.make_lookup_prompt("[Search " .. source.name .. "]", callback)
    return input:mount()
end

M.show_hover_links = require('updoc.lsp').show_hover_links

function M.setup(opts)
    if opts == nil then
        return
    end

    if opts.show_url_on_open ~= nil then
        show_url_on_open = opts.show_url_on_open
    end
end

return M
