local utils = require('vampunzel.utils')

return {
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            { 'folke/neodev.nvim', opts = {} }, -- for neovim diagnostics, etc.
            { 'j-hui/fidget.nvim', opts = {} }, -- for lsp status messages
        },
        config = function()
            require('neodev').setup({})

            local capabilities = vim.lsp.protocol.make_client_capabilities();
            local lspconfig = require('lspconfig')

            -- advertise cmp-nvim-lsp capabilities if it is loaded
            if utils.is_plugin_loaded('cmp-nvim-lsp') then
                capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            end

            -- supported lsps
            local lsps = {
                lua_ls = 'lua-language-server',
                clangd = 'clangd'
            }

            -- load supported lsps if they are available on the system
            for lsp,cmd in pairs(lsps) do
                if vim.fn.executable(cmd) == 1 then
                    lspconfig[lsp].setup({ capabilities = capabilities })
                end
            end
        end,
    }
}
