-- https://github.com/romus204/tree-sitter-manager.nvim/tree/main
--
local ensure_installed = {
    "go", "rust", "typescript", "javascript", "tsx",
    "html", "css", "json", "bash",
    "http", "dockerfile",
}

require("tree-sitter-manager").setup({
   ensure_installed = ensure_installed,
})





