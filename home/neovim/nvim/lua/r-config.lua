local r = require("r")

local M = {}

M.init = function()
  -- This runs after Neovim initializes, so "which R" works flawlessly
  local r_binary = vim.fn.system("which R"):gsub("%s+", "")
  local r_path = vim.fs.dirname(r_binary)

  r.setup({
    -- Sent as a valid, computed string
    R_path = r_path,

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
    min_editor_width = 80,
    rconsole_width = 60,
  })
end

-- Automatically trigger the setup once Neovim finishes loading its paths
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    M.init()
  end,
})

return M

