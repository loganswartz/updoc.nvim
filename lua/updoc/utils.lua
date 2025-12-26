local ts = vim.treesitter
local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

-- Get the correct program for opening links on the current OS.
function M.get_opener()
    local cmds = {
        windows = "explorer.exe",
        osx = "open",
        linux = "xdg-open",
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

---@param value string
---@return string[]
function M.find_links(value)
    local pattern = "https?://[%w-_%.%?%.:/%+=&#]+"
    local collected = M.collect(string.gmatch(value, pattern))

    return M.unique(collected)
end

function M.unique(iterator)
    local hash = {} -- hash for performance
    local unique = {}

    for _, value in ipairs(iterator) do
        if not hash[value] then
            hash[value] = true -- mark as found
            unique[#unique + 1] = value
        end
    end

    return unique
end

---@param input string
---@param delimiter string
function M.split_string(input, delimiter)
    return M.collect(string.gmatch(input, "[^" .. [[\]] .. delimiter .. "]+"))
end

---@param link string
---@param source DocSource
function M.open_in_browser(link, source)
    local opener = M.get_opener()

    if vim.fn.executable(opener) ~= 0 then
        return vim.system({ opener, link }, { text = true }):wait()
    else
        vim.notify("Tried to open '" .. link .. "', but '" .. opener .. "' was not found.")
    end
end

function M.collect(...)
    local arr = {}
    for v in ... do
        arr[#arr + 1] = v
    end
    return arr
end

-- Create a table that loads a lua module when accessing an attribute.
---@param path string
function M.create_lookup(path)
    local mt = {
        __index = function(table, key)
            local ok, result = pcall(require, path .. "." .. key)
            return ok and result or nil
        end,
    }
    return setmetatable({}, mt)
end

---@return Target
function M.get_ts_context()
    local bufnr = vim.api.nvim_get_current_buf() or 0

    local function contents(node)
        return ts.query.get_node_text(node, bufnr)
    end

    local node = ts_utils.get_node_at_cursor()
    if node and node:type() == "property_identifier" then
        local namespace = node:prev_named_sibling()
        return { namespace = contents(namespace), object = contents(node) }
    else
        return { namespace = nil, object = contents(node) }
    end
end

---@return string|nil
function M.get_definition_uri()
    local result =
        vim.lsp.buf_request_sync(0, "textDocument/definition", vim.lsp.util.make_position_params(nil, "utf-16"))
    if result == nil then
        return nil
    end

    local response = result[2]
    ---@type string|nil
    local uri = response.result[1].uri

    return uri
end

function M.get_context()
    local ts_context = M.get_ts_context()
    local definition = M.get_definition_uri()

    return {
        namespace = ts_context.namespace,
        object = ts_context.object,
        uri = definition,
    }
end

---@param link string
function M.check_link_valid(link)
    local job = vim.system({ "curl", "-s", "-L", "--head", "--fail", link }):wait()

    -- 22 means a 4xx error, typically 404
    return job.code ~= 22
end

-- http://lua-users.org/wiki/StringRecipes
function M.char_to_hex(c)
    return string.format("%%%02X", string.byte(c))
end

function M.hex_to_char(x)
    return string.char(tonumber(x, 16))
end

function M.url_encode(str)
    if str then
        str = str:gsub("\n", "\r\n")
        str = str:gsub("([^%w %-%_%.%~])", M.char_to_hex)
        str = str:gsub(" ", "+")
    end
    return str
end

function M.url_decode(str)
    str = str:gsub("+", " ")
    str = str:gsub("%%(%x%x)", M.hex_to_char)
    str = str:gsub("\r\n", "\n")
    return str
end

---@param module string|string[]
---@return { [string]: string }
function M.find_files(module)
    if type(module) == "table" then
        module = table.concat(module, "/")
    end

    local rtp = vim.opt.rtp._value
    local normalized = "lua/" .. string.gsub(module, "%.", "/")

    local files = vim.fn.globpath(rtp, normalized .. "/*.lua", nil, true) or {}
    local modules = vim.fn.globpath(rtp, normalized .. "/*/init.lua", nil, true) or {}

    local function omit_init_lua(item)
        local matches = string.gmatch(item, ".*/" .. normalized .. "/init.lua")
        return #M.collect(matches) == 0
    end

    local filtered = vim.tbl_extend("force", vim.tbl_filter(omit_init_lua, files), modules)

    local function unmap_path(path)
        return vim.fn.fnamemodify(path, ":t:r")
    end

    local converted = vim.tbl_map(unmap_path, filtered)
    return converted
end

-- Autoloads all modules inside the namespace, and returns a map of module_name => require('module_name')
---@param namespace string|string[]
function M.autoload_submodule_map(namespace)
    if type(namespace) == "table" then
        namespace = table.concat(namespace, "/")
    end

    local mapping = {}
    for _, module in pairs(M.find_files(namespace)) do
        mapping[module] = require(namespace .. "." .. module)
    end

    return mapping
end

return M
