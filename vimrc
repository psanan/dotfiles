""" Plugins """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Vim-plug. Obtain and install with
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   :PlugInstall  (from Vim)
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' } " Code completion, syntax checking
Plug 'altercation/vim-colors-solarized'                                   " Colors
Plug 'scrooloose/nerdtree'                                                " Prettier folder navigation
Plug 'tpope/vim-fugitive'                                                 " Git tools
Plug 'ctrlpvim/ctrlp.vim'                                                 " Better searching
Plug 'majutsushi/tagbar'                                                  " Local source structure
call plug#end()

"YouCompleteMe
" Note: we don't set anything here to do otherwise, so if you want to
"       search header files for completions, you must type <c-Space>
" Troubleshooting: sometimes one needs to delete .vim/plugged/YouCompleteMe
" and re-run :PlugInstall
let g:ycm_confirm_extra_conf = 0                                          " unsafe!
let g:ycm_global_ycm_extra_conf = "~/pdsrc/ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_always_populate_location_list = 1                               " use :lne

""" Behavior """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable ex mode
nnoremap Q <nop>

" Turn on mouse scrolling/selecting (works in iTerm2)
:set mouse=a

" Mouse double left click to toggle folds
noremap <2-LeftMouse> za

" Backspace beyond current insert (probably a bad habit)
set backspace=indent,eol,start

" 2 space instead of tabs
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
set fdm=syntax
set foldlevelstart=99 " this seems like a hack

""" Appearance """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Line numbers and ruler
set number
set ruler

" Syntax highlighting and color scheme
syntax on
colorscheme solarized
set background=light
let fortran_free_source=1
set colorcolumn=81

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=grey guibg=red
match ExtraWhitespace /\s\+$/

" Use C syntax highlighting for .cl files
autocmd BufNewFile,BufRead *.cl set syntax=c

" Disable automatic multiline commenting
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Larger text for MacVim
set gfn=Menlo:h14

""" Shortcuts """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Unset the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Jump to tag, in new window
map <c-\>tt :vsp<CR><c-w><c-l><c-]>

" Kill all trailing whitespace
map <F3> :%s/\s\+$//<CR>

" Toggle Tagbar
map <F8> :TagbarToggle <CR>

" PETSCc
imap <c-\>pc PETSC_COMM_WORLD
imap <c-\>ch CHKERRQ(ierr);
imap <c-\>po PetscObjectComm((PetscObject)dm)
imap <c-\>pe SETERRQ(PetscObjectComm((PetscObject)dm),PETSC_ERR_SUP,"Not implemented");

" Beamer
imap <c-\>fr \begin{frame}[fragile]<CR>\frametitle{}<CR><CR>\end{frame}<CR>
imap <c-\>ir \begin{itemize}<CR>\item<CR>\end{itemize}<CR>
imap <c-\>ls \begin{lstlisting}<CR><CR>\end{lstlisting}<CR>
