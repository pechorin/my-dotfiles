local treesitter = require('nvim-treesitter')
local languages = {
  'ruby', 'lua', 'rust', 'go', 'gomod', 'python',
  'bash', 'sql', 'regex', 'css', 'html', 'javascript', 'json',
  'typescript', 'tsx', 'vue', 'yaml', 'jinja', 'jinja_inline',
  'embedded_template', 'vim', 'vimdoc', 'markdown', 'markdown_inline',
}

-- Explicit bootstrap; opening a file never starts network downloads.
-- The bang form waits for installation when used by a headless bootstrap.
vim.api.nvim_create_user_command('TSInstallConfigured', function(args)
  local task = treesitter.install(languages, { summary = true })
  if args.bang then task:wait(300000) end
end, { bang = true, desc = 'Install configured Tree-sitter parsers' })

vim.filetype.add({ extension = { j2 = 'jinja', jinja2 = 'jinja' } })

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('config_treesitter', { clear = true }),
  pattern = {
    'ruby', 'lua', 'rust', 'go', 'gomod', 'python', 'sh', 'bash',
    'sql', 'css', 'html', 'javascript', 'javascriptreact', 'json',
    'typescript', 'typescriptreact', 'vue', 'yaml', 'jinja', 'jinja.html',
    'eruby', 'eruby.*', 'vim', 'help', 'markdown',
  },
  callback = function(event)
    -- Missing parsers on a fresh machine fall back to Vim's syntax files.
    if not pcall(vim.treesitter.start, event.buf) then return end
    local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
    if vim.list_contains({ 'javascript', 'typescript', 'tsx', 'jinja' }, lang)
        and vim.treesitter.query.get(lang, 'indents') then
      vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
