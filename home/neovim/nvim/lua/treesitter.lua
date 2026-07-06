-- https://github.com/romus204/tree-sitter-manager.nvim/tree/main
--
local ensure_installed = {
    "go", "rust", "typescript", "javascript", "tsx",
    "html", "css", "json", "bash",
    "http", "dockerfile", "r", "csv", "yaml", "rnoweb", "typst",
}

require("tree-sitter-manager").setup({
   ensure_installed = ensure_installed,

})





