local Menu = require('nui.menu')
local Input = require('nui.input')
local utils = require('updoc.utils')

local M = {}

local function get_border_opts(title)
    return {
        style = "rounded",
        text = {
            top = title,
            top_align = "center",
        },
    }
end

local function auto_unmount(component)
    component:on('BufLeave', function()
        component:unmount()
    end)

    return component
end

function M.make_link_menu(links)
    local lines = {}

    for _, link in pairs(links) do
        lines[#lines + 1] = Menu.item(link, {
            callback = function() utils.open_link(link) end,
        })
    end

    local popup_options = {
        position = "50%",
        border = get_border_opts("[Links Found]"),
        win_options = {
            winhighlight = "Normal:Normal",
        }
    }

    local menu = Menu(popup_options, {
        lines = lines,
        max_width = 60,
        keymap = {
            focus_next = { "j", "<Down>", "<Tab>" },
            focus_prev = { "k", "<Up>", "<S-Tab>" },
            close = { "<Esc>", "<C-c>" },
            submit = { "<CR>", "<Space>" },
        },
        on_submit = function(item)
            item:callback()
        end,
    })

    return auto_unmount(menu)
end

function M.make_lookup_prompt(title, on_submit)
    local input = Input({
        position = "50%",
        size = {
            width = 25,
        },
        border = get_border_opts(title),
    }, {
        prompt = "> ",
        on_submit = on_submit,
    })

    return auto_unmount(input)
end

return M
