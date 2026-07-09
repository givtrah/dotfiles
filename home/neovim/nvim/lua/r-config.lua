local r = require("r")

-- Tracking variables for Quarto outline layout splits
local ed_win = 0
local ed_ft = ""

local M = {}

M.init = function()
  -- Baseline options dictionary
  local opts = {
    objbr_place = "script,left",
    min_editor_width = 80,
    rconsole_width = 80,
    setwd = "file",
    roxygen_hl = true,
    debug_jump = true,
    nvimpager = "split_h",
    register_treesitter = true,
    clear_line = true,
    clear_console = false,

    r_ls = {
      fun_data_2 = {
        mutate = { "case_match", "case_when", "factor", "as.numeric", "cut" },
        ggplot = { "aes" },
        with = { "*" },
      },
    },

    hook = {
      -- Sets the values required by the object browser hook
      after_R_start = function()
        ed_win = vim.api.nvim_get_current_win()
        ed_ft = vim.bo.filetype
      end,

      -- Automatically links Quarto files with Aerial outlines inside the Object Browser
      after_ob_open = function()
        local ob_win = vim.api.nvim_get_current_win()
        local ob_buf = vim.api.nvim_get_current_buf()
        vim.schedule(function()
          if ed_ft == "quarto" then
            vim.api.nvim_open_win(
              ob_buf,
              false,
              { win = ob_win, split = "below", height = 45 }
            )
            require("aerial").open_in_win(ob_win, ed_win)
          end
        end)
      end,
    },

    objbr_mappings = {
      c = "class",
      p = "print",
      s = "summary",
      t = "table",
      l = "levels",
    },

    R_args = { "--quiet", "--no-save", "--no-restore" },

    compl_data = {
      max_depth = 2,
      max_size = 1000000,
      max_time = 100,
    },

    disable_cmds = {
      "RClearConsole", "RCustomStart", "RDputObj", "RInsertLineOutput",
      "RMakeHTML", "RMakeODT", "RMakePDFKb", "RMakeWord", "RSPlot",
      "RSaveClose", "RSendMotion", "RViewDFa", "RViewDFs", "RViewDFv",
    },
  }
  -- Safely check and inject R_path if it exists
  -- local r_binary = vim.fn.exepath("R")
  -- if r_binary and r_binary ~= "" then
--    local r_dir = vim.fs.dirname(r_binary)
--    if r_dir and r_dir ~= "" then
--      opts.R_path = r_dir
--    end
--  end


  -- Dynamic window adjustments based on terminal window widths
  if vim.o.columns > 200 then
    opts.objbr_auto_start = true
    opts.objbr_w = 60
    opts.rconsole_height = 24
    if vim.env.KITTY_WINDOW_ID then
      vim.env.RTERM = "external"
      opts.external_term = "kitty"
    end
  elseif vim.o.columns > 140 then
    opts.objbr_auto_start = false
    opts.objbr_w = 35
    opts.rconsole_height = 20
  else
    opts.objbr_auto_start = false
    opts.objbr_w = 25
    opts.rconsole_height = 14
  end

  -- Handles environmental auto-start configuration flags
  opts.auto_start = vim.env.R_AUTO_START == "true" and "on startup" or "no"

  -- Finally, pass everything to R.nvim
  r.setup(opts)
end

-- Initialize R.nvim immediately so its internal structures map normally
M.init()

-- Native, bulletproof Neovim FileType autocommand.
-- This forces the mappings to apply to the buffer regardless of startup race conditions.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "r", "rmd", "quarto" },
  callback = function()
    local map_opts = { silent = true, buffer = true, remap = true }

    -- Core Keybindings (Maps both 'v' and 'x' to thoroughly cover visual mode variations)
    vim.keymap.set("n", "<leader>l", "<Plug>RDSendLine", map_opts)
    vim.keymap.set({ "v", "x" }, "<leader>l", "<Plug>RSendSelection", map_opts)
    vim.keymap.set("n", "<LocalLeader>f", "<Plug>RSendFunction", map_opts)

    -- Integrated keybindings
    vim.keymap.set("n", "<LocalLeader>cw", "<Cmd>lua require('r.send').cmd('dev.off()')<CR>", map_opts)
    vim.keymap.set("n", "<Enter>", "<Plug>RDSendLine", map_opts)
    vim.keymap.set({ "v", "x" }, "<Enter>", "<Plug>RSendSelection", map_opts)
    vim.keymap.set("n", "<LocalLeader>gn", "<Plug>RNextRChunk zz", map_opts)
    vim.keymap.set("n", "<LocalLeader>gN", "<Plug>RPreviousRChunk zz", map_opts)
    vim.keymap.set("i", "<C-.>", "<Plug>RInsertPipe", map_opts)
  end,
})

return M
