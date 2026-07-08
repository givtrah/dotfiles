vim.pack.add({
-- just color-theme    "https://github.com/bluz71/vim-moonfly-colors",

  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
  "https://github.com/neovim/nvim-lspconfig",
--  "https://github.com/mason-org/mason.nvim",
  "https://github.com/tpope/vim-fugitive",
  { src = "https://github.com/R-nvim/R.nvim" },
})

-- mini files ----
local MiniFiles = require("mini.files")
MiniFiles.setup({})

---- mini notify ----
require("mini.notify").setup({})

--- mini cmdline completion ---
require("mini.cmdline").setup({
    autocorrect = { enable = false }
})

--- mini surround ---
require("mini.surround").setup()

--- mini picker ---
local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

--- mini completions --- 
require("mini.completion").setup({
    lsp_completion = {
        auto_setup = true,
    }
})

--- mini snippets ---
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(), -- loads friendly-snippets
    },
})
MiniSnippets.start_lsp_server({ match = false })

--- mini diff and fugitive ---
local MiniDiff = require("mini.diff")
MiniDiff.setup({
	source = MiniDiff.gen_source.git({ index = false }),
})


require('lspconfig').lua_ls.setup({settings = { Lua = { diagnostics = { globals = { "vim" },},},},})

vim.lsp.enable { 'lua_ls', 'pyright', 'r-languageserver', 'tinymist' }

