syntax on
set cindent
set nu
set ts=4
set sw=4
set et
set backspace=2
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>
:set mouse=a

" Plugin options
call plug#begin('~/.vim/plugged')

"General
Plug 'itchyny/lightline.vim'
Plug 'Townk/vim-autoclose'
Plug 'Lokaltog/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'wellle/targets.vim'
Plug 'mhinz/vim-startify'
Plug 'terryma/vim-multiple-cursors'
Plug 'yuttie/comfortable-motion.vim'
"Plug 'hsanson/vim-android'

"Code
Plug 'scrooloose/nerdcommenter'
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

"Language
Plug 'sheerun/vim-polyglot'

"Color scheme
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'rakr/vim-one'

" Add plugins to &runtimepath
call plug#end()

au BufNewFile,BufRead *.mpd set filetype=xml
au BufNewFile,BufRead Jenkinsfile set filetype=groovy

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set background=dark
let base16colorspace=256
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

" Json View
nmap =j :%!python -m json.tool<CR>

" highlight unnecessary whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night',
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

nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>

"Ack -> Ag
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"Tagbar
nmap <F8> :TagbarToggle<CR>

"Android
let g:android_sdk_path = '/Users/yicheng.liu/Library/Android/sdk'
