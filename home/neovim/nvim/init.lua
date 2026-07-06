-- Ensure minimum v0.12 (vim.pack)
if vim.fn.has("nvim-0.11") == 0 then
  vim.notify("Neovim 0.12+ required", vim.log.levels.ERROR)
  return
end

require("vim._core.ui2").enable({}) -- redesign core messages and command-line (new in 0.12)
require("options")
require("autocommands")
require("keymaps")
require("statusline")

require("treesitter")




-- colorscheme
vim.opt.termguicolors = true -- Neovim uses 24bit color instead of just 256 colors
vim.cmd.colorscheme("habamax") -- alternatives: tokyonight, tokyonight-storm, evening, unokai, habamax

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

--
-- PLUGINS
--



-- based mostly on https://github.com/Sin-cy/nvim-scratch
-- https://www.youtube.com/watch?v=XQuNoprFW38&t=627s
--
-- Some parts of the config are from: https://github.com/radleylewis/nvim-lite/blob/master/init.lua
-- https://www.youtube.com/watch?v=lljs_7xB7Ps
