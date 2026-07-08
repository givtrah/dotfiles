local r = require("r")

-- Tracking variables for Quarto outline layout splits
local ed_win = 0
local ed_ft = ""

local M = {}

M.init = function()
  -- Automatically calculate the R binary path dynamically
  local r_binary = vim.fn.system("which R"):gsub("%s+", "")
  local r_path = vim.fs.dirname(r_binary)

  -- Baseline options dictionary
  local opts = {
    R_path = r_path,
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
      on_filetype = function()
        local map_opts = { silent = true, buffer = true, remap = true }

        -- Your original keybindings
        -- vim.keymap.set("n", "<LocalLeader>l", "<Plug>RDSendLine", map_opts)
        vim.keymap.set("n", "<leader>l", "<Plug>RDSendLine", { noremap = true })
--        vim.api.nvim_buf_set_keymap(0, "v", "<LocalLeader>l", "<Plug>RSendSelection", { noremap = true })
        vim.keymap.set("v", "<leader>l", "Plug>RSendSelection", { noremap = true })




        vim.keymap.set("n", "<LocalLeader>f", "<Plug>RSendFunction", map_opts)

        -- Integrated keybindings from the other config
        vim.api.nvim_buf_set_keymap("n", "<LocalLeader>cw", "<Cmd>lua require('r.send').cmd('dev.off()')<CR>", map_opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", { noremap = true} )
        vim.api.nvim_buf_set_keymap("v", "<Enter>", "<Plug>RSendSelection", map_opts)
        vim.api.nvim_buf_set_keymap("n", "<LocalLeader>gn", "<Plug>RNextRChunk zz", map_opts)
        vim.api.nvim_buf_set_keymap("n", "<LocalLeader>gN", "<Plug>RPreviousRChunk zz", map_opts)
        vim.api.nvim_buf_set_keymap("i", "<C-.>", "<Plug>RInsertPipe", map_opts)
      end,

      -- Sets the values required by the object browser hook
      after_R_start = function()
        ed_win = vim.api.nvim_get_current_win()
        ed_ft = vim.bo.filetype
      end,

      -- Automatically links Quarto files with Aerial outlines inside the Object Browser
      after_ob_open = function()
        vim.cmd("CccHighlighterDisable")
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

  -- Dynamic window adjustments based on terminal window widths
  if vim.o.columns > 200 then
    opts.objbr_auto_start = true
    opts.objbr_w = 60
    opts.rconsole_height = 24
    if vim.env.WEZTERM_PANE then
      vim.env.RTERM = "external"
      opts.external_term = "wezterm_split"
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

-- Safely defer initialization until Neovim paths lock down
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    M.init()
  end,
})

return M
