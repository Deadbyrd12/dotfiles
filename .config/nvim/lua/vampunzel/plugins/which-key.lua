local utils = require('vampunzel.utils')
return {
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            local wk = require('which-key')

            wk.setup ({
                icons = {
                    separator = '->',
                    group = ''
                }
            })

            wk.add({
                { "<leader>f", name = '[f]ind' },
                { "<leader>r", name = '[r]efactor' },
            }, { prefix = '<leader>'})

            if utils.is_plugin_loaded('undotree') then
                wk.add({
                    { "<leader>u", '[u]ndotree' }
                }, { prefix = '<leader>' })
            end
        end
    },
}
