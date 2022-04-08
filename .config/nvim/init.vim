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
set smartcase
set undodir=~/.nvim/undodir
set undofile
set incsearch
set nohlsearch
"set clipboard+=unamedplus
set splitbelow splitright

call plug#begin()

Plug 'glepnir/dashboard-nvim' "Dashboard
Plug 'nvim-lua/telescope.nvim' "fuzzy finding
Plug 'nvim-lua/plenary.nvim' "dependency

Plug 'vim-airline/vim-airline' " Vim-Airline 
Plug 'preservim/nerdtree' " NerdTree
Plug 'ryanoasis/vim-devicons' " Developer Icons
Plug 'preservim/tagbar' " Tagbar for code navigation
Plug 'joshdick/onedark.vim' " One Dark theme
Plug 'morhetz/gruvbox' " gruvbox theme
Plug 'prettier/vim-prettier' " 
Plug 'jiangmiao/auto-pairs' " Autodoublebrackets like vscode
Plug 'alvan/vim-closetag' " Auto close HTML tags
Plug 'akinsho/bufferline.nvim' " Upper Bufferline
Plug 'ap/vim-css-color' " CSS Color Preview
Plug 'tc50cal/vim-terminal' " Vim Terminal
Plug 'norcalli/nvim-colorizer.lua' " hexcode bgcolor
Plug 'ap/vim-css-color' " vim css color 
Plug 'neoclide/coc.nvim'  " Auto Completion
Plug 'blindFS/vim-taskwarrior'
call plug#end()


"colorscheme onedark "using colorscheme toggle now
"colorscheme gruvbox

let g:mapleader="\<Space>"
let g:dashboard_default_executive ='telescope'

    }
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>


nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

