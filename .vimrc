if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/vimproc.vim', {
  \    'build' : {
  \      'windows' : 'tools\\update-dll-mingw',
  \      'cygwin' : 'make -f make_cygwin.mak',
  \      'mac' : 'make -f make_mac.mak',
  \      'linux' : 'make',
  \      'unix' : 'gmake',
  \    },
  \  }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'sorah/unite-ghq'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kana/vim-fakeclip.git'
NeoBundle 'othree/html5.vim.git'
NeoBundle 'hail2u/vim-css3-syntax.git'
NeoBundle 'fatih/vim-go'
NeoBundle 'mgaoshima/editorconfig-vim'
NeoBundle 'vim-scripts/BusyBee'
NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'goatslacker/mango.vim'
NeoBundle '29decibel/codeschool-vim-theme'
NeoBundle 'brendonrapp/smyck-vim'
NeoBundle 'altercation/vim-colors-solarized'
call neobundle#end()
filetype plugin indent on
NeoBundleCheck


syntax enable
colorscheme BusyBee


set notitle ttyfast hidden
set directory=/tmp backupdir=/tmp
set backspace=indent,eol,start
set number ruler nowrap
set wildmenu wildmode=list:longest
set laststatus=2
set statusline=\ #%n\ %<%f%m%r%q\ \ \ %c,%l%=
      \%{strlen(&fenc)?&fenc:'empty'}\ %{&ff}\ %{tolower(&ft)}
      \%{strlen(fugitive#statusline())?join(['\ ',fugitive#statusline()[5:][:-3]],'\ '):''}\ 
set cindent autoindent smartindent
set expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2 et
set ignorecase smartcase
set wrapscan hlsearch incsearch gdefault
set list listchars=tab:▸\ 
set shortmess+=I


"" gvim
if has('gui_running')
  if has('mac')
    "" Mac
    colorscheme jellybeans
    set guioptions=
    set visualbell t_vb=
    set guifont=Menlo:h14
    set linespace=2
    set transparency=8
  else
    if has('unix')
      "" Unix
      colorscheme torte
      set guioptions=
      set visualbell t_vb=
      set guifont=Ubuntu\ Mono\ h12
      set linespace=2
    else
      "" Windows
    endif
  endif
endif


hi Normal                                        ctermbg=NONE
hi NonText                                       ctermbg=NONE
hi LineNr                            ctermfg=242 ctermbg=NONE guifg=#555555 guibg=NONE
hi StatusLine   term=NONE cterm=NONE ctermfg=258 ctermbg=234  guifg=#e9e9e9 guibg=#333333 gui=NONE
hi StatusLineNC term=NONE cterm=NONE ctermfg=246 ctermbg=234  guifg=#777777 guibg=#333333 gui=NONE
hi VertSplit    term=NONE cterm=NONE ctermfg=242 ctermbg=NONE guifg=#555555 guibg=NONE


"" keymap
nmap j gj
nmap k gk
nmap n nzz
nmap N Nzz
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-j> 10jzz
nmap <C-k> 10kzz
imap <C-j> <Esc>
map <Esc><Esc> <Esc>:noh<CR>
nmap <C-]> :Unite -start-insert ghq<CR>
nmap <C-p> :Unite -start-insert file_rec/async<CR>


"" VimGrep時にcwindowを開く
autocmd QuickFixCmdPost *grep* cwindow


"" emmet-vim
let g:user_emmet_settings = { 'lang' : 'ja' }


"" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
let g:go_fmt_command = "goimports"


"" neocomplcache
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType go setlocal omnifunc=gocomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'


" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □ とか○ の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
