syntax on
set showmatch
set ruler
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hlsearch 
hi Search ctermfg=Black 
hi Search ctermbg=Yellow
set statusline=%F
set paste

call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim'

Plug 'junegunn/limelight.vim'

call plug#end()

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

autocmd! VimEnter * Limelight
