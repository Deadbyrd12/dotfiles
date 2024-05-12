local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

-- disable scrolling in preview window and rebind scrolling in result list
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-n>'] = false,
        ['<C-p>'] = false,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next
      }
    }
  }
}

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [s]iles' })
vim.keymap.set('n', '<leader>fc', builtin.live_grep, { desc = '[f]ind files by [c]ontent' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[f]ind [r]ecent files' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[f]ind existing [b]uffers' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[f]ind [d]iagnostics' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind [h]elp' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[f]ind current [w]ord' })

vim.keymap.set('n', '<leader>fi', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[f]ind [i]n current buffer' })

--vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[g]it [f]ind file' })
