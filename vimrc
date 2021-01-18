syntax on
set hlsearch 
hi Search ctermfg=Black 
hi Search ctermbg=Yellow
set statusline=%F
set paste
set background=dark
hi Special ctermfg=red " for query specific keywords
hi Underlined ctermfg=magenta cterm=bold " for local variables
set tags=tags;

" Vim Plugin manager from https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim'

Plug 'junegunn/limelight.vim'

call plug#end()

" When we Goyo we want to Limelight, simples
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" we need to set these to get limelight to work with our colour scheme
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Set Limelight by default, this highlights the current code block
autocmd! VimEnter * Limelight

" Set the tab settings at the end here to make sure they don't get overwritten by any plugins
set showmatch
set ruler
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
