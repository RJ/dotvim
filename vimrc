filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin indent on
set nocompatible
set modelines=0

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Basic options
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set wildignore+=*.beam,*.dump,*~,*.o,.git,*.png,*.jpg,*.gif
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set relativenumber
set laststatus=2
set undofile

" Backups
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

" Leader
let mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
map <leader><space> :let @/=''<cr>
runtime macros/matchit.vim
nmap <tab> %
vmap <tab> %

" Soft/hard wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬

" Color scheme (terminal)
syntax on
set background=dark
colorscheme delek

" NERD Tree
map <F2> :NERDTreeToggle<cr>
let NERDTreeIgnore=['.*\.beam$', '.*\.dump$', '.*~$', '\..*$']

" Use the damn hjkl keys
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>

" And make them fucking work, too.
nnoremap j gj
nnoremap k gk

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l

" Folding
set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
au BufNewFile,BufRead *.html map <leader>ft Vatzf

"function! MyFoldText()
"    let line = getline(v:foldstart)

"    let nucolwidth = &fdc + &number * &numberwidth
"    let windowwidth = winwidth(0) - nucolwidth - 3
"    let foldedlinecount = v:foldend - v:foldstart

"    " expand tabs into spaces
"    let onetab = strpart('          ', 0, &tabstop)
"    let line = substitute(line, '\t', onetab, 'g')

"    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
"    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
"    return line . '‚Ä¶' . repeat(" ",fillcharcount) . foldedlinecount . '‚Ä¶' . ' '
"endfunction
"set foldtext=MyFoldText()

" Fuck you, help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Various syntax stuff
au BufNewFile,BufRead *.escript set filetype=erlang
au BufNewFile,BufRead *.app.src set filetype=erlang
au BufNewFile,BufRead *.app     set filetype=erlang
au BufNewFile,BufRead *.appup   set filetype=erlang

au BufNewFile,BufRead *.m*down set filetype=markdown
au BufNewFile,BufRead *.m*down nnoremap <leader>1 yypVr=
au BufNewFile,BufRead *.m*down nnoremap <leader>2 yypVr-
au BufNewFile,BufRead *.m*down nnoremap <leader>3 I### <ESC>

" Sort CSS
map <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:let @/=''<CR>

" Clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Exuberant ctags!
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>
map <F5> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude='@.ctagsignore' .<cr>

" Ack
map <leader>a :Ack 

" Command-T plugin
map <leader>t :CommandT<cr>

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
nnoremap <silent> <leader>y :YRShow<cr>

" Formatting, TextMate-style
map <leader>q gqip

nmap <leader>m :make<cr>

" Google's JSLint
"nmap <silent> <leader>ff :QFix<cr>
"nmap <leader>fn :cn<cr>
"nmap <leader>fp :cp<cr>
"
"command -bang -nargs=? QFix call QFixToggle(<bang>0)
"function! QFixToggle(forced)
"  if exists("g:qfix_win") && a:forced == 0
"    cclose
"    unlet g:qfix_win
"  else
"    copen 10
"    let g:qfix_win = bufnr("$")
"  endif
"endfunction


" TODO: Put this in filetype-specific files
au BufNewFile,BufRead *.less set foldmethod=marker
au BufNewFile,BufRead *.less set foldmarker={,}
au BufNewFile,BufRead *.less set nocursorline
"au BufRead,BufNewFile /etc/nginx/sites-available/* set ft=nginx
"au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx

" Easier linewise reselection
map <leader>v V`]

" HTML tag closing
inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<cr>a

" Faster Esc
"inoremap <Esc> <nop>
"inoremap jj <ESC>

" Scratch
nmap <leader><tab> :Sscratch<cr><C-W>x<C-j>:resize 15<cr>

" Diff
" nmap <leader>d :!hg diff %<cr>

" Rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>

" Edit .vimrc
"nmap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nmap <leader>ev :e $MYVIMRC<cr>
" Reload .vimrc
nmap <leader>rv :source $MYVIMRC<cr>
":filetype detect<cr>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Easy filetype switching
nnoremap _dt :set ft=htmldjango<CR>
nnoremap _jt :set ft=htmljinja<CR>

" VCS Stuff
let VCSCommandMapPrefix = "<leader>h"

" Disable useless HTML5 junk
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" Shouldn't need shift
nnoremap ; :

" Save when losing focus
"au FocusLost * :wa

" Stop it, hash key
inoremap # X<BS>#

if has('gui_running')
    set guifont=Menlo:h12
    colorscheme molokai
    set background=dark

    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R

    if has("gui_macvim")
        "macmenu &File.New\ Tab key=<nop>
        "map <leader>t <Plug>PeepOpen
    end

    let g:sparkupExecuteMapping = '<D-e>'

    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif

