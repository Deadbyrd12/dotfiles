---@diagnostic disable: missing-fields
return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function ()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'c',
                    'cpp',
                    'python',
                    'elixir',
                    'erlang',
                    'bash',
                    'bibtex',
                    'c_sharp',
                    'css',
                    'csv',
                    'cuda',
                    'doxygen',
                    'git_config',
                    'git_rebase',
                    'gitattributes',
                    'gitcommit',
                    'gitignore',
                    'html',
                    'http',
                    'ini',
                    'java',
                    'javascript',
                    'json',
                    'json5',
                    'kconfig',
                    'llvm',
                    'make',
                    'markdown',
                    'markdown_inline',
                    'nix',
                    'objdump',
                    'passwd',
                    'regex',
                    'rust',
                    'sql',
                    'toml',
                    'todotxt',
                    'xml',
                    'yaml',
                    'lua',
                    'vim',
                    'vimdoc',
                    'query',
                    'diff'
                },
                highlight = { enable = true },
                indent = { enable = true }
            })
        end
    },

}
