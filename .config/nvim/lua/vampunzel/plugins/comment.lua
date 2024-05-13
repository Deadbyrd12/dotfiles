---@diagnostic disable: missing-fields
return {
    {
        'numToStr/Comment.nvim',
        config = function ()
            require('Comment').setup({
                mappings = false
            })

            local comment = require('Comment.api')

            local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

            vim.keymap.set('n', '<leader>rcc', comment.toggle.linewise.current, {desc = 'refactor [c]omment [c]urrent line'})
            vim.keymap.set('n', '<leader>rc', comment.call('toggle.linewise', 'g@'), {expr = true, desc = 'refactor [c]omment'})
            vim.keymap.set('x', '<leader>rc', function()
                vim.api.nvim_feedkeys(esc, 'nx', false)
                comment.toggle.linewise(vim.fn.visualmode())
            end, { desc = 'refactor [c]omment' })
        end,
        lazy = false
    }
}
