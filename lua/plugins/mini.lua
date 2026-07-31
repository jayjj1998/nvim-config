return {
    {
        'echasnovski/mini.nvim',
        enabled = true,
        config = function()
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = true }

            local tabline = require 'mini.tabline'
            tabline.setup {
                show_icons = true,
                format = function(buf_id, label)
                    local formatted = MiniTabline.default_format(buf_id, label)
                    local modified = vim.bo[buf_id].modified and ' *' or ''
                    return '│' .. modified .. formatted .. '│'
                end,
            }

            local pairs = require 'mini.pairs'
            pairs.setup { version = '*' }

            -- local tab = require 'mini.cmp'
            -- tab.setup()
        end
    }
}
