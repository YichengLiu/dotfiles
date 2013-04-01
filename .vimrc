syntax on
set cindent
set rnu
set ts=4
set sw=4
set et
nmap <F7> <ESC>:Tlist<RETURN>
nmap <C-F5> <ESC>:ConqueTermSplit bash<RETURN><ESC>:resize 10<RETURN>i
nmap <C-E><C-I> <ESC>:JavaImport<RETURN>
nmap <F3> <ESC>\be
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>
nmap <C-UP> <C-W>+
nmap <C-DOWN> <C-W>-
nmap <C-RIGHT> <C-W>>
nmap <C-LEFT> <C-W><
set t_Co=256
set nowrap

set nocompatible
filetype off

"Vundle Settings
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline.git'
Bundle 'dhazel/conque-term'
"Bundle 'CSApprox'
Bundle 'taglist.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-fugitive'
Bundle 'bufexplorer.zip'
Bundle 'SirVer/ultisnips'
Bundle 'humiaozuzu/fcitx-status'
Bundle 'Townk/vim-autoclose'
" Bundle 'jiangmiao/auto-pairs'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'YichengLiu/molokai'

filetype plugin indent on

colorscheme molokai

let NERDSpaceDelims=1
" nmap <C-_> :NERDComToggleComment<cr>
nmap <C-_> <leader>cc
let NERDCompactSexyComs=1

" nerdTree
nmap <F6> <ESC>:NERDTreeToggle<RETURN><C-L>

" highlight unnecessary whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" powerline
set laststatus=2
let g:Powerline_symbols = 'fancy'

" taglist
let Tlist_Use_Right_Window = 1

" eclim
set completeopt-=preview "let eclim do not show the preview window when complete

" superTab
let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "<C-X><C-U>"
