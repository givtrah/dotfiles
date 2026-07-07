
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

vim.lsp.config("yaml_language-server", {})
vim.lsp.config("tsserver", {})
vim.lsp.config("r_languageserver", {})

-- get rid of lsp warnings for filetypes
vim.filetype.add({
  extension = {
    mdx = 'markdown.mdx',
    gotmpl = 'gotmpl',
  },
  filename = {
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['gitlab-ci.yml'] = 'yaml.gitlab',
    ['gitlab-ci.yaml'] = 'yaml.gitlab',
    ['values.yaml'] = 'yaml.helm-values',  -- Added for Helm
    ['values.yml'] = 'yaml.helm-values',   -- Added for Helm
  },
  -- Optional: If you use custom names like my-values.yaml, catch them by pattern
  pattern = {
    ['.*values%.yaml'] = 'yaml.helm-values',
    ['.*values%.yml'] = 'yaml.helm-values',
  }
})

-- r languageserver setup
local r_lsp_config = {
  cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
  filetypes = { "r" }, 
  root_dir = function(bufnr, on_dir)
    -- Fallback to your home directory if a .git folder isn't found
    on_dir(vim.fs.root(bufnr, '.git') or vim.uv.os_homedir())
  end,
  settings = {
    r = {
      lsp = {
        rich_documentation = false,
      },
      server_capabilities = {
        -- Prevents R from trying to format your code (useful if using styler or null-ls)
        documentFormattingProvider = false,
        documentRangeFormattingProvider = false,
      }
    },
  },
}
vim.lsp.config('r-languageserver', r_lsp_config)









vim.lsp.enable({
    "gopls",
    "lua_ls",
    "marksman",
    "pyright",
    "r-languageserver",
    "rust_analyzer",
    "tinymist",
    "tsserver",
    "yamlls",
})
