vim.g.netrw_banner = 0 -- disable file explorer banner

vim.opt.termguicolors = true -- Neovim uses 24bit color instead of just 256 colors

-- Silence providers I don't need (assuming I don't need plugins written in node js, perl or python)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers

vim.opt.tabstop = 2 -- tab width
vim.opt.shiftwidth = 2 -- indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs

vim.opt.wrap = false -- do not wrap lines by default
vim.opt.smartindent = true -- smart auto-indent
vim.opt.inccommand = "split" -- split preview window dof search etc.

vim.opt.splitbelow = true -- split help below instead of above
vim.opt.splitright = true

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if upppercase is in string
vim.opt.laststatus = 3 -- allow one full status line for split screens

-- UNDO
local undodir = vim.fn.expand("~/.vim/undodir")
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

vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.isfname:append("@-@") -- allow @ in filenames
vim.opt.guicursor = "" -- terminal will control cursor
vim.opt.scrolloff = 8 -- Keep 8 lines above/below and below cursor

vim.opt.colorcolumn = "0" -- show a column at X position chars (0 = off)
vim.opt.signcolumn = 'yes' -- always show a sign column
vim.opt.cmdheight = 0 -- Hide command line when unused (1 = single line)

vim.opt.autoindent = true -- copy indent from current line
vim.opt.breakindent = true -- break indent (for wrapped text)

-- fixes statusline and general transparency
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



























-- from radley lewis, consider which ones should be passed to above












vim.opt.cursorline = true -- highlight current line

vim.opt.sidescrolloff = 10 -- Keep at least 10 lines above and below cursor

vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type


vim.opt.showmatch = true -- highlights matching brackets
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
vim.opt.cursorcolumn = true -- vertical cursor highlight line
vim.opt.winborder = 'rounded' -- rounded borders (e.g. split screens)


vim.opt.timeout = true
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 1000 -- Mapped sequence wait time (1000 ms is default)
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save
vim.opt.confirm = true -- Ask to save changes if just quitting and not saving




vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start" -- better backspace behavior
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
-- vim.opt.mouse = "a" -- enable mouse support
vim.cmd([[set mouse=]]) -- disable mouse completely 
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "UTF-8" -- set encoding

-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blin
-- k-blinkwait175-blinkoff150-blinkon175" -- cursor blinking and settings


