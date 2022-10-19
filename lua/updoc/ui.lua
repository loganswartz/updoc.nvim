local utils = require('updoc.utils')

local M = {}

function M.mount_link_menu(links)
        local lines = {}
        local Menu = require('nui.menu')

        for _, link in pairs(links) do
            lines[#lines + 1] = Menu.item(link, {
                callback = function() utils.open_link(link) end,
            })
        end

        local popup_options = {
            position = "50%",
            border = {
                style = "rounded",
                text = {
                    top = "[Links Found]",
                    top_align = "center",
                },
            },
            win_options = {
                winhighlight = "Normal:Normal",
            }
        }

        return Menu(popup_options, {
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
        }):mount()
end

return M
