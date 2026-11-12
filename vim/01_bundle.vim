" filetype off

call plug#begin('~/.vim/bundle')

" -- general vim libs --
Plug 'ray-x/guihua.lua', { 'do': 'cd lua/fzy && make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

" -- editor --
Plug 'tiagovla/scope.nvim'           " Make buffers scoped to tab page
Plug 'folke/which-key.nvim'          " Display key definitions in cool menu
Plug 'simeji/winresizer'             " Resize windows with ctrl+e
Plug 'AndrewRadev/linediff.vim'      " Diff between lines
Plug 'rgroli/other.nvim'

Plug 'ChmaraX/herdr-nvim'

Plug 'OXY2DEV/markview.nvim'

" -- editing --
Plug 'vim-scripts/CursorLineCurrentWindow'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'gcmt/wildfire.vim'           " Cycle thought text objects
Plug 'jinh0/eyeliner.nvim'         " Move faster with unique f/F indicators for each word on the line.
Plug 'dhruvasagar/vim-table-mode'  " Table-mode support
Plug 'abecodes/tabout.nvim'
Plug 'stevearc/conform.nvim'

" Plug 'gbprod/cutlass.nvim'

" -- tree-sitter --
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main', 'do': ':TSUpdate' }
" Plug 'nvim-treesitter/playground'

" -- lsp --
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind.nvim'

" -- code completion --
Plug 'iguanacucumber/magazine.nvim', { 'as': 'nvim-cmp' }
Plug 'iguanacucumber/mag-nvim-lsp', { 'as': 'cmp-nvim-lsp' }
Plug 'iguanacucumber/mag-buffer', { 'as': 'cmp-buffer' }
Plug 'iguanacucumber/mag-cmdline', { 'as': 'cmp-cmdline' }

Plug 'https://codeberg.org/FelipeLema/cmp-async-path'

Plug 'ray-x/lsp_signature.nvim'
" Plug 'saadparwaiz1/cmp_luasnip'

" -- snippets --
" Plug 'rafamadriz/friendly-snippets'
" Plug 'garymjr/nvim-snippets'

" -- pairs --
Plug 'windwp/nvim-autopairs'     " Auto close quotes and other pairs

" -- life_quality --
Plug 'mbbill/undotree'           " undo explorer

" -- search_tools --
Plug 'jremmen/vim-ripgrep'
Plug 'eugen0329/vim-esearch'
Plug 'romainl/vim-cool'
Plug 'MagicDuck/grug-far.nvim'

" -- ui --
Plug 'kevinhwang91/nvim-bqf'       " Better quickfix
Plug 'goolord/alpha-nvim'          " Starup dashboard
Plug 'nvim-lualine/lualine.nvim'   " Statusline
Plug 'nanozuki/tabby.nvim'         " Custom tabline
Plug 'lewis6991/hover.nvim'        " LSP doc on hover
Plug 'scrooloose/nerdtree'         " Sidebar filemanagers
Plug 'nvim-neo-tree/neo-tree.nvim' " Modern file tree
Plug 'j-hui/fidget.nvim'           " Notifications
Plug 'dgagn/diagflow.nvim'         " LSP diagnostics in virtual text at the top right of your screen
Plug 'stevearc/overseer.nvim'      " Command runner with ui
Plug 'SmiteshP/nvim-navic'         " Show lsp path in window header
Plug 'petertriho/nvim-scrollbar'   " Custom scrollbar

" -- git --
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" -- ctags --
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" -- fzf --
" Plug '/opt/homebrew/opt/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'pbogut/fzf-mru.vim'

Plug 'ibhagwan/fzf-lua'

" -- languages --
" Ruby is selected by mise through PATH.
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-haml'
Plug 'plasticboy/vim-markdown'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'rust-lang/rust.vim'
Plug 'lepture/vim-jinja'          " Jinja indentation; highlighting uses Tree-sitter
Plug 'ap/vim-css-color'
Plug 'pearofducks/ansible-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'chr4/nginx.vim'
Plug 'slim-template/vim-slim'

Plug 'hedyhli/markdown-toc.nvim'

" -- Lsp & tree-sitter support --
Plug 'nvim-tree/nvim-web-devicons'

" -- Golang support --
Plug 'ray-x/go.nvim'

" -- colorschemes --
Plug 'rktjmp/lush.nvim'

Plug 'rockyzhang24/arctic.nvim', { 'branch': 'v2' }
Plug 'navarasu/onedark.nvim'
Plug 'ChrisKempson/Tomorrow-Theme', { 'rtp': 'vim' }
Plug 'yorik1984/newpaper.nvim'
Plug 'oneslash/helix-nvim'
Plug 'savq/melange-nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'lunacookies/vim-colors-xcode'
Plug 'metalelf0/jellybeans-nvim'
Plug 'ilof2/posterpole.nvim'
" Plug 'RRethy/nvim-base16'

" Plug 'Mofiqul/adwaita.nvim'
Plug 'pechorin/adwaita.nvim', { 'commit': 'c9379097755701ab597140bafd097fbaff3dd517' }

" cool light themes
Plug 'Verf/deepwhite.nvim'
Plug 'MetriC-DT/balance-theme.nvim'

" minimal style themes
Plug 'kkga/vim-envy'

" -- in_development --
Plug 'pechorin/any-jump.vim'
Plug 'pechorin/vim-leuven-theme'

" -- mini.* plugins
Plug 'echasnovski/mini.ai'       " additional text objects
Plug 'echasnovski/mini.surround' " change surroundings on fly
Plug 'echasnovski/mini.cursorword'

" -- ai shit
" Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

call plug#end()
