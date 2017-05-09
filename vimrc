"Vim-plug
"
" Obtain with
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" From vim, install with
"   :PlugInstall
"
call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex'                                                      
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
call plug#end()

"YouCompleteMe (YCM)
let g:ycm_confirm_extra_conf = 0 " unsafe!
let g:ycm_global_ycm_extra_conf = "~/pdsrc/ycm_extra_conf.py"
let g:ycm_always_populate_location_list = 1 " use with :lne :lp

" Disable ex mode
nnoremap Q <nop>

" Turn on mouse scrolling/selecting (works in iTerm2)
:set mouse=a

" Mouse double left click to toggle folds
noremap <2-LeftMouse> za

" line numbers and ruler
set number
set ruler

" Backspace beyond current insert [probably a bad habit]
set backspace=indent,eol,start

" tabs instead of spaces, PETSc spacing [2 chars for tabs]
set expandtab
set tabstop=2
set shiftwidth=2

" syntax highlighting and color scheme
syntax on
colorscheme solarized
set background=dark
let fortran_free_source=1
set colorcolumn=80

" use C syntax highlighting for .cl files
autocmd BufNewFile,BufRead *.cl set syntax=c

" Disable automatic multiline commenting
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Smart case handling for searches
set ignorecase
set smartcase

" Automatic indentation
set autoindent

" Search while typing, highlight matches
set incsearch
set hlsearch

" Change tab completion to be bash-like
set wildmode=longest,list

"Unset the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Folding
set fdm=syntax
set foldlevelstart=99 " this seems like a hack

" Shortcuts for working with PETSc
imap <c-\>pc PETSC_COMM_WORLD
imap <c-\>ch CHKERRQ(ierr);
map  <c-\>pt :set tags=$PETSC_DIR/CTAGS<CR>

" jump to tag, in new window
map <c-\>tt :vsp<CR><c-w><c-l><c-]>

" Shortcuts for common templates making beamer slides
imap <c-\>fr \begin{frame}[fragile]<CR>\frametitle{}<CR><CR>\end{frame}<CR>
imap <c-\>ir \begin{itemize}<CR>\item<CR>\end{itemize}<CR>
imap <c-\>ls \begin{lstlisting}<CR><CR>\end{lstlisting}<CR>
