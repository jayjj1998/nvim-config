return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false, -- this rewrite generally expects eager loading
        config = function()
            require("nvim-treesitter").install({
                "lua",
                "vim",
                "vimdoc",
                "bash",
                "python",
                "javascript",
                "typescript",
                "html",
                "css",
                "json",
                "markdown",
                "yaml",
            })

            -- Enable highlighting and indentation per-buffer
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "lua", "vim", "vimdoc", "bash", "python", "javascript", "typescript", "html", "css", "json", "markdown", "yaml" },
                callback = function()
                    vim.treesitter.start()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
