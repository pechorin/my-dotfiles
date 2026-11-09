local nvim_treesitter = {
  languages = {
    "ruby", "lua", "rust", "go", "gomod",
    "bash", "sql", "regex",
    "css", "html", "javascript", "json", "typescript", "vue",
    "embedded_template",
    "vim", "vimdoc",
    "markdown", "markdown_inline"
  }
}

-- require("nvim-treesitter.install").prefer_git = true

-- require('nvim-treesitter.configs').setup {
--   ensure_installed = nvim_treesitter.languages,
--   sync_install     = true,
--   auto_install     = true,
--   highlight        = { enable = true },
-- }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})
