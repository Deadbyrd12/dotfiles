require('nvim-treesitter.configs').setup({
  ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'diff' },
  highlight = { enable = true },
  indent = { enable = true }
})
