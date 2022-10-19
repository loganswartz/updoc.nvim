local ts = vim.treesitter
local ts_utils = require('nvim-treesitter.ts_utils')

local M = {}

function M.get_opener()
    local cmds = {
        windows = 'explorer.exe',
        osx = 'open',
        linux = 'xdg-open'
    }

    local opener = nil
    if jit then
        opener = cmds[string.lower(jit.os)]
    end

    if opener == nil then
        error("Couldn't determine platform.")
    end

    return opener
end

function M.find_links(value)
    local pattern = "https?://[%w-_%.%?%.:/%+=&#]+"
    return M.collect(string.gmatch(value, pattern))
end

function M.open_link(link)
    local Job = require('plenary.job')

    return Job:new({ command = M.get_opener(), args = { link } }):start()
end

function M.collect(...)
    local arr = {}
    for v in ... do
        arr[#arr + 1] = v
    end
    return arr
end

-- Create a table that loads a lua module when accessing an attribute.
function M.create_lookup(path)
    local mt = {
        __index = function(table, key)
            local ok, result = pcall(require, path .. '.' .. key)
            return ok and result or nil
        end
    }
    return setmetatable({}, mt)
end

function M.get_ts_context()
    local bufnr = vim.api.nvim_get_current_buf() or 0

    local function contents(node)
        return ts.query.get_node_text(node, bufnr)
    end

    local node = ts_utils.get_node_at_cursor()
    if node:type() == 'property_identifier' then
        local object = node:prev_named_sibling()
        return { contents(object), contents(node) }
    else
        return { contents(node), nil }
    end
end

return M
