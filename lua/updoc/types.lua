local utils = require('updoc.utils')

local M = {}

M.DocSource = {}
M.DocSource.__index = M.DocSource
M.DocSource.index = nil

function M.DocSource:new(obj)
    setmetatable(obj, self)

    return obj
end

function M.DocSource:lookup(target)
    error('Lookup not supported for ' .. self.name .. '.')
end

function M.DocSource:search(query)
    if self.search_path == nil then
        error('Searching not supported for ' .. self.name .. '.')
    end

    local encoded = utils.url_encode(query)
    local escaped = encoded:gsub('%%', '%%%%')

    return self.index .. self.search_path:gsub('%%s', escaped)
end

M.Environment = {}
M.Environment.__index = M.Environment
M.Environment.sources = {}
M.Environment.delimiters = {}

function M.Environment:new(obj)
    setmetatable(obj, self)

    return obj
end

function M.Environment:lookup(target)
    for _, source in pairs(self.sources) do
        local result = source:lookup(target)
        if result ~= nil then
            return result
        end
    end
end

function M.Environment:parse(value)
    local tokens = utils.collect(string.gmatch(value, '[^' .. table.concat(self.delimiters, '') .. ']+'))

    local target = {
        namespace = tokens[1],
        object = tokens[2],
    }
    return target
end

function M.Environment.get(env)
    local ft = vim.bo.filetype

    return require('updoc.environments')[env or ft]
end

return M
