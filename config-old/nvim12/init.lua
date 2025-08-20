-- Ensure correct version is used (0.12+ due to vim.pack)
if vim.fn.has("nvim-0.11") == 0 then
  vim.notify("Neovim 0.12+ required", vim.log.levels.ERROR)
  return
end

-- Set <space> as leader key
-- Must happen before plugins are loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- settings
vim.opt.number = true -- make line numbers default
vim.opt.relativenumber = true -- make line numbers relative
-- vim.cmd([[set mouse=]]) -- disable mouse completely 
vim.opt.mouse = 'a' -- mouse enabled for all modes
vim.opt.tabstop = 2 -- TAB is now 2 spaces instead of tab
vim.opt.winborder = 'rounded' -- rounded borders (e.g. split screens)
vim.opt.hlsearch = true -- Enable highlightning of searchesvim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Enable smartcase, e.g. case-insensitive unless \C or capital letters in search term
vim.opt.cursorcolumn = false -- Disable vertical cursor highlight line
vim.opt.shiftwidth = 2 -- Auto-indent width is 2 spaces
vim.opt.smartindent = true -- Automatically indent lines based on context
vim.opt.termguicolors = true -- Neovim uses 24bit color instead of just 256 colors
vim.opt.undofile = true -- Saves undo history to a file so it persists between sessions
vim.opt.signcolumn = 'yes' -- Display left margin (diagnostics, breakpoints, signs) always
vim.opt.showmode = false -- Don't show mode, its already on the status line (lualine)
vim.opt.breakindent = true -- Enable break indent
vim.opt.cursorline = true -- Show cursor line
vim.opt.scrolloff = 10 -- Keep at least 10 lines above and below cursor
vim.opt.confirm = true -- Ask to save changes if just quitting and not saving
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time


-- sync clipboard between OS and Neovim
-- schedule setting after 'UiEnter' because it can increase startup-time (TEST!)
vim.schedule(function()
	vim.opt.clipboard = {'unnamed', 'unnamedplus'}
end)



vim.pack.add {
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },

-- colorschemes
--  { src = "https://github.com/AlexvZyl/nordic.nvim" },
---	{ src = "https://github.com/vague2k/vague.nvim" },
--  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
--  { src = "https://github.com/navarasu/onedark.nvim" },
--  { src = "https://github.com/rebelot/kanagawa.nvim" },





}



require('lualine').setup()

-- Fix annoying errors when editing vim config (define vim as global variable)
require('lspconfig').lua_ls.setup({settings = { Lua = { diagnostics = { globals = { "vim" },},},},})

vim.lsp.enable { 'lua_ls', 'pyright', 'r-languageserver', 'tinymist' }


--colors
require("tokyonight").setup({ style = "night", })
-- require("catppuccin").setup({ flavour = "mocha", })
-- require("onedark").setup({ style = "dark", })
-- require("kanagawa").setup({ theme = "wave", })




vim.cmd[[colorscheme tokyonight]]






-- { -- language support
--    "neovim/nvim-lspconfig",
--    config = function()
--        vim.lsp.config("*", {})
--        vim.lsp.enable({
--            "gopls",
--            "jdtls",
--            "kotlin_language_server",
--            "lua_ls",
--            "pylsp",
---            "rust_analyzer",
 --           "ts_ls",
  --      })
--    end,
--}

