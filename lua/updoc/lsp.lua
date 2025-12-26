local options = require("updoc.options")
local utils = require("updoc.utils")

local M = {}
---@alias HoverHandler fun(value: string, error: lsp.ResponseError|nil, result: lsp.Hover, ctx: lsp.HandlerContext, config: table|nil)

-- Parse all the links from a body of text, and show a selection menu for opening them.
---@type HoverHandler
function M.handle_links_from_hover(value, error, result, ctx, config)
    local links = utils.find_links(value)

    if #links == 0 then
        vim.notify("No links found!")
    elseif #links == 1 then
        options.handlers.hover(links[1], error, result, ctx, config)
    else
        return vim.schedule(function()
            vim.ui.select(links, { prompt = "Links Found" }, function(url)
                -- do nothing if input was cancelled
                if url == nil then
                    return
                end

                options.handlers.hover(url, error, result, ctx, config)
            end)
        end)
    end
end

-- Get the hover text for the current cursor position, and open a menu allowing you to open any link found in the hover text.
function M.show_hover_links()
    --@see :h lsp-response
    ---@param result lsp.Hover
    ---@type function|lsp-handler
    local function handle(error, result, ctx, config)
        local body = result.contents[2]
        local header = result.contents.value
        local value = body and body.value or header

        if value == nil then
            vim.notify("No hover text was found!")
            return
        end

        return M.handle_links_from_hover(value, error, result, ctx, config)
    end

    vim.lsp.buf_request(0, "textDocument/hover", vim.lsp.util.make_position_params(nil, "utf-16"), handle)
end

return M
