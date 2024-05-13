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

            wk.register({
                f = { name = '[f]ind' },
                r = { name = '[r]efactor' },
            }, { prefix = '<leader>'})

            if utils.is_plugin_loaded('undotree') then
                wk.register({
                    u = '[u]ndotree'
                }, { prefix = '<leader>' })
            end
        end
    },
}
