""" Plugins """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-plug.
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'godlygeek/Tabular'
Plug 'JuliaLang/julia-vim'
Plug 'junegunn/fzf', { 'do': './install' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'mindriot101/vim-yapf'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clangd-completer' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Valloric/YouCompleteMe
" Note: type g:ycm_key_invoke_completion to see top-level completions
" Troubleshooting: Delete .vim/plugged/YouCompleteMe, :PlugInstall
let g:ycm_global_ycm_extra_conf = "~/util/dotfiles/ycm_extra_conf.py"
let g:ycm_extra_conf_globlist = "~/util/dotfiles/ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_invoke_completion = '<C-b>'

" scrooloose/nerdtree
let NERDTreeShowHidden = 1

" vim-airline/vim-airline
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'light'

" Make unsaved marker more prominent
" source: https://github.com/vim-airline/vim-airline/issues/544
function! AirlineInit()
  call airline#parts#define('modified', {
    \ 'raw': '%m%m%m%m%m%m',
    \ 'accent': 'red',
    \ })
  let g:airline_section_c = airline#section#create(['%<', '%f', 'modified', ' ', 'readonly'])
endfunction
autocmd VimEnter * call AirlineInit()

" junegunn/fzf.vim
let g:fzf_command_prefix = 'Fzf'

" :help fzf-vim-customization
command! -bang -nargs=* FzfGGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" kdheepak/JuliaFormatter.vim
let g:JuliaFormatter_options = {
        \ 'style' : 'blue',
        \ }

" nvie/vim-flake8
autocmd FileType python map <buffer> <F11> :call flake8#Flake8()<CR>


""" Behavior """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable ex mode
nnoremap Q <nop>

" Turn on mouse scrolling/selecting
set mouse=a

" Backspace beyond current insert (probably a bad habit)
set backspace=indent,eol,start

" 2 spaces instead of tabs
function SetTab(width)
  let &tabstop=a:width
  let &softtabstop=a:width
  let &shiftwidth=a:width
endfunction
call SetTab(2)
set expandtab

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

" Folding
let fortran_fold=1
let fortran_fold_conditionals=1
set fdm=syntax
set foldlevelstart=99

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

" Spellchecking highlighting
hi clear SpellBad
hi SpellBad cterm=bold ctermfg=white ctermbg=red
hi SpellBad gui=bold guifg=white guibg=red

" Color column in active window
set colorcolumn=81,101
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=81,101
    autocmd WinLeave * set colorcolumn=0
augroup END


""" Shortcuts """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fzf
noremap <F1> :FzfFiles<CR>
noremap <F2> :FzfGGrep<CR>
noremap <F3> :FzfAg<CR>
noremap <F4> :FzfLines<CR>

" Git grep for word under cursor
noremap <Leader>g :FzfGGrep <c-r><c-w> <CR>

" NERDTree
nnoremap <F5> :NERDTreeToggle<CR>

" Yapf
noremap <F6> :Yapf --style=google<CR>

" Toggle paste mode
function! TogglePaste()
    if(&paste == 0)
        set paste
    else
        set nopaste
    endif
endfunction
map <F7> :call TogglePaste()<CR>

" Tagbar
nnoremap <F8> :TagbarToggle<CR>

" Julia format
noremap <F10> :JuliaFormatterFormat<CR>

" <F11> mapped to above by a non-standard approach suggested by nvie/vim-flake8

" Unset the "last search pattern" register
nnoremap <CR> :noh<CR><CR>

" Copy to system clipboard, if supported
noremap <leader>y "+y

" Paste from last deliberate yank (no deleted text)
noremap <leader>p "0p

" Kill all trailing whitespace (undo to leave highlighted)
nnoremap <leader>w :%s/\s\+$//<CR>

" Convert all tabs to 2 spaces
nnoremap <leader>t :%s/\t/  /g<CR>

" Move between windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Next/prev tab
nnoremap <TAB> gt
nnoremap <S-TAB> gT

" Notes (PDSHub ID 3)
" Edit notes file for a given reference under the cursor
nnoremap <Leader>n :edit ~/notes/notes/<cword>.md <CR>

" Open filename under cursor with "open" (OS X), not pausing
nnoremap <Leader>go :!open <cWORD> <CR> <CR>

" use "open" (OS X) to open a PDF corresponding to the filename,
" in a particular location. This is for use with my notes system.
" The second <CR> means that you won't get to read error messages,
" but also won't have to press enter again to return to the file in vim
nnoremap <Leader>gf :execute '!open ~/work/ref/' . expand('%:t:r') . '.pdf' <CR> <CR>

" vimrc
nnoremap <Leader>v :tabedit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" BibTeX file (PDSHub ID 2)
nnoremap <Leader>b :tabedit ~/academic/bib/pds.bib<CR>

" Set to 4-space indentation
nnoremap <Leader>f :call SetTab(4)<CR>

" PETSc
inoremap <c-\>ch PetscCall();<ESC>hi
inoremap <c-\>po PetscObjectComm((PetscObject)dm)
inoremap <c-\>pe SETERRQ(PETSC_COMM_WORLD,PETSC_ERR_SUP,"Not Implemented!");
inoremap <c-\>pp ierr = PetscPrintf(PETSC_COMM_WORLD,"xxx\n");CHKERRQ(ierr);
inoremap <c-\>pf PetscErrorCode XXXX()<CR>{<CR>PetscErrorCode ierr;<CR><CR>PetscFunctionBegin;<CR>PetscFunctionReturn(0);<CR>}<CR>

" Emoji for Todo lists

" Check mark button = "done"
inoremap <c-\>dd <c-v>U2705<ESC>

" Cross mark = "wontdo"
inoremap <c-\>xx <c-v>U274C<ESC>

" Counterclocwise arrows = "progress but not done"
inoremap <c-\>pp <c-v>U1F504<ESC>
