local M = {}

local function get_doc_link(lookup_type, object, opts)
    local ft = opts.filetype or vim.bo.filetype
    local handler = require('updoc.handlers')[ft][lookup_type]

    if handler == nil then
        vim.notify("No handler found for filetype '" .. ft .. "'.")
        return nil
    end

    return handler(object, opts.property)
end

function M.get_stdlib_link(object, property)
    return get_doc_link('stdlib', object, { property = property })
end

function M.get_thirdparty_link(name)
    return get_doc_link('thirdparty', name)
end

function M.lookup_cursor()
    local object, property = require('updoc.lsp').get_ts_context()
    local url = M.get_stdlib_link(object, property)

    require('updoc.utils').open_link(url)
end

return M
