local DocSource = require('updoc.types').DocSource

local Source = DocSource:new({
    stdlib_index = 'https://docs.python.org/3/library',
    thirdparty_index = 'https://pypi.org',
})

function Source:stdlib(object, property)
    local url = self.stdlib_index .. '/' .. object .. '.html'
    if property ~= nil then
        url = url .. '#' .. object .. '.' .. property
    end

    return url
end

function Source:thirdparty(object, property)
    return self.thirdparty_index .. '/project/' .. object
end

return Source
