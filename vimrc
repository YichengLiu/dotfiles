syntax on
set cindent
set nu
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
set guifont=Monaco\ for\ Powerline:h14

set nocompatible
filetype off

"Vundle Settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'VundleVim/Vundle.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'Townk/vim-autoclose'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Plugin 'rking/ag.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'elzr/vim-json'
Plugin 'wellle/targets.vim'
Plugin 'mhinz/vim-startify'

"Code
Bundle 'scrooloose/nerdcommenter'
Bundle 'Valloric/YouCompleteMe'
Bundle 'airblade/vim-gitgutter'
Bundle 'taglist.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'

"Color scheme
Bundle 'YichengLiu/molokai'
Bundle 'morhetz/gruvbox'
Bundle 'altercation/vim-colors-solarized'
Bundle 'chriskempson/base16-vim'

call vundle#end()
filetype plugin indent on

colorscheme base16-ocean

" vim-easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" nerdCommenter
let NERDSpaceDelims=1
nmap <C-_> <leader>cc
let NERDCompactSexyComs=1

" vim-autoclose
let g:AutoCloseExpandEnterOn = "{"

" nerdTree
nmap <F6> :NERDTreeToggle<RETURN>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Ack
nmap <C-S-F> :Ack

" Json View
nmap =j :%!python -m json.tool<CR>

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
      \ 'colorscheme': 'solarized_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ], [ 'ctrlpmark' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ }

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
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

"startify
let g:startify_custom_header =
      \ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['','']

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
