require('Comment').setup({
  mappings = {
    extra = false
  }
})

local comment = require('Comment.api')

local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

vim.keymap.set('n', '<leader>rcc', comment.toggle.linewise.current, {desc = '[r]efactor [c]omment [c]urrent line'})
vim.keymap.set('n', '<leader>rc', comment.call('toggle.linewise', 'g@'), {expr = true, desc = '[r]efactor [c]omment'})
vim.keymap.set('x', '<leader>rc', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  comment.toggle.linewise(vim.fn.visualmode())
end, { desc = '[r]efactor [c]omment' })
