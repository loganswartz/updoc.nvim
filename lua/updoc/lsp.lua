local utils = require('updoc.utils')

local M = {}

function M.handle_lsp_request(value)
    if value == nil then
        vim.notify("Unable to parse docs!")
    end

    local links = utils.find_links(value);

    if #links == 0 then
        vim.notify("No links found!")
        return
    elseif #links == 1 then
        utils.open_link(links[1])
    else
        require('updoc.ui').mount_link_menu(links)
    end
end

function M.make_lsp_request()
    --@see :h lsp-response
    local function handle(error, result, ctx, config)
        local body = result.contents[2]
        local header = result.contents.value

        return M.handle_lsp_request(body or header or '')
    end

    vim.lsp.buf_request(0, 'textDocument/hover', vim.lsp.util.make_position_params(), handle)
end

return M
