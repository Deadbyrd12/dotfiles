local lspconfig = require 'mason-lspconfig'

-- define lsp servers
-- change filetypes for lsp by defining filetypes property in settings
--    server = { somesettings = false, filetypes = { 'fileextension' }}
local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- set globals to avoid warnings
      diagnostics = { globals = { 'vim', 'color' }}
    }
  },
}

-- setup neovim config lsp
require('neodev').setup()

-- change client capabilities to include completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- this gets run when lsp attaches to a buffer and sets keymaps
local on_attach = function(_, bufid)
  -- shortcut for defining keymaps. adds the LSP prefix to the description
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufid, desc = desc })
  end

  -- refactoring keybinds
  nmap('<leader>rr', vim.lsp.buf.rename, '[r]efactor [r]ename')
  nmap('<leader>ra', vim.lsp.buf.code_action, '[r]efactor code [a]ction')

  -- normal lsp keybinds
  nmap('<leader>gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
  nmap('<leader>gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('<leader>gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation')
  nmap('<leader>gt', vim.lsp.buf.type_definition, '[g]oto [t]ype definition')

  -- workspace keybinds
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[w]orkspace [l]ist Folders')

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

-- ensure servers are installed
lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers)
}

-- setup servers
lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
      capabilities = capabilities,
      on_attach = on_attach
    }
  end
}
