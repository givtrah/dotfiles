-- Ensure minimum v0.12 (vim.pack)
if vim.fn.has("nvim-0.11") == 0 then
  vim.notify("Neovim 0.12+ required", vim.log.levels.ERROR)
  return
end

require("vim._core.ui2").enable({}) -- redesign core messages and command-line (new in 0.12)
require("options")
require("keymaps")
require("autocommands")
require("commands")
require("statusline")
require("pack")
require("treesitter")
require("lsp")
require("r-config")

-- colorscheme
vim.cmd.colorscheme("habamax") -- alternatives: tokyonight, tokyonight-storm, evening, unokai, habamax

-- based mostly on https://github.com/Sin-cy/nvim-scratch
-- https://www.youtube.com/watch?v=XQuNoprFW38&t=627s
--
-- Some parts of the config are from: https://github.com/radleylewis/nvim-lite/blob/master/init.lua
-- https://www.youtube.com/watch?v=lljs_7xB7Ps
