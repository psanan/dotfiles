"Vim-plug
"
" Obtain with
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" From vim, install with
"   :PlugInstall
"
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
call plug#end()

"YouCompleteMe
" Note: we don't set anything here to do otherwise, so if you want to
"       search header files for completions, you must type <c-Space>
let g:ycm_confirm_extra_conf = 0 " unsafe!
let g:ycm_global_ycm_extra_conf = "~/pdsrc/ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1

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
set softtabstop=2
set shiftwidth=2

" syntax highlighting and color scheme
syntax on
colorscheme solarized
set background=light
let fortran_free_source=1
set colorcolumn=81

" Highlight trailing whitespace
"highlight ExtraWhitespace ctermbg=grey guibg=red
"match ExtraWhitespace /\s\+$/

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

" Kill all trailing whitespace with F3 (careful)
map <F3> :%s/\s\+$//<CR>

" Default tags to PETSc ctags
set tags=$PETSC_DIR/CTAGS

" Shortcut to jump to tag, in new window
map <c-\>tt :vsp<CR><c-w><c-l><c-]>

" Shortcuts for working with PETSc
imap <c-\>pc PETSC_COMM_WORLD
imap <c-\>ch CHKERRQ(ierr);
imap <c-\>pf PetscErrorCode func()<CR>{<CR>  PetscErrorCode ierr;<CR><CR>PetscFunctionBeginUser;<CR><CR>PetscFunctionReturn(0);<CR><BS>}<CR>
imap <c-\>ff for (i=0; i<XXX; ++i)
imap <c-\>pp ierr = PetscPrintf(PETSC_COMM_WORLD,"---\n");CHKERRQ(ierr);

" Shortcuts for common templates making beamer slides
imap <c-\>fr \begin{frame}[fragile]<CR>\frametitle{}<CR><CR>\end{frame}<CR>
imap <c-\>ir \begin{itemize}<CR>\item<CR>\end{itemize}<CR>
imap <c-\>ls \begin{lstlisting}<CR><CR>\end{lstlisting}<CR>

" Larger text for MacVim
set gfn=Menlo:h14
