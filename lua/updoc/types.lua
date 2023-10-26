local utils = require('updoc.utils')

local M = {}

---@class DocSource
---@field name string The human-readable name for the source
---@field index string The URI representing the index of the source
---@field search_path string|nil A format string for building a search URI
---@field new fun(self: DocSource, obj: table): DocSource Create a new instance of the class
---@field lookup fun(self: DocSource, target: table): string|nil Lookup a URI for the currently targeted object
---@field search fun(self: DocSource, query: string): string Search the source for a given query string

---@type DocSource
M.DocSource = {
    name = nil,
    index = nil,
    search_path = nil,

    new = function(self, obj)
        setmetatable(obj, self)

        return obj
    end,

    lookup = function(self, target)
        error('Lookup not supported for ' .. self.name .. '.')
    end,

    search = function(self, query)
        if self.search_path == nil then
            error('Searching not supported for ' .. self.name .. '.')
        end

        local encoded = utils.url_encode(query)

        return self.index .. string.format(self.search_path, encoded)
    end,
}
M.DocSource.__index = M.DocSource

---@alias Target { namespace: string|nil, object: string|nil }

---@class Environment
---@field sources DocSource[] An array of sources that are related to the environment / filetype.
---@field delimiters string[] An array of delimiters for the language that can separate namespaces, attributes, etc.
---@field new fun(self: Environment, obj: table): Environment Create a new instance of the class.
---@field lookup fun(self: Environment, target: Target): string|nil Lookup a URI for the currently targeted object.
---@field parse fun(self: Environment, value: string): Target A format string for building a search URI.
---@field get fun(env: string|nil): Environment Fetch an environment by name.

---@type Environment
M.Environment = {
    sources = {},
    delimiters = {},

    new = function(self, obj)
        setmetatable(obj, self)

        return obj
    end,

    lookup = function(self, target)
        for _, source in pairs(self.sources) do
            local result = source:lookup(target)
            if result ~= nil then
                return result
            end
        end
    end,

    parse = function(self, value)
        local tokens = utils.collect(string.gmatch(value, '[^' .. table.concat(self.delimiters, '') .. ']+'))

        ---@type Target
        local target = {
            namespace = tokens[1],
            object = tokens[2],
        }

        return target
    end,

    get = function(env)
        local ft = vim.bo.filetype

        return require('updoc.environments')[env or ft]
    end,
}
M.Environment.__index = M.Environment

return M
