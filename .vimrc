syntax on
set cindent
set nu
set rnu
set ts=4
set sw=4
set et
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>
nmap <C-UP> <C-W>+
nmap <C-DOWN> <C-W>-
nmap <D-RIGHT> <C-W>>
nmap <D-LEFT> <C-W><
set t_Co=256
set nowrap
set backspace=2
set guifont=Monaco:h14

set nocompatible
filetype off

"Vundle Settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'VundleVim/Vundle.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'taglist.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'Townk/vim-autoclose'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'YichengLiu/molokai'
Bundle 'Valloric/YouCompleteMe'
Bundle 'kien/ctrlp.vim'
Bundle 'nathanaelkane/vim-indent-guides'

call vundle#end()
filetype plugin indent on

colorscheme molokai

" vim-easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" nerdCommenter
let NERDSpaceDelims=1
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

" taglist
let Tlist_Use_Right_Window = 1

" Octave syntax
augroup filetypedetect
    au! BufRead,BufNewFile *.oct set filetype=octave
augroup END

" indent guides
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2

" lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ], [ 'ctrlpmark' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \ },
      \ 'component_function': {
      \   'fugitive': 'FugitiveHead',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ }

function! FugitiveHead()
  try
    if exists("*fugitive#head")
      let branch = fugitive#head()
      return strlen(branch) ? branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:ctrlp_show_hidden = 1
