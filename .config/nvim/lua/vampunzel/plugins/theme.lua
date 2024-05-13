return {
    lazy = false,
    priority = 1000,
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
        require('catppuccin').setup({})
        vim.cmd('colorscheme catppuccin-mocha')
    end,
}
