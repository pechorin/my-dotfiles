require('lualine').setup({
  options = {
    theme              = 'auto',
    globalstatus       = true,
    refresh            = { statusline = 3000, tabline = 3000, winbar = 3000 },
    section_separators = '', component_separators = '',
    disabled_filetypes = { winbar = { 'nerdtree', 'neo-tree' , 'alpha', 'fugitive', '', 'esearch'} },
  },
  sections = {
    lualine_a = {
      { 'mode', fmt = function(str) return str:sub(1,1) end, padding = 1 },
    },
    lualine_b = {'branch', 'diff'},
    lualine_c = {
      { 'filename', path = 1, newfile_status = true }
    },
    lualine_x = {
      'fileformat', 'encoding', 'filetype', 'diagnostics',
    },
    lualine_y = {'progress'},
    lualine_z = {'location', 'searchcount', 'selectioncount'},
  },
  winbar = {
    lualine_a = {
    },
    lualine_z = {
      { 'filename', path = 1, newfile_status = true },
    }
  },
  inactive_winbar = {
    lualine_z = {
      { 'filename', path = 1, newfile_status = true }
    }
  },
  extensions = {'quickfix', 'fzf', 'nerdtree', 'neo-tree', 'fugitive', 'man', 'trouble'}
})
