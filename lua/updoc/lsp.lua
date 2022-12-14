local utils = require('updoc.utils')

local M = {}

-- Parse all the links from a body of text, and show a selection menu for opening them.
---@param value string
function M.handle_links_from_hover(value)
    local links = utils.find_links(value);

    if #links == 0 then
        vim.notify("No links found!")
    elseif #links == 1 then
        utils.open_link(links[1])
    else
        return vim.schedule(function()
            vim.ui.select(links, { prompt = "Links Found" }, function(url)
                -- do nothing if input was cancelled
                if url == nil then return end

                utils.open_link(url)
            end)
        end)
    end
end

-- Get the hover text for the current cursor position, and open a menu allowing you to open any link found in the hover text.
function M.show_hover_links()
    --@see :h lsp-response
    local function handle(error, result, ctx, config)
        local body = result.contents[2]
        local header = result.contents.value
        local value = body or header

        if value == nil then
            vim.notify("No hover text was found!")
        end

        return M.handle_links_from_hover(value)
    end

    vim.lsp.buf_request(0, 'textDocument/hover', vim.lsp.util.make_position_params(), handle)
end

return M
