""" Plugins """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-plug.
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --clangd-completer' }
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/Tabular'  " Alignment (Try :Tab /=)
Plug 'tmhedberg/simpylfold'  " Python folding
Plug 'junegunn/fzf', { 'do': './install' }
Plug 'junegunn/fzf.vim'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

" YouCompleteMe
" Note: to search header files for completions, type <c-Space>
" Troubleshooting: Delete .vim/plugged/YouCompleteMe, :PlugInstall
let g:ycm_confirm_extra_conf = 0  "unsafe!
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

" https://github.com/vim-airline/vim-airline/issues/544
function! AirlineInit()
  " first define a new part for modified
  call airline#parts#define('modified', {
    \ 'raw': '%m',
    \ 'accent': 'red',
    \ })

  " then override the default layout for section c with your new part
  let g:airline_section_c = airline#section#create(['%<', '%f', 'modified', ' ', 'readonly'])
endfunction
autocmd VimEnter * call AirlineInit()

" Fzf
let g:fzf_command_prefix = 'Fzf'

" from :help fzf-vim-customization
command! -bang -nargs=* FzfGGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

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

" Allow the cursor to go where there's no char
set virtualedit=block

""" Appearance """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Line numbers
set number

" Syntax highlighting and color scheme
syntax on
colorscheme solarized
set background=light
let fortran_free_source=1

" Spellchecking highlighting
hi clear SpellBad
hi SpellBad cterm=bold ctermfg=white ctermbg=red
hi SpellBad gui=bold guifg=white guibg=red

" Color column in active window
set colorcolumn=81
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=81
    autocmd WinLeave * set colorcolumn=0
augroup END

""" Shortcuts """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unset the "last search pattern" register
nnoremap <CR> :noh<CR><CR>

" fzf
noremap <F1> :FzfFiles<CR>
noremap <F2> :FzfGGrep<CR>
noremap <F3> :FzfAg<CR>
noremap <F4> :FzfLines<CR>

" NERDTree
nnoremap <F5> :NERDTree<CR>

" Copy to system clipboard, if supported
noremap <leader>y "*y

" Jump to tag, in new window
nnoremap <leader>t :vsp<CR><c-w><c-l><c-]>

" Tagbar
nnoremap <F8> :TagbarToggle<CR>

" Kill all trailing whitespace (undo to leave highlighted)
nnoremap <leader>w :%s/\s\+$//<CR>

" Jump to next in location list, wrapping (for YouCompleteMe)
command Lnextwrap try | lnext | catch | lfirst | catch | endtry
nnoremap <F11> :Lnextwrap<CR>

" YouCompleteMe FixIt
nnoremap <F12> :YcmCompleter FixIt<CR>

" Move between windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Next/prev tab
nnoremap <TAB> gt
nnoremap <S-TAB> gT

" LaTeX
inoremap <c-\>c \begin{center}<CR>\end{center}<CR>
inoremap <c-\>f \begin{frame}[fragile]<CR>\frametitle{}<CR>\end{frame}<CR>
inoremap <c-\>i \begin{itemize}<CR>\item<CR>\end{itemize}<CR>
inoremap <c-\>g \begin{center}<CR>\includegraphics[width=\textwidth]{images/xxx.png}<CR>\end{center}<CR>
inoremap <c-\>s \begin{minipage}{0.49\textwidth}<CR>\end{minipage}<CR>\begin{minipage}{0.49\textwidth}<CR>\end{minipage}

" PETSc
inoremap <c-\>ch CHKERRQ(ierr);
inoremap <c-\>po PetscObjectComm((PetscObject)dm)
inoremap <c-\>pe SETERRQ(PETSC_COMM_WORLD,PETSC_ERR_SUP,"Not Implemented!");
inoremap <c-\>pp ierr = PetscPrintf(PETSC_COMM_WORLD,"xxx\n");CHKERRQ(ierr);
inoremap <c-\>pf PetscErrorCode XXXX()<CR>{<CR>PetscErrorCode ierr;<CR><CR>PetscFunctionBegin;<CR>PetscFunctionReturn(0);<CR>}<CR>

" Notes (PDSHub ID 3)
" Edit notes file for a given reference under the cursor
nnoremap <Leader>n :edit ~/work/notes/notes/<cword>.md <CR>

" Open filename under cursor with "open" (OS X), not pausing
nnoremap <Leader>go :!open <cWORD> <CR> <CR>

" use "open" (OS X) to open a pdf corresponding to the filename,
" in a particular location. This is for use with my notes system.
" The second <CR> means that you won't get to read error messages,
" but also won't have to press enter again to return to the file in vim
nnoremap <Leader>gf :execute '!open ~/work/ref/' . expand('%:t:r') . '.pdf' <CR> <CR>

" vimrc
nnoremap <Leader>v :tabedit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" BibTeX file (PDSHub ID 2)
nnoremap <Leader>b :tabedit ~/work/bib/pds.bib<CR>
