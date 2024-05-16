vim.g.mapleader = ' '
vim.g.localmapleader = ' '
vim.api.nvim_set_keymap('', '<leader>', '<Nop>', { silent = true })

-- Buffer navigation
vim.keymap.set('n', '<leader>bn', ':bn<CR>')
vim.keymap.set('n', '<leader>bp', ':bp<CR>')
vim.keymap.set('n', '<leader>bd', ':bd<CR>')
