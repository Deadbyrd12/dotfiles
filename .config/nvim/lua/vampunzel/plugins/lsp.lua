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

            -- function that sets keybinds
            local on_attach = function(_, bufid)
                -- shortcut for defining keymaps. adds the LSP prefix to the description
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, { buffer = bufid, desc = desc })
                end

                -- close floating previews on ESC (modified from vim.lsp.util.open_floating_preview)
                nmap('<ESC>', function()
                    local existing_float = vim.F.npcall(vim.api.nvim_buf_get_var, bufid, 'lsp_floating_preview')
                    if existing_float and vim.api.nvim_win_is_valid(existing_float) then
                        vim.api.nvim_win_close(existing_float, true)
                    end
                end, "close floating lsp previews")

                -- refactoring keybinds
                nmap('<leader>rr', vim.lsp.buf.rename, '[r]ename symbol')
                nmap('<leader>ra', vim.lsp.buf.code_action, 'code [a]ction')
                nmap('<leader>rf', vim.lsp.buf.code_action, '[f]ormat code')

                -- normal lsp keybinds
                nmap('<leader>gd', vim.lsp.buf.hover, 'goto [d]efinition')
                nmap('<leader>gD', vim.lsp.buf.declaration, 'goto [D]eclaration')
                nmap('<leader>gi', vim.lsp.buf.implementation, 'goto [i]mplementation')
                nmap('<leader>gt', vim.lsp.buf.type_definition, 'goto [t]ype definition')

                -- workspace keybinds
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[a]dd folder to workspace')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[r]emove folder from workspace')
                nmap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, '[l]ist workspace folders')

                -- telescope specific keybinds
                local tele_ok, tele = pcall(require, 'telescope.builtin')
                if tele_ok then
                    nmap('<leader>gr', tele.lsp_references, '[g]oto [r]eferences')
                    nmap('<leader>fs', tele.lsp_document_symbols, '[f]ind [s]ymbols in buffer')
                    --   nmap('<leader>gws', tele.lsp_workspace_symbols, '[g]oto JAHUUU')
                end

                -- register keybind groups with which-key
                local wk_ok, wk = pcall(require, 'which-key')
                if wk_ok then
                    print('')
                    wk.register({
                        g = 'LSP: goto',
                        w = 'LSP: workspace'
                    }, { prefix = '<leader>' })
                end
            end

            -- supported lsps
            local lsps = {
                lua_ls = {
                    cmd = 'lua-language-server',
                    settings = {
                        Lua = {
                            runtime = { version = 'LuaJIT' },
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                        }
                    }
                },
                clangd = {
                    cmd = 'clangd',
                    settings = {}
                }
            }

            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.hover, { desc = 'find files by [c]ontent' })

            -- load supported lsps if they are available on the system
            for lsp,info in pairs(lsps) do
                if vim.fn.executable(info.cmd) == 1 then
                    lspconfig[lsp].setup({
                        capabilities = capabilities,
                        settings = info.settings,
                        on_attach = on_attach
                    })
                end
            end
        end,
    }
}
