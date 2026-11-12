vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = true,
  underline = false,
  update_in_insert = true,
  severity_sort = false,
  float = false,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('config_lsp_attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    if client:supports_method('textDocument/documentSymbol') then
      require('nvim-navic').attach(client, event.buf)
    end

    local function map(lhs, action, desc)
      vim.keymap.set('n', lhs, action, { buf = event.buf, silent = true, desc = desc })
    end
    map('gA', vim.lsp.buf.code_action, 'LSP code action')
    map('gD', vim.lsp.buf.declaration, 'LSP declaration')
    map('gd', vim.lsp.buf.definition, 'LSP definition')
    map('<C-k>', vim.lsp.buf.signature_help, 'LSP signature help')
    map('gr', vim.lsp.buf.references, 'LSP references')
  end,
})

vim.lsp.inlay_hint.enable(true)

vim.lsp.config('solargraph', {
  -- Run the project's bundled server; Neovim uses root_dir as its working directory.
  cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
  settings = {
    solargraph = {
      diagnostics = true,
      formatting = true,
      completion = true,
      hover = true,
      symbols = true,
      definitions = true,
      references = true,
    },
  },
})

-- Small LuaLS setup for Neovim, without neodev. Respect project configuration.
vim.lsp.config('lua_ls', {
  on_init = function(client)
    local workspace = client.workspace_folders and client.workspace_folders[1]
    local path = workspace and workspace.name
    if path and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
      return
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
    })
  end,
  settings = { Lua = {} },
})

-- Use nvim-lspconfig's current defaults and Cargo workspace detection.
vim.lsp.enable({ 'gopls', 'solargraph', 'vimls', 'lua_ls', 'rust_analyzer', 'basedpyright' })

require('go').setup({
  goimports = 'gopls',
  gofmt = 'gopls',
  lsp_cfg = false,
})

require('hover').setup({
  init = function() require('hover.providers.lsp') end,
  preview_opts = { border = 'solid' },
  preview_window = false,
  title = false,
  mouse_providers = { 'LSP' },
  mouse_delay = 1000,
})

vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
vim.o.mousemoveevent = true
