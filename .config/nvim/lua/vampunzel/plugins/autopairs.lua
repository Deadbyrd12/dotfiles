local utils = require('vampunzel.utils')

return {
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")
            npairs.setup({})

            if utils.is_plugin_loaded('cmp') then
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                local cmp = require("cmp")

                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
                npairs.add_rules({
                    Rule("<", ">", { "markdown", "rst" }):with_move(),
                    Rule('"""', '"""', "python"):with_move(),
                    Rule(":", ":", "rst"):with_move(),
                })
            end
        end
    }
}
