set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" More intelligent line numbers
Plugin 'myusuf3/numbers.vim'
" Status bar with useful info
Plugin 'vim-airline/vim-airline'
" in-editor linting
Plugin 'vim-syntastic/syntastic'
" Easier commenting out lines
Plugin 'scrooloose/nerdcommenter'
" Easier directory navigation from within vim
Plugin 'scrooloose/nerdtree'
" Display git status inline on directory tree
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Display git status of specific lines within vim
Plugin 'airblade/vim-gitgutter'
" yaml syntax highlighting (mediocre, tbh, but the best I could find)
Plugin 'chase/vim-ansible-yaml'
" Enhanced python syntax highlighting
Plugin 'vim-python/python-syntax'
" Repeat motions with counts
Plugin 'Houl/repmo-vim'
" Jinja2 syntax highlighter
Plugin 'Glench/Vim-Jinja2-Syntax'
" git wrapper for vim
Plugin 'tpope/vim-fugitive'
" Python formatter
Plugin 'ambv/black'
" Python documetation
Plugin 'davidhalter/jedi-vim'
" Tmux splits
Plugin 'christoomey/vim-tmux-navigator'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" set laststatus=2
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:python_highlight_all = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntanstic_auto_jump = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers = ['pylint', 'mypy']
let g:syntastic_python_mypy_args = "--ignore-missing-imports --no-strict-optional"
let g:syntastic_shell_checkers = ['shellcheck']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_rst_checkers = ['sphinx']

" Toggle location list. Super useful for syntastic
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

" nnoremap <Leader>e :call ToggleErrors()<Enter>

" NERDTree settings
" Open NERDTree when opening vim
"autocmd vimenter * NERDTree
" Sane toggle key
nnoremap <Leader>f :NERDTreeToggle<Enter>
" Close NERDTree when opening a file
" let NERDTreeQuitOnOpen = 1
" Disable help message
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

set colorcolumn=73,89
highlight ColorColumn ctermbg=0 guibg=lightgrey
set nowrap
set sidescroll=1

" I literally never want an indent to be anything other than 4 spaces
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
set softtabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" My white cursor shows up poorly on a bright yellow background
set hlsearch
hi Search ctermbg=DarkBlue
hi Search ctermfg=LightYellow

"Make nerdtree open splits to the right
set splitright

"Save and close buffer
command Wbd write|bdelete

"repmo doesn't have default mappings :(
" map a motion and its reverse motion:
:noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
:noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l

" if you like `:noremap j gj', you can keep that:
:map <expr> j repmo#Key('gj', 'gk')|sunmap j
:map <expr> k repmo#Key('gk', 'gj')|sunmap k

" repeat the last [count]motion or the last zap-key:
:map <expr> ; repmo#LastKey(';')|sunmap ;
:map <expr> , repmo#LastRevKey(',')|sunmap ,

" add these mappings when repeating with `;' or `,':
:noremap <expr> f repmo#ZapKey('f')|sunmap f
:noremap <expr> F repmo#ZapKey('F')|sunmap F
:noremap <expr> t repmo#ZapKey('t')|sunmap t
:noremap <expr> T repmo#ZapKey('T')|sunmap T

"With argument, you can make `f` remember the count (same for `F`, `t` and `T`):
:noremap <expr> f repmo#ZapKey('f', 1)|sunmap f

"Scroll commands work too:
:noremap <expr> <C-E> repmo#SelfKey('<C-E>', '<C-Y>')
:noremap <expr> <C-Y> repmo#SelfKey('<C-Y>', '<C-E>')

"Alternative repetition keys (also working in addition to `;` and `,`):
" repeat the last [count]motion:
" :map <expr> <Space> repmo#LastKey('')|sunmap <Space>
" :map <expr> <BS>    repmo#LastRevKey('')|sunmap <BS>

"If non-zero, a repetition key like `;` only repeats the last motion for
"which a count was given.  This used to be the only available option.  
"If zero, `;` repeats any last motion, this is the new default!
:let g:repmo_require_count = 1

" Turn off autocomplete
" let g:jedi#completions_enabled = 0
" Have jedi use splits
let g:jedi#use_splits_not_buffers = "right"
" Don't show call signatures
" let g:jedi#show_call_signatures = "0"
" Don't autocomplete imports
" let g:jedi#smart_auto_mappings = 0

" Prevent bad autotabbing
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

" tmux colors
set background=dark
set t_Co=256

" airline slow insert to normal
set ttimeoutlen=10

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Allows buffers to be hidden if you've modified a buffer
set hidden

noremap <Leader>- :split<cr>
noremap <Leader><Bar> :vsplit<cr>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1 

" To open a new empty buffer
nmap <leader>t :enew<cr>

" Open last buffer
nnoremap <BS> <C-^>

" Move to the next buffer
nnoremap <RIGHT> :bnext<CR>
nnoremap <LEFT> :bprev<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
