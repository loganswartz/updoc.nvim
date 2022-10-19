local DocSource = require('updoc.types').DocSource

local Source = DocSource:new({
    stdlib_index = 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference',
    thirdparty_index = 'https://www.npmjs.com',
})

function Source:stdlib(object, property)
    local url = self.stdlib_index .. '/Global_Objects/' .. object
    if property ~= nil then
        url = url .. '/' .. property
    end

    return url
end

function Source:thirdparty(object, property)
    return self.thirdparty_index .. '/package/' .. object
end

return Source
