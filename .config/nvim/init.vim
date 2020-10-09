"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / | | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

" Fish doesn't play all that well with others
set shell=/bin/bash

" ==============================================================================
" PLUGINS
" ==============================================================================

call plug#begin(stdpath('data') . '/plugged')

" -- FILE / BUFFER MANAGEMENT --------------------------------------------------

" Command-line fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" EditorConfig plugin for Vim
Plug 'editorconfig/editorconfig-vim'

" -- COMPLETION ----------------------------------------------------------------

" Intellisense engine for Vim8 & Neovim
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" -- GIT -----------------------------------------------------------------------

" Show Git diff in the gutter and stages/undoes hunks
Plug 'airblade/vim-gitgutter'

" -- THEME / INTERFACE ---------------------------------------------------------

" Base16 for Vim
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" -- FILETYPES -----------------------------------------------------------------

Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'dag/vim-fish'
Plug 'neovimhaskell/haskell-vim'

" -- MISC ----------------------------------------------------------------------

Plug 'ciaranm/securemodelines'

call plug#end()

" ==============================================================================
" GENERAL
" ==============================================================================

if has("autocmd")
    filetype plugin indent on
    "           │     │    └──── Enable file type detection
    "           │     └───────── Enable loading of indent file
    "           └─────────────── Enable loading of plugin files
endif

set encoding=utf-8              " ┐
set fileencoding=utf-8          " │ Set encoding to utf-8
set termencoding=utf-8          " ┘

set langmenu=en_US              " ┐
let $LANG='en_US'               " │ Set language to
source $VIMRUNTIME/delmenu.vim  " │ English US
source $VIMRUNTIME/menu.vim     " ┘

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ==============================================================================
" OPTIONS
" ==============================================================================

" Get syntax
syntax on

let mapleader="\<Space>"        " Remap Leader to <Space>

set nocompatible                " Use Vim features, not Vi
set fileformats=unix,dos,mac    " Use Unix as the standard file type

set mouse=a                     " Enable mouse
set mousehide                   " Hide the mouse cursor while typing

set backspace=eol,start,indent  " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l          " Allow backspace and cursor keys to cross line boundaries

set showcmd                     " Show commands in status line
set noshowmode                  " Hide modes from the statusline

set ruler                       " Show current line and column position in file
set number                      " Show current line in the gutter
set relativenumber              " Display relative line numbers
" set cursorline                " Highlight current line

set lazyredraw                  " Don't redraw while executing macros
set synmaxcol=500               " Highlight syntax up to column 500
set t_ut=                       " Improve screen clearing by using the background color
set ttyfast                     " Faster redrawing

set shortmess=atOI              " No help Uganda information
set title                       " Show file title in terminal tab
set titlestring=%f%(\ %M%)%(\ %a%)
set fillchars+=vert:│           " Change vertical split character to │

set diffopt+=vertical           " Prefer vertical orientation for diffs

set clipboard=unnamed           " ┐
if has("unnamedplus")           " │ Use the system clipboard
  set clipboard+=unnamedplus    " │ as the default register
endif                           " ┘

set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line

" ==============================================================================
" COLORS
" ==============================================================================

" Base16 colors provided by base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set background=dark

" Italicised comments and attributes
highlight htmlArg gui=italic
highlight htmlArg cterm=italic
highlight Comment gui=italic
highlight Comment cterm=italic
highlight jsxAttrib gui=italic
highlight jsxAttrib cterm=italic

highlight CursorLineNr ctermfg=74

" ==============================================================================
" FILETYPES
" ==============================================================================

" Quickfix
if has("autocmd")
  autocmd FileType qf setlocal norelativenumber colorcolumn=
endif

" Gitcommit
if has("autocmd")
  " Force the cursor onto a new line after 72 characters and color the 51st colomn (for titles)
  autocmd FileType gitcommit set textwidth=72 colorcolumn+=51
  " Spell-check git commit
  autocmd FileType gitcommit setlocal spell
endif

"LaTeX
let g:tex_flavor = 'latex'

" ==============================================================================
" UI
" ==============================================================================

" Turn on the WiLd menu
set wildmenu

" Autocomplete as much as you can
set wildmode=longest:list,full

" Don’t offer to open certain files/directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Version control
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png    " Binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " Compiled object files
set wildignore+=*.spl                            " Compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pdf,*.psd
set wildignore+=*.map,*.min.css

set colorcolumn=81,82           " Limit line-length to 80 columns
                                " by highlighting col 81 and 82

set list
set listchars=tab:▸\            " ┐
set listchars+=trail:·          " │ Use custom symbols to
set listchars+=extends:»        " │ represent invisible characters
set listchars+=precedes:«       " │
set listchars+=nbsp:¬           " │
" set showbreak=↪               " │
set showbreak=￫                 " ┘

set scrolloff=5                " Minumum lines to keep above and below
                               " from the cursor
set sidescroll=1               " Scroll sideways a character at a time,
                               " rather than a screen at a time
set sidescrolloff=5            " Minumum lines to keep left and right from the cursor

set report=0                   " Always report changed lines

set splitright                 " Open new vsplit windows to the right of the current one
set splitbelow                 " Open new split windows to the bottom of the current one

set noerrorbells               " ┐
set novisualbell               " │ No annoying sound
set t_vb=                      " │ on errors
set tm=500                     " ┘

au VimResized * :wincmd =      " Resize splits when the window is resized

set magic                      " For regular expressions turn magic on

set showmatch                  " Show matching brackets when text indicator
                               " is over them

set nrformats-=octal           " Interpret numbers with leading zeroes as
                               " decimal, not octal
set iskeyword+=-               " Makes foo-bar considered one word

set display=lastline           " Show as much as possible of the last line

set spelllang=en               " Set spelling language

" ==============================================================================
" FILES, BACKUPS AND UNDO
" ==============================================================================

set autoread                    " Reload files modified outside of Vim
set autowrite                   " Automatically write when leaving a modified buffer

set nobackup                    " ┐
set noswapfile                  " │ <3 Git
set nowritebackup               " ┘

set undodir=~/.vimdid/          " ┐ Permanent
set undofile                    " ┘ undo

" set hidden                    " Allow buffer switching without saving

" ==============================================================================
" SEARCH
" ==============================================================================

set ignorecase                 " Case insensitive search
set smartcase                  " ... except if we input a capital letter
set hlsearch                   " Highlight search terms
set hlsearch                   " Find as you type search

" `<Leader>+n` -- Disable highlight
nmap <silent> <Leader>n :silent :nohlsearch<CR>

" ==============================================================================
" TABS, SPACES, INDENTS AND WRAPPING
" ==============================================================================

set wrap                       " Wrap lines
set linebreak                  " Break at 'breakat' characters
set nojoinspaces               " No extra spaces when joining lines
set autoindent                 " Indent at the same level of the previous line
set expandtab                  " Use spaces instead of tabs
set smarttab                   " Smart tab
set smartindent                " Automatically indent lines after opening brackets

set softtabstop=2              " ┐
set shiftwidth=2               " │ 1 tab == 2 spaces
set tabstop=2                  " ┘

" ==============================================================================
" KEYBOARD SHORTCUTS
" ==============================================================================

" Remap : to ; to strip off two full keystrokes from almost every Vim command
nnoremap ; :

" No arrow keys -- Force yourself to use the home row
" nnoremap <Up> <nop>
" nnoremap <Down> <nop>
" inoremap <Up> <nop>
" inoremap <Down> <nop>
" inoremap <Left> <nop>
" inoremap <Right> <nop>

" Treat long lines as break lines
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" `<Leader>+q` -- Close the current window
nnoremap <Leader>q :q<CR>

" `Ctrl+q` -- Close the current window
nnoremap <C-q> :q<CR>
vnoremap <C-q> :q<CR>

" `Ctrl+c / Ctrl+j` -- Map to Escape
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" `jj` -- Map to Escape
inoremap jj <Esc>

" `H` -- Go to the beginning of a line
noremap H ^

" `L` -- Go to the end of a line
noremap L $

" `vv` -- Highlight just the text (i.e. no indents) in a line
nnoremap vv ^vg_

" ==============================================================================
" PLUGIN SETTINGS
" ==============================================================================

let plugin_settings='~/.config/nvim/config.d'
for fpath in split(globpath(plugin_settings, '*.vim'), '\n')
  exe 'source' fpath
endfor
