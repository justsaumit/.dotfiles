set number
set relativenumber
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set ignorecase
set mouse=a
set hidden
set smartcase
set undodir=~/.nvim/undodir
set undofile
set incsearch
set nohlsearch
"set clipboard+=unamedplus
set splitbelow splitright

call plug#begin()

Plug 'glepnir/dashboard-nvim' "For awesome e-mac like dashboard
Plug 'nvim-lua/telescope.nvim' "fuzzy finding
Plug 'nvim-lua/plenary.nvim' " Dashboardutilities
Plug 'nvim-lua/popup.nvim' "
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

Plug 'vim-airline/vim-airline' " Vim-Airline
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Auto Completion
"Plug 'ryanoasis/vim-devicons' " Developer Icons

Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'preservim/tagbar' " Tagbar for code navigation

Plug 'folke/which-key.nvim'

Plug 'joshdick/onedark.vim' " One Dark theme
Plug 'morhetz/gruvbox' " gruvbox theme
Plug 'arcticicestudio/nord-vim' "nord theme
Plug 'folke/tokyonight.nvim'   "tokyonight theme
Plug 'tiagovla/tokyodark.nvim' "tokyodark theme

Plug 'prettier/vim-prettier' " 
Plug 'jiangmiao/auto-pairs' " Autodoublebrackets like vscode
Plug 'alvan/vim-closetag' " Auto close HTML tags
Plug 'tc50cal/vim-terminal' " Vim Terminal
Plug 'farmergreg/vim-lastplace' " Remembers-last edit-position
Plug 'ap/vim-css-color' " CSS Color Preview

Plug 'norcalli/nvim-colorizer.lua' " hexcode bgcolor
Plug 'ap/vim-css-color' " vim css color 
Plug 'blindFS/vim-taskwarrior'
call plug#end()


let g:mapleader="\<Space>"
let g:dashboard_default_executive ='telescope'



nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :Telescope find_files hidden=true<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

  let g:dashboard_custom_header = [
  	 \ '',
        \ '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆         ',
        \ '   ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
        \ '         ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
        \ '          ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
        \ '         ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
        \ '  ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
        \ ' ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
        \ '⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
        \ '⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
        \ '     ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
        \ '      ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
        \ '',
        \ ]

"nnoremap <C-f> :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
"nmap <F8> :TagbarToggle<CR>
"let NERDTreeShowHidden=1


"setup function
"set termguicolors
lua << EOF
require'nvim-tree'.setup {}
require("bufferline").setup{}
require("which-key").setup {
    
  }
EOF

"nvim-tree config

let g:nvim_tree_auto_close = 1
let g:nvim_tree_indent_markers = 1 
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1 
let g:nvim_tree_root_folder_modifier = ':~'
let g:nvim_tree_symlink_arrow = ' >> '
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }

let g:nvim_tree_icons = {
    \ 'default': "",
    \ 'symlink': "",
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>tf :NvimTreeFindFile<CR>


"Bufferline config

nnoremap <C-C-i> :BufferLineCycleNext<CR> "Ctrl+Tab
nnoremap <S-TAB> :BufferLineCyclePrev<CR> "Ctrl+Shift
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

"Which key config

"vim.g.mapleader = ' '
"local map = vim.api.nvim_set_keymap
map('n', '<C-h>', '<C-w>h', {nnoremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {nnoremap = true, silent = false})
map('n', '<C-j>', '<C-w>j', {nnoremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {nnoremap = true, silent = false})
