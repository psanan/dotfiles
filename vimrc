""" Plugins """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-plug. Obtain and install with
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   :PlugInstall  (from Vim)
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' } " Code completion, syntax checking
Plug 'altercation/vim-colors-solarized'                                   " Colors
Plug 'scrooloose/nerdtree'                                                " Folder navigation
Plug 'tpope/vim-fugitive'                                                 " Git tools
Plug 'majutsushi/tagbar'                                                  " Local source structure
Plug 'vim-airline/vim-airline'                                            " Status bar
Plug 'vim-airline/vim-airline-themes'                                     " Themes for status bar
Plug 'git@bitbucket.org:psanan/stice-gg'                                  " Wrapper for git grep
Plug 'godlygeek/Tabular'                                                  " Alignment helper (Try :Tab /=)
Plug 'tmhedberg/simpylfold'                                               " Python folding
call plug#end()

" YouCompleteMe
" Note: if you want to search header files for completions, type <c-Space>
" Troubleshooting: sometimes one needs to delete .vim/plugged/YouCompleteMe
"                  and re-run :PlugInstall
let g:ycm_confirm_extra_conf = 0                                          " unsafe!
let g:ycm_global_ycm_extra_conf = "~/util/rc/ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1

" Airline
let g:airline_theme='solarized'
let g:airline_solarized_bg='light'
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'c'  : 'C',
    \ 'i'  : 'I',
    \ 'ic' : 'I',
    \ 'ix' : 'I',
    \ 'n'  : 'N',
    \ 'ni' : 'N',
    \ 'no' : 'N',
    \ 'R'  : 'R',
    \ 'Rv' : 'R',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ 't'  : 'T',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ }

""" Behavior """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable ex mode
nnoremap Q <nop>

" Turn on mouse scrolling/selecting (works in iTerm2)
:set mouse=a

" Backspace beyond current insert (probably a bad habit)
set backspace=indent,eol,start

" 2 spaces instead of tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Smart case handling for searches
set ignorecase
set smartcase

" Indentation
set autoindent

" Search while typing, highlight matches
set incsearch
set hlsearch

" Change tab completion to be bash-like
set wildmode=longest,list

" Default tags to PETSc ctags
set tags=$PETSC_DIR/CTAGS

" Folding
let fortran_fold=1
let fortran_fold_conditionals=1
set fdm=syntax
set foldlevelstart=99 " this seems like a hack

" Disable automatic multiline commenting
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

""" Appearance """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Line numbers
set number

" Syntax highlighting and color scheme
syntax on
colorscheme solarized
set background=light
let fortran_free_source=1

" Use C syntax highlighting for additional extensions
autocmd BufNewFile,BufRead *.cl   set syntax=c
autocmd BufNewFile,BufRead *.cucl set syntax=c

" Color column in active window
set colorcolumn=81
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=81
    autocmd WinLeave * set colorcolumn=0
augroup END

" Quiet!
set noerrorbells

""" Shortcuts """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unset the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Jump to tag, in new window
map <c-\>tt :vsp<CR><c-w><c-l><c-]>

" Search for trailing whitespace (highlights with "set hlsearch")
map <F4> :/\s\+$<CR>

" Kill all trailing whitespace
map <F3> :%s/\s\+$//<CR>

" NERDTree
map <F7> :NERDTree <CR>

" Tagbar
map <F8> :TagbarToggle <CR>

" Use control + hjkl to move between windows
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l

" Use tab/shift-tab to move to next/prev tab
nnoremap <TAB> gt
nnoremap <S-TAB> gT

" Mouse double left click to toggle folds
noremap <2-LeftMouse> za

" PETSc
imap <c-\>ch CHKERRQ(ierr);
imap <c-\>po PetscObjectComm((PetscObject)dm)

" use "open" (OS X) to open a filename under the cursor
" The second <CR> means that you won't get to read error messages,
" but also won't have to press enter again to return to the file in vim
nnoremap Gf :!open <cWORD> <CR> <CR>
