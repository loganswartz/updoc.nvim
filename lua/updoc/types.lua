local M = {}

M.DocSource = {}
M.DocSource.__index = M.DocSource
M.DocSource.stdlib_index = nil
M.DocSource.thirdparty_index = nil

function M.DocSource:new(obj)
    setmetatable(obj, self)

    return obj
end

function M.DocSource:stdlib(object, property)
    return self.stdlib_index .. '/' .. object .. (property and '#' .. property or '')
end

function M.DocSource:thirdparty(object, property)
    return self.thirdparty_index .. '/' .. object .. (property and '#' .. property or '')
end

return M
