-- Ensure minimum v0.12 (vim.pack)
if vim.fn.has("nvim-0.11") == 0 then
  vim.notify("Neovim 0.12+ required", vim.log.levels.ERROR)
  return
end

-- colorscheme
vim.opt.termguicolors = true -- Neovim uses 24bit color instead of just 256 colors
vim.cmd.colorscheme("habamax") -- alternatives: tokyonight, tokyonight-storm, evening, unokai, habamax

-- Set <space> as leader key
-- Must happen before plugins are loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- ==============================================================================
-- OPTIONS
-- ==============================================================================
vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- Keep 10 lines above/below and below cursor
vim.opt.sidescrolloff = 10 -- Keep at least 10 lines above and below cursor


vim.opt.tabstop = 2 -- tab width
vim.opt.shiftwidth = 2 -- indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line
vim.opt.breakindent = true -- break indent (for wrapped text)

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if upppercase is in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type


vim.opt.signcolumn = 'yes' -- always show a sign column
vim.opt.colorcolumn = '100' -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show mode, instead have it in statusline (...)
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines
vim.opt.cursorcolumn = false -- no vertical cursor highlight line
vim.opt.winborder = 'rounded' -- rounded borders (e.g. split screens)

local undodir = vim.fn.expand("~/.vim/undodir)
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistant
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create undo file
vim.opt.undodir = undodir -- set the undo directory





vim.cmd([[set mouse=]]) -- disable mouse completely 
-- vim.opt.mouse = 'a' -- mouse enabled for all modes
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
--	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },


  { src = 'https://github.com/nvim-mini/mini.nvim'},

}



-- nvim.mini plugins
require('mini.icons') -- needed for mini.statusline, needs nerdfont
require('mini.git')  -- needed for mini.statusline
require('mini.diff') -- needed for mini.statusline
require('mini.statusline')


-- require('lualine').setup()

-- Fix annoying errors when editing vim config (define vim as global variable)
require('lspconfig').lua_ls.setup({settings = { Lua = { diagnostics = { globals = { "vim" },},},},})

vim.lsp.enable { 'lua_ls', 'pyright', 'r-languageserver', 'tinymist' }



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

