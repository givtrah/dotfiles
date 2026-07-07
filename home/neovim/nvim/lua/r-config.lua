local r = require("r")

r.setup({
  -- Custom keybindings specifically for your R script buffers
  hook = {
    on_filetype = function()
      local opts = { silent = true, buffer = true }

      -- Send current line to R console
      vim.keymap.set("n", "<LocalLeader>l", "<Plug>RDSendLine", opts)
      -- Send current visual selection to R console
      vim.keymap.set("v", "<LocalLeader>l", "<Plug>RDSendSelection", opts)
      -- Send entire function to R console
      vim.keymap.set("n", "<LocalLeader>f", "<Plug>RDSendFunction", opts)
    end
  },

  -- Clear runtime startup arguments
  R_args = {"--no-save", "--no-restore"},

  -- Sizing variables recognized by modern versions of R.nvim 
  -- to automatically handle the internal console layout split
  min_editor_width = 80,
  rconsole_width = 60,
  -- Tell R.nvim to use httpgd for graphic rendering output
  -- important, add the following to your ~/.Rprofile:
  -- # If running inside Neovim, default plotting actions to httpgd
  -- if (interactive() && Sys.getenv("NVIMR_TMPDIR") != "") {
  -- options(device = function(...) httpgd::hgd(...))
  -- }

  view_df = "httpgd",
  -- Performance tweaks:
  sync_attributes = false,   -- Disables heavy real-time text attribute syncing
  update_user_env = false,   -- Stops Neovim from checking R's RAM variables on every keypress
})
