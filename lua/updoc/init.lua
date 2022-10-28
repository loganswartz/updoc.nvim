local Menu = require('nui.menu')
local ui = require('updoc.ui')
local utils = require('updoc.utils')
local Environment = require('updoc.types').Environment
local options = require('updoc.options')

local M = {}

function M.lookup(type)
    local env = Environment.get(type)
    if env == nil then
        vim.notify("No doc environment found for filetype '" .. env .. "'!")
        return
    end

    ---@type TextPromptCallback
    local function callback(input)
        local url = env:lookup(env:parse(input))
        if url == nil then
            vim.notify('Failed to find documentation.')
            return
        end

        if options.show_url_on_open then
            vim.notify("Opening '" .. url .. "'.")
        end
        utils.open_link(url)
    end

    local input = ui.make_text_prompt("[Find Docs]", callback)
    return input:mount()
end

function M.search(name)
    if name ~= nil then
        return M.search_source(name)
    end

    local source_map = require('updoc.sources')
    local sources = vim.tbl_keys(source_map)

    if utils.has_telescope() then
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local pick = function(opts)
            opts = opts or {}
            pickers.new(opts, {
                prompt_title = "Sources",
                finder = finders.new_table {
                    results = sources,
                    entry_maker = function(entry)
                        return {
                            value = entry,
                            display = source_map[entry].name,
                            ordinal = source_map[entry].name,
                        }
                    end
                },
                sorter = conf.generic_sorter(opts),
                attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()

                        M.search_source(selection.value)
                    end)

                    return true
                end,
            }):find()
        end

        return pick()
    else
        local lines = {}
        for _, source in pairs(sources) do
            lines[#lines+1] = Menu.item(source, {
                callback = function() M.search_source(source) end,
            })
        end

        return ui.make_menu('[What source?]', lines):mount()
    end
end

function M.search_source(name)
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

        if options.show_url_on_open then
            vim.notify("Opening '" .. url .. "'...")
        end
        utils.open_link(url)
    end

    local input = ui.make_text_prompt("[Search " .. source.name .. "]", callback)
    return input:mount()
end

M.show_hover_links = require('updoc.lsp').show_hover_links

---@param opts Options|nil
function M.setup(opts)
    options = vim.tbl_deep_extend('force', options, opts or {})
end

return M
