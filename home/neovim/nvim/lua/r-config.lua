local r = require("r")

r.setup({
  -- Hook configuration allows setting up buffer-specific settings
  hook = {
    on_filetype = function()
      -- Custom keybindings specifically for R files
      local opts = { silent = true, buffer = true }

      -- Send current line to R console
      vim.keymap.set("n", "<LocalLeader>l", "<Plug>RDSendLine", opts)
      -- Send current visual selection to R console
      vim.keymap.set("v", "<LocalLeader>l", "<Plug>RDSendSelection", opts)
      -- Send entire function to R console
      vim.keymap.set("n", "<LocalLeader>f", "<Plug>RDSendFunction", opts)
    end
  },

  -- Configuration Options
  R_args = {"--no-save", "--no-restore"}, -- Clean R startup args

  min_version = "0.1.0",

  -- Terminal orientation configuration
  -- "v" for vertical split, "h" for horizontal split
  split_orientation = "v",

  -- Width of the vertical split window when R starts
  split_width = 60,

  -- Automatically look for custom package documentation web view
  rich_documentation = false,
})

