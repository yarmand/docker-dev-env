"  vim-plugin
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'chriskempson/base16-vim'
Plug 'https://github.com/zeis/vim-kolor.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/fatih/vim-go.git'
Plug 'https://github.com/Blackrush/vim-gocode.git'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/othree/javascript-libraries-syntax.vim.git'
Plug 'https://github.com/plasticboy/vim-markdown.git'
Plug 'https://github.com/vim-ruby/vim-ruby.git'
Plug 'https://github.com/thoughtbot/vim-rspec.git'
Plug 'https://github.com/rodjek/vim-puppet.git'
Plug 'https://github.com/w0ng/vim-hybrid.git'
Plug 'https://github.com/rking/ag.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'troydm/zoomwintab.vim'
Plug 'https://github.com/ervandew/supertab.git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/gilsondev/searchtasks.vim.git'
Plug 'https://github.com/brooth/far.vim'

" typescript
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'https://github.com/Quramy/tsuquyomi'
Plug 'https://github.com/Quramy/tsuquyomi'
Plug 'https://github.com/Quramy/vim-js-pretty-template'
Plug 'https://github.com/jason0x43/vim-js-indent'
Plug 'https://github.com/Quramy/vim-dtsm'
Plug 'https://github.com/mhartington/vim-typings'
Plug 'ianks/vim-tsx'

" Initialize plugin system
call plug#end()

set background=dark
"set guifont=Consolas:h11

" Set encoding
set encoding=utf-8

" Default color scheme
set t_Co=256
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm
let g:solarized_termcolors=256

let g:kolor_italic=1                    " Enable italic. Default: 1
let g:kolor_bold=1                      " Enable bold. Default: 1
let g:kolor_underlined=0                " Enable underline. Default: 0
let g:kolor_alternative_matchparen=0    " Gray 'MatchParen' color. Default: 0
"colorscheme kolor

let g:airline_theme='papercolor'

if has('nvim')
  set termguicolors
  colorscheme hybrid
else
  colorscheme solarized
endif

" indent lines
let g:indentLine_char = '┆'
let g:indentLine_color_term = 239
let g:indentLine_color_dark = 2
let g:indentLine_color_tty_light = 4
let g:indent_guides_start_level = 2
let g:indentLine_noConcealCursor = 1

let mapleader=","

" windows C-c C-v support
" source $VIMRUNTIME/mswin.vim
vnoremap <C-Insert> "+y
map <S-Insert>	"+gP
cmap <S-Insert>	<C-R>+

" enable mouse

syntax on             " syntax coloration
filetype plugin on
filetype plugin indent on
set number            " show line number
set ruler             " show row, col in statusbar
set nowrap            " disable line wrap
set showmatch         " show other bracket
set autoindent        "
set tabstop=2
set softtabstop=2     " tab size
set shiftwidth=2      " indentation size
set expandtab         " use spaces for tab
set mouse=a
set nofoldenable    " disable folding"



" ZoomWin configuration
map <Leader>o :ZoomWinTabToggle<CR>

" window resize
nnoremap <Leader>+ :res +5<CR>
nnoremap <Leader>= :res +5<CR>
nnoremap  <Leader>- :res -5<CR>


" convinient :Q :W
command! Q q
command! W w

" window resize
nnoremap <Leader>+ :res +5<CR>
nnoremap <Leader>= :res +5<CR>
nnoremap  <Leader>- :res -5<CR>
nnoremap <Leader>v+ :vertical res +15<CR>
nnoremap <Leader>v= :vertical res +15<CR>
nnoremap <Leader>v- :vertical res -15<CR>

" windows navigation
nnoremap <A-left> :wincmd h<CR>
nnoremap <A-right> :wincmd l<CR>
nnoremap <A-up> :wincmd k<CR>
nnoremap <A-down> :wincmd j<CR>
if has('nvim')
  tnoremap <A-left> <C-\><C-N>:wincmd h<CR>
  tnoremap <A-right> <C-\><C-N>:wincmd l<CR>
  tnoremap <A-up> <C-\><C-N>:wincmd k<CR>
  tnoremap <A-down> <C-\><C-N>:wincmd j<CR>
endif
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" tabs navigation
nnoremap > :tabn<CR>
nnoremap <  :tabp<CR>

" [neovim] exit terminal mode with Esc
"tnoremap <Esc> <C-\><C-n>

" add another comment line shortcut
map <Leader>/ <Leader>c<space>

" CTags
map <Leader>frt :!ctags --extra=+f -R *<CR>
map <Leader>frtt :!ctags --extra=+f -R --exclude='*test*' *
map <Leader>frtr :!find app lib \| ctags --extra=+f -R -L -<CR>
map <Leader>ns :tnext<CR>

" TagList
map <Leader><Leader>t :TagbarToggle<CR>

" Set encoding
" set encoding=utf-8

 "Searching
set hlsearch
" clear search hilight
nnoremap <leader><Leader>/ :noh<cr>
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

autocmd BufWrite * silent! %s/[\r \t]\+$// " remove space fin de ligne

"set autowrite "Auto write change buffer
:au FocusLost * silent! :wa
"auto change dir to current buffer
"autocmd BufEnter * if expand("%:p:h") !~ '^/backup' | silent! lcd %:p:h | endif

"auto change dir to current buffer git repo root
autocmd BufEnter * silent! Gcd

" Spell checking
"set spelllang=en
"set spell
"set spellsuggest=5

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>e :NERDTree<CR>
map <Leader>ee :NERDTreeFind<CR>
map <Leader><Leader>e :NERDTreeToggle<CR>

set tags=tags;

" FuzzyFind
"   files
map <C-p> :Files<CR>
map ff :History<CR>
"   tags
map ft :BTags<CR>
map fs :Tags<CR>
map fd bvey :Tags <C-r>"<CR>
" git exploration
map gc :BGcommit<CR>
map gh :Commits<CR>

" Go
map <Leader>gd :GoDef<CR>
map <Leader>gi :GoImports<CR>
map <Leader>gh :GoDoc<CR>
map <Leader>gt :GoTest<CR>
map <Leader>gl :GoLint<CR>
map <Leader>gr :GoRename<CR>

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_autosave = 0
autocmd BufWrite *.go :GoImports
autocmd BufWrite *.go :GoFmt
autocmd BufWrite *.go :GoLint

" next / previous
map fn :cnext<cr>
map f<s-n> :cprevious<cr>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map<Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}

" Show (partial) command in the status line
set showcmd

" searchtask
let g:searchtasks_list=["TODO", "FIXME", "XXX"]
map <Leader>tt :SearchTasks .<CR>

" find and replace
map <Leader>fr bvey :Far <C-r>" <C-r>" bar **/*.py


" find in project
let g:ruby_search_in_project = ""
map fw bvey :Ag <C-r>" <C-R>=ruby_search_in_project<CR>
map fW :Ag <C-r>" <C-R>=ruby_search_in_project<CR>
map fp :Ag what_goes_here <C-R>=ruby_search_in_project<CR>

" sessions
function! SaveSession()
  mksession! .vimsession
endfunction
function! SaveAndQuit()
  call SaveSession()
  quitall
endfunction
nmap <Leader>ss :call SaveSession()<CR>
nmap <Leader>qq :call SaveAndQuit()<CR>

" fugitive
map gs :Gstatus<CR>
map gd :Gdiff<CR>
map gp :Gpush<CR>

"Nice statusbar
set laststatus=2
set statusline=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=%=                           " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
set statusline+=%{fugitive#statusline()}

let g:term_buf = 0
function! Term_toggle()
  wincmd j
  if g:term_buf == bufnr("")
    setlocal bufhidden=hide
    close
  else
    botright new
    try
      exec "buffer ".g:term_buf
    catch
      call termopen("zsh", {"detach": 0})
      let g:term_buf = bufnr("")
    endtry
    startinsert
  endif
endfunction
nnoremap <Leader>t :call Term_toggle()<cr>
nnoremap <C-t> :call Term_toggle()<cr>
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
" When switching to terminal windows it goes into insert mode automatically
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

