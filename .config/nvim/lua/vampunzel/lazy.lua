-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('vampunzel.plugins', {})

-- require('lazy').setup({
--
--   -- catppuccin for colors
--   {
--     'catppuccin/nvim',
--     name = 'catppuccin',
--     priority = 1000
--   },
--
--   -- statusline
--   {
--     'nvim-lualine/lualine.nvim',
--     event = 'VeryLazy',
--     config = function()
--       require('vampunzel.lualine')
--     end
--   },
--
--  -- show pending keybinds
--   {
--     'folke/which-key.nvim',
--     config = function()
--       require('vampunzel.which-key')
--     end
--   },
--
--   -- fuzzy finding
--   {
--     'nvim-telescope/telescope.nvim',
--     tag = '0.1.2',
--     dependencies = {
--       'nvim-lua/plenary.nvim'
--     },
--     config = function()
--       require('vampunzel.telescope')
--     end
--   },
--
--   -- graphical undo tree
--   {
--     'mbbill/undotree',
--     config = function()
--       vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
--     end
--   },
--
--   -- autopair to complete brackets, etc.
--   {
--     'windwp/nvim-autopairs',
--     event = 'InsertEnter',
--     config = true
--   },
--
--   -- treesitter for syntax highlighting, AST, etc.
--   {
--     'nvim-treesitter/nvim-treesitter',
--     build = ':TSUpdate',
--     config = function ()
--       require('vampunzel.treesitter')
--     end
--   },
--
--   -- easy commenting blocks of code
--   {
--     'numToStr/Comment.nvim',
--     config = function ()
--       require('vampunzel.comment')
--     end,
--     lazy = false
--   },
--
--   -- lsp setup
--   {
--     'neovim/nvim-lspconfig',
--     dependencies = {
--       -- {
--       --   'williamboman/mason.nvim',
--       --   config = true
--       -- },
--       -- 'williamboman/mason-lspconfig.nvim',
--
--       -- status updates for lsp
--       {
--         'j-hui/fidget.nvim',
--         tag = 'legacy',
--         config = true
--       },
--
--       -- for nvim configuration
--       {
--         'folke/neodev.nvim',
--         opts = {}
--       }
--     },
--     config = function()
--       require('vampunzel.lsp2')
--     end
--   },
--
--   -- autocompletion based on lsp
--   {
--     'hrsh7th/nvim-cmp',
--     dependencies = {
--       -- snippet engine is required for some completions
--       'L3MON4D3/LuaSnip',
--
--       -- completion sources
--       'hrsh7th/cmp-nvim-lsp',    -- lsp
--       'hrsh7th/cmp-path'         -- system paths
--     },
--     config = function()
--       require('vampunzel.cmp')
--     end
--   },
--
--   -- install without yarn or npm
--   {
--     "iamcco/markdown-preview.nvim",
--     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--     ft = { "markdown" },
--     build = function() vim.fn["mkdp#util#install"]() end,
--   }
-- })
