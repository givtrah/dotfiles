return {
  -- Add R.nvim plugin for R language support
  {
    'R-nvim/R.nvim', -- Official plugin for R language support in Neovim
    ft = { 'r', 'rmd', 'qmd' }, -- Only load for R-related filetypes
    config = function()
      -- Create a table with all the options to be passed to setup()
      local opts = {
        hook = {
          on_filetype = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
            vim.api.nvim_buf_set_keymap(0, "i", "<C-s>", "<Plug>RPipe", {})
            vim.api.nvim_buf_set_keymap(0, "i", "<C-a>", "<Plug>RAssign", {})
          end,
        },
        -- Combined R_args
        R_args = { "--quiet", "--no-save" },
        min_editor_width = 72,
        rconsole_width = 78,
        objbr_opendf = false,
        objbr_openlist = false,
        objbr_auto_start = false,
        objbr_place = "script,right",
        pdfviewer = "okular",
        disable_cmds = {
          "RClearConsole",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
        },
        -- Use "radian" as the R application
        R_app = "radian",
        R_cmd = "R", -- Keep R_cmd as R unless you have a specific reason to change it
        hl_term = false,
        bracketed_paste = true,
        auto_quit = true,
        view_df = {
          open_app = "terminal:vd", -- Launches `vd` in a terminal buffer
        },
        -- Initialize auto_start here, will be potentially overridden by env var
        auto_start = "on startup", -- Default to on_load, adjust if needed
      }

      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == "true" then
        opts.auto_start = "on startup"
        opts.objbr_auto_start = true
      end

      -- Configure the R.nvim plugin with the combined options
      require('r').setup(opts)

      -- Add LSP configuration for R language server (languageserver package)
      local lspconfig = require 'lspconfig'

      -- Setup the R language server (languageserver package)
      lspconfig.r_language_server.setup {
        cmd = { 'R', '--slave', '-e', 'languageserver::run()' },
        filetypes = { 'r', 'rmd', 'qmd' },
        root_dir = function(fname)
          -- Try to find .git or .Rproj upwards from the current file
          local root_files = vim.fs.find({ '.git', '.Rproj' }, { path = fname, upward = true })
          if #root_files > 0 then
            return vim.fs.dirname(root_files[1])
          end
          -- If no root is found, fall back to the current directory
          return vim.fs.dirname(fname)
        end,
        settings = {
          r = {
            lsp = {
              diagnostics = true, -- Ensure diagnostics are enabled
            },
          },
        },
      }
    end,
  },
}

