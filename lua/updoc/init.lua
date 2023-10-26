local utils = require('updoc.utils')
local Environment = require('updoc.types').Environment
local options = require('updoc.options')

local M = {}

---@param type string|nil
function M.lookup(type)
    local env = Environment.get(type)
    if env == nil then
        vim.notify("No doc environment found for filetype '" .. env .. "'!")
        return
    end

    local function callback(input)
        -- do nothing if input was cancelled
        if input == nil then return end

        local target = env:parse(input)
        local url = env:lookup(target)

        if url == nil then
            vim.notify('Failed to find documentation.')
            return
        end

        if options.show_url_on_open then
            vim.notify("Opening '" .. url .. "'.")
        end
        options.handlers.lookup(url, env, target)
    end

    return vim.schedule(function()
        vim.ui.input({ prompt = "[Jump to Docs]" }, callback)
    end)
end

---@param name string|nil
function M.search(name)
    if name ~= nil then
        return M.search_source(name)
    end

    local source_map = require('updoc.sources')
    local sources = vim.tbl_keys(source_map)

    return vim.schedule(function()
        vim.ui.select(sources, {
                prompt = 'Sources',
                format_item = function(item) return source_map[item].name end,
            },
            function(input)
                -- do nothing if input was cancelled
                if input == nil then return end

                M.search_source(input)
            end
        )
    end)
end

---@param name string|nil
function M.search_fn(name)
    return function()
        return M.search(name)
    end
end

---@param name string|nil
function M.search_source(name)
    local source = require('updoc.sources')[name]
    if source == nil then
        vim.notify("Source '" .. name .. "' could not be found!")
        return
    end

    local function callback(input)
        -- do nothing if input was cancelled
        if input == nil then return end

        local url = source:search(input)
        if url == nil then
            vim.notify('Failed to find documentation.')
            return
        end

        if options.show_url_on_open then
            vim.notify("Opening '" .. url .. "'...")
        end
        options.handlers.search(url, source)
    end

    return vim.schedule(function()
        vim.ui.input({ prompt = "[Search " .. source.name .. "]" }, callback)
    end)
end

M.show_hover_links = require('updoc.lsp').show_hover_links

M.print_available_sources = function()
    print(vim.inspect(vim.tbl_keys(require('updoc.sources'))))
end

---@param opts Options|nil
function M.setup(opts)
    options = vim.tbl_deep_extend('force', options, opts or {})
end

return M
