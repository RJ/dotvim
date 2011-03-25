" NB: helpful commands when hacking this .vimrc:
" ,ev  <-- open .vimrc
" ,rv  <-- reload .vimrc
"
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
" ,<space> clears search result highlights etc
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

" Nazi-mode
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>

" Alt+up/down will go down a 'line', even within one large, wrapped line
map  <A-j> gj 
map  <A-k> gk 
imap <A-j> <ESC>gji
imap <A-k> <ESC>gki
map  <A-down> gj 
map  <A-up> gk 
imap <A-down> <ESC>gji
imap <A-up> <ESC>gki

" Scroll-lock-to-centre toggle
map <leader>zz :let &scrolloff=999-&scrolloff<cr>

" Allow minimised splits to use less space
set wmh=0

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l

" tripple escape closes buffer
map <esc><esc><esc> :q<cr>
imap <esc><esc><esc> :q<cr>


" Max/unmax splits
nnoremap <c -W>O :call MaximizeToggle ()<cr>
nnoremap <c -W>o :call MaximizeToggle ()<cr>
nnoremap <c -W><c-O> :call MaximizeToggle ()<cr>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

" Folding TODO: configure for erlang
set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
au BufNewFile,BufRead *.html map <leader>ft Vatzf

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . '‚Ä¶' . repeat(" ",fillcharcount) . foldedlinecount . '‚Ä¶' . ' '
endfunction
set foldtext=MyFoldText()

" Fuck you, help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>


" Various syntax stuff
au BufNewFile,BufRead *.escript set filetype=erlang
au BufNewFile,BufRead *.app.src set filetype=erlang
au BufNewFile,BufRead *.app     set filetype=erlang
au BufNewFile,BufRead *.appup   set filetype=erlang
au BufNewFile,BufRead *.erl     set filetype=erlang

""au FileType {erl,erlang} au BufWritePost <buffer> silent ! [ -e tags ] &&
""    \ ( awk -F'\t' '$2\!="%:gs/'/'\''/"{print}' tags ; ctags --languages=erlang -f- '%:gs/'/'\''/' )
""    \ | sort -t$'\t' -k1,1 -o tags.new "&& mv tags.new tags

au BufNewFile,BufRead *.m*down set filetype=markdown
au BufNewFile,BufRead *.m*down nnoremap <leader>1 yypVr=
au BufNewFile,BufRead *.m*down nnoremap <leader>2 yypVr-
au BufNewFile,BufRead *.m*down nnoremap <leader>3 I### <ESC>

" Sort CSS
map <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:let @/=''<CR>

" Clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Exuberant ctags! TODO reconfigure
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

" Faster Esc (hit jj in insert mode)
"inoremap <Esc> <nop>
inoremap jj <ESC>

" Edit .vimrc
nmap <leader>ev :e $MYVIMRC<cr>
" Reload .vimrc
nmap <leader>rv :source $MYVIMRC<cr>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

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
    set guifont=Menlo:h14
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

