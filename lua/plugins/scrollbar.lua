return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            vim.cmd("colorscheme gruvbox")
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "https://www.github.com/petertriho/nvim-scrollbar",
        dependancies = { "gruvbox.nvim", "gitsigns.nvim", },
        config = function()
            local gb = require("gruvbox").palette

            local colors = {
                bg_highlight = gb.gray,
                orange       = gb.bright_orange,
                error        = gb.bright_red,
                warning      = gb.bright_yellow,
                info         = gb.bright_blue,
                hint         = gb.bright_aqua,
                purple       = gb.bright_purple,
            }

            require("scrollbar").setup({
                handle = {
                    color = colors.bg_highlight,
                },
                handlers = {
                    gitsigns = true,
                },
                marks = {
                    Search = { color = colors.orange },
                    Error = { color = colors.error },
                    Warn = { color = colors.warning },
                    Info = { color = colors.info },
                    Hint = { color = colors.hint },
                    Misc = { color = colors.purple },
                },
            })
        end
    },
}

