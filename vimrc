"" vim-plug
call plug#begin()

  " utility ---------------------
  Plug 'kana/vim-fakeclip'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'banyan/recognize_charcode.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'mattn/emmet-vim'
  Plug 'pgdouyon/vim-evanesco'
  Plug 'editorconfig/editorconfig-vim'

  " git -------------------------
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " syntax ----------------------
  Plug 'othree/html5.vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'StanAngeloff/php.vim'

  " colorscheme -----------------
  Plug 'joshdick/onedark.vim'
  Plug 'noahfrederick/vim-noctu'

call plug#end()

filetype plugin indent on
syntax enable

try
  colorscheme onedark
  highlight Normal ctermbg=NONE
  highlight Statusline ctermbg=NONE
  highlight SpecialKey ctermfg=236
catch
endtry


"" settings
set title
set hidden
set confirm
set directory=/tmp
set backupdir=/tmp
set history=200
set mouse=a
set backspace=indent,eol,start
set ambiwidth=double
set number
set ruler
set laststatus=2
set nowrap
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
set wrapscan
set nrformats=
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set list listchars=tab:▸\ 
set wildmode=list:longest,full
set wildignore=*/tmp/*,*.so,*.swp,*.bak,*.min.*,*.map,*.jpg,*.png,*.gif
set pumheight=10

"" Auto Complete - http://io-fia.blogspot.jp/2012/11/vimvimrc.html
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap " . k . " " . k . "<C-N><C-P>"
endfor
imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"


"" Keymap
noremap <C-h> :bp<CR>
noremap <C-l> :bn<CR>
noremap j gj
noremap k gk
noremap m %
noremap  <C-k> <esc>
noremap! <C-k> <esc>


"" ctrlp.vim
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/](node_modules|build|dist|wp-admin|wp-include|vendors)|\.(git|hg|svn|DS_Store)$'


"" ============================================================================
""
"" Statusline - https://github.com/noahfrederick/dots/blob/master/vim/vimrc
""
"" ============================================================================

let &statusline  = '%6*%{exists("*ObsessionStatus")?ObsessionStatus(StatuslineProject(), StatuslineProject() . " (paused)"):""}'
let &statusline .= '%#StatusLineNC#%{exists("*ObsessionStatus")?ObsessionStatus("", "", StatuslineProject()):StatuslineProject()}'
let &statusline .= "%#StatusLineNC#%{StatuslineGit()}%*"
let &statusline .= "%* %f "
let &statusline .= '%1*%{&modified && !&readonly?"\*":""}%*'
let &statusline .= '%1*%{&modified && &readonly?"\*":""}%*'
let &statusline .= '%2*%{&modifiable?"":"\*"}%*'
let &statusline .= '%3*%{&readonly && &modifiable && !&modified?"\*":""}%*'
let &statusline .= "%="
let &statusline .= "%#StatusLineNC#%{StatuslineIndent()}%* "
let &statusline .= '%#StatuslineNC#%{(strlen(&fileencoding) && &fileencoding !=# &encoding)?&fileencoding." ":""}'
let &statusline .= '%{&fileformat!="unix"?" ".&fileformat." ":""}%*'
let &statusline .= '%{strlen(&filetype)?&filetype." ":""}'
let &statusline .= '%#Error#%{exists("*SyntasticStatuslineFlag")?SyntasticStatuslineFlag():""}'
let &statusline .= "%{StatuslineTrailingWhitespace()}%*"

function! StatuslineGit()
  if !exists('*fugitive#head')
    return ''
  endif
  let l:out = fugitive#head(8)
  if l:out !=# ''
    let l:out = ' @' . l:out
  endif
  return l:out
endfunction

function! StatuslineIndent()
  if !&modifiable
    return ''
  endif

  if &expandtab == 0 && &tabstop == 8
    " Sleuth.vim has detected mixed indentation
    return "!!"
  endif

  let l:symbol = &expandtab ? "\u2334" : "\u21E5"
  let l:amount = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
  return &expandtab ? repeat(l:symbol, l:amount) : l:symbol
endfunction

function! StatuslineProject()
  return getcwd() == $HOME ? "~" : fnamemodify(getcwd(), ':t')
endfunction

function! StatuslineTrailingWhitespace()
  if !exists("b:statusline_trailing_whitespace")
    if !&modifiable || search('\s\+$', 'nw') == 0
      let b:statusline_trailing_whitespace = ""
    else
      let b:statusline_trailing_whitespace = "  \u2334 "
    endif
  endif

  return b:statusline_trailing_whitespace
endfunction

augroup vimrc_statusline
  autocmd!
  autocmd CursorHold,BufWritePost * unlet! b:statusline_trailing_whitespace
augroup END
