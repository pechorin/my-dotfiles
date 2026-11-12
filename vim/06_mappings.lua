-- Custom bindings with descriptions for which-key and :map.
vim.g.mapleader = ','

vim.keymap.set('n', ';', ':', { remap = true, desc = 'Enter command line' })
vim.keymap.set('n', 'K', '<Nop>', { remap = true, desc = 'Disable default man lookup' })

-- Bash-like keys for cmd
vim.keymap.set('c', '<C-A>', '<Home>', { desc = 'Bash-like CTRL+A for command line' })
vim.keymap.set('c', '<C-E>', '<End>', { desc = 'Bash-like CTRL+E for command line' })
vim.keymap.set('c', '<C-K>', '<C-U>', { desc = 'Bash-like CTRL+K for command line' })

-- Tabs, windows, buffer navigation
vim.keymap.set('n', '<S-Right>', ':tabnext<CR>', { remap = true, desc = 'Next tab' })
vim.keymap.set('n', '<S-Left>', ':tabprevious<CR>', { remap = true, desc = 'Previous tab' })
vim.keymap.set('n', '<S-p>', ':tabnext<CR>', { remap = true, desc = 'Next tab' })
vim.keymap.set('n', '<S-o>', ':tabprevious<CR>', { remap = true, desc = 'Previous tab' })
vim.keymap.set('n', '<S-Up>', ':bnext<CR>', { remap = true, desc = 'Next buffer' })
vim.keymap.set('n', '<S-Down>', ':bprevious<CR>', { remap = true, desc = 'Prev buffer' })
vim.keymap.set('n', 'Q', ':tabclose<CR>', { remap = true, desc = 'Close tab' })
vim.keymap.set('n', 'Z', ':bdelete<CR>', { remap = true, desc = 'Delete buffer' })

-- Visual align text
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { remap = true, desc = 'Align in visual mode (e.g. `vipga`)' })
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { remap = true, desc = 'Align for a motion/text object (e.g. `gaip`)' })

-- Navigation
vim.keymap.set('n', '<leader>n', ':NERDTree<CR>', { remap = true, desc = 'NERDTree for project' })
vim.keymap.set('n', '<leader>N', ':NERDTree %<CR>', { remap = true, desc = 'NERDTree for current file' })
vim.keymap.set('n', '<leader>w', ':WhichKey<CR>', { remap = true, desc = 'WhichKey help' })
vim.keymap.set('n', '<leader>m', ':Neotree<CR>', { remap = true, desc = 'Neotree' })
vim.keymap.set('n', '<leader>M', ':Neotree %<CR>', { remap = true, desc = 'Neotree for current file' })
vim.keymap.set('n', '<leader>,', ':Neotree buffers<CR>', { remap = true, desc = 'Neotree buffers' })
vim.keymap.set('n', '<leader>.', ':Neotree float git_status<CR>', { remap = true, desc = 'Neotree git' })
vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { remap = true, desc = 'Create new tab' })
vim.keymap.set('n', '<C-ScrollWheelUp>', ':tabnext<CR>', { desc = 'ctrl+mousewheel for tab switching' })
vim.keymap.set('n', '<C-ScrollWheelDown>', ':tabprevious<CR>', { desc = 'ctrl+mousewheel for tab switching' })
vim.keymap.set('', '<leader>x', '<cmd>bp|bd#<CR>', { desc = 'Kill current buffer' })
vim.keymap.set('n', '<C-LeftMouse>', ':AnyJump<CR>', { desc = 'Run AnyJump on ctrl+click' })

-- Commenting
vim.keymap.set('n', '<leader>c', 'gcc', { remap = true, desc = 'Comment current line' })
vim.keymap.set('x', '<leader>c', 'gc', { remap = true, desc = 'Comment visualy selected text' })

-- FZF navigation
vim.keymap.set('n', '<leader>b', ':FzfLua buffers<CR>', { remap = true, desc = 'fzf Buffers' })
vim.keymap.set('n', '<leader>q', ':FzfLua files<CR>', { remap = true, desc = 'fzf Project files' })
vim.keymap.set('n', '<leader>rr', ':FzfLua oldfiles<CR>', { remap = true, desc = 'fzf most recent used files' })
vim.keymap.set('n', '<leader>rh', ':FzfLua oldfiles<CR>', { remap = true, desc = 'fzf history' })
vim.keymap.set('n', '<leader>sr', ':Rg', { remap = true, desc = 'fzf rg' })
vim.keymap.set('n', '<leader>sc', ':FzfLua git_commits<CR>', { remap = true, desc = 'fzf commits list' })
vim.keymap.set('n', '<leader>ff', ':FzfLua files<CR>', { remap = true, desc = 'fzf-lua files' })
vim.keymap.set('n', '<leader>fa', ':FzfLua<CR>', { remap = true, desc = 'fzf-lua all pickers' })

-- Colors
vim.keymap.set('n', '<leader>ec', ':FzfLua colorschemes<CR>', { remap = true, desc = 'fzf-lua colorschemes' })

-- Vim config manipulations
vim.keymap.set('n', '<leader>ee', ':so %<CR>', { remap = true, desc = '(vimrc) Eval current file as vimscript' })
vim.keymap.set('n', '<leader>eb', ':e ~/.vimrc <CR>', { remap = true, desc = '(vimrc) Open $MYVIMRC in current buffer' })

-- Git Mappings
vim.keymap.set('n', '<leader>gg', ':tab Git<CR>', { remap = true, desc = 'Open Git in new tab' })
vim.keymap.set('n', '<leader>gG', ':Git<CR>', { remap = true, desc = 'Open Git in split' })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { remap = true, desc = 'Git blame for file' })
vim.keymap.set('n', '<leader>gl', ':Gllog<CR>', { remap = true, desc = 'Git logs' })

-- Terminal mode
vim.keymap.set('t', '<C-w>', '<C-\\><C-o><C-w>', { desc = 'Make C-w C-w works in term' })

vim.keymap.set('v', '//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>', { desc = 'Search visual selected text via //' })
-- Quickfix
vim.keymap.set('n', '<Leader>co', ':copen<CR>', { desc = 'Show quickfix' })
vim.keymap.set('n', '<Leader>cc', ':cclose<CR>', { desc = 'Hide quickfix' })

-- Cycle through text objects with space
vim.keymap.set('', '<SPACE>', '<Plug>(wildfire-fuel)', { remap = true, desc = 'This selects the next closest text object' })
vim.keymap.set('v', '<C-SPACE>', '<Plug>(wildfire-water)', { remap = true, desc = 'This selects the previous closest text object' })

vim.keymap.set('n', '<Leader>gS', ':GrugFar<CR>', { desc = 'Run search window' })
