-- ============================================================================
-- KEYBINDS
-- ============================================================================

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Normal mode: whole file
vim.keymap.set('n', '<leader>rr', function()
    vim.cmd('so')
    vim.cmd('set tabstop=2 shiftwidth=2 noexpandtab')
    vim.cmd('retab!')
    vim.cmd('set tabstop=4 shiftwidth=4 expandtab')
    vim.cmd('retab!')
end, { desc = 'Reindent whole file: 2-wide then 4-wide tabs' })

-- Visual mode: only selected lines
vim.keymap.set('x', '<leader>rr', function()
    -- exit visual mode first so '< and '> marks are set
    vim.cmd('so')
    vim.cmd('normal! \27') -- <Esc>
    vim.cmd('set tabstop=2 shiftwidth=2 noexpandtab')
    vim.cmd("'<,'>retab!")
    vim.cmd('set tabstop=4 shiftwidth=4')
    vim.cmd("'<,'>retab!")
end, { desc = 'Reindent selection: 2-wide then 4-wide tabs' })

-- ============================================================================
-- COLOR SCHEME AND CURSOR
-- ============================================================================

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox")
vim.opt.guicursor =
    "n-c:block," ..
    "v:hor20," ..
    "i-ci-ve:ver25," ..
    "r-cr:hor20," ..
    "o:hor50," ..
    "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor," ..
    "sm:block-blinkwait175-blinkoff150-blinkon175"

local function set_transparent() -- set UI component to transparent
    local groups = {
        "Normal",
        "NormalNC",
        "EndOfBuffer",
        "NormalFloat",
        "FloatBorder",
        "SignColumn",
        "StatusLine",
        "StatusLineNC",
        "TabLine",
        "TabLineFill",
        "TabLineSel",
        "ColorColumn",
    }
    for _, g in ipairs(groups) do
        vim.api.nvim_set_hl(0, g, { bg = "none" })
    end
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

set_transparent()

-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

vim.opt.tabstop = 4 -- tabwidth
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
--vim.opt.smartindent = true -- smart auto-indent
--vim.opt.autoindent = true -- copy indent from current line
vim.opt.list = true
vim.opt.listchars = { tab = '╎ ', trail = '·', nbsp = '␣', lead = '·'}

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 2 -- obsidian requirement
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

local undodir = vim.fn.expand("~/.vim/undodir")
if
    vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
    vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 50 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

-- ============================================================================
-- DIAGNOSTICS
-- ============================================================================

--[[vim.diagnostic.config({
    virtual_text = true,                -- inline text after the offending line
    signs = true,                                -- gutter icons (E/W markers)
    underline = true,                           -- squiggly underline
    update_in_insert = false,           -- don't re-check while you're still typing
    severity_sort = true,                   -- show errors before warnings when overlapping
})

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})]]


-- Diagnostics
vim.diagnostic.config({
    signs = {
        priority = 9999,
    },
    underline = true,
    virtual_text = {
        current_line = false,
        severity = {
            min = vim.diagnostic.severity.INFO,
            max = vim.diagnostic.severity.WARN,
        },
    },
    virtual_lines = {
        current_line = false,
        severity = {
            min = vim.diagnostic.severity.ERROR,
        },
    },
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function(client, bufnr)
    -- Optional: if you're using mini.completion
    vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

    -- Make completion less noisy
    if client.name == "lua_ls" then
        client.server_capabilities.completionProvider.triggerCharacters = {
            ".",
            ":",
        }
    end
end

vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    on_attach = on_attach,

    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },

            diagnostics = {
                globals = { "vim" },
                disable = { "need-check-nil" },
            },

            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
                ignoreSubmodules = true,
            },

            telemetry = {
                enable = false,
            },
        },
 {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    -- Only one of these is needed.
    "sindrets/diffview.nvim",        -- optional
    "esmuellert/codediff.nvim",      -- optional

    -- For a custom log pager
    "m00qek/baleia.nvim",            -- optional

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
    "nvim-mini/mini.pick",           -- optional
    "folke/snacks.nvim",             -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
  }
}   },
})

vim.lsp.enable("lua_ls")
