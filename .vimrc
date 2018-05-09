" Basic configurations 
" {{{
set fenc=utf-8
set hidden
" set list

set nobackup
set noswapfile
set smartcase

set showcmd

set number
set cursorline
set cursorcolumn
set smartindent
set showmatch
set laststatus=2
set cmdheight=2

set expandtab
set tabstop=4
set shiftwidth=4

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

set mouse=a
set ttymouse=xterm2

set foldmethod=marker

let mapleader = ","

if &compatible
  set nocompatible
endif

let g:nerdtree_plugin_use_ripgrep = 1
filetype plugin indent on
"}}}

" Cursor shape
" {{{
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
" }}}

" Shortcuts
" {{{
nnoremap <silent> <Leader>. :<C-u>edit ~/.vimrc<CR>
nnoremap <Leader><C-e> :source ~/.vimrc<CR>
" }}}

" dein settings
" {{{
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/fujiwara/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/fujiwara/.vim/dein')
    call dein#begin('/home/fujiwara/.vim/dein')

    " Let dein manage dein
    " Required:
    call dein#add('/home/fujiwara/.vim/dein/repos/github.com/Shougo/dein.vim')

    " TOML files
    let s:dein_dir  = expand('/home/fujiwara/.vim/dein')
    let s:toml      = s:dein_dir . '/plugins.toml'
    let s:lazy_toml = s:dein_dir . '/plugins_lazy.toml'

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#add('airblade/vim-gitgutter')

    " Required:
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

nmap ,dein :call dein#install()<CR>

function! LoadDeinPlugins()
  call dein#load_toml('~/.vim/dein/plugins.toml')
  call dein#install()
endfunction
"}}}

" Enable jump by function name using ctags
" {{{
set tags=./tags,tags;$HOME
"function! ReadTags(type)
"  try
"    execute "set tag=`git rev-parse --show-toplevel`/.tags_files/".
"      \ "/" . a:type . "_tags"
"  catch
"    execute "set tags=./.tags_files/" . a:type . "_tags;"
"  endtry
"endfunction
"
"augroup TagsAutoCmd
"  autocmd!
"  autocmd BufEnter * :call ReadTags(&filetype)
"augroup END
"}}}

" PHP syntax error check
" {{{
function! PHPLint()
  let result = system( &ft . ' -l ' . bufname(""))
  echo result
endfunction

nmap <Leader>l :call PHPLint()<CR>
" }}}

" VimFiler
" {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=50 -no-quit<CR>
augroup vimrc
    autocmd FileType fimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
    nmap <buffer> q <Plug>(vimfiler_exit)
    nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction
"}}}

" Unite settings
" {{{
" settings
let g:unite_enable_start_insert=1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_source_history_yank_enable=1
let g:unite_source_file_mru_limit=200

" shortcuts
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBuferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
"noremap <C-P>b :Unite buffer<CR>
"noremap <C-P>f :Unite -buffer-name=file file<CR>
"noremap <C-P>z :Unite file_mru<CR>

" grep
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" Use ag(The Silver Searcher) if exists
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif
"}}}

" grep settings
" {{{
set grepprg=rg\ --no-heading
"}}}

" NERDTree settings
" {{{
let g:NERDTreeShowBookmarks=1
let g:NERDTreeDirArrows=1
let g:NERDTreeDirArrowExpandable='▶'
let g:NERDTreeDirArrowCollapsible='▼'
let NERDTreeWinSize=45
""" Open NERDTree if no parameter given
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_id") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension . ' ctermbg=' . a:bg . ' ctermfg=' . a:fg . ' guibg=' . a:guibg . ' guifg=' . a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension . ' #^\s\+.*' . a:extension . '$#'
endfunction

"call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
"call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
"call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" }}}

" colorscheme
" {{{
colorscheme solarized
set background=light
syntax on
" }}}

" specific opperation for file type
" {{{
" let g:zip_unzipcmd="unzip.exe"
" let g:zip_zipcmd="zip.exe"
" command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
" command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78
"}}}

" test functions
" {{{
function! Hasdein()
    if exists("g:loaded_rg")
        echo "having"
    else
        echo "doesn't have"
    endif
endfunction

function! Iscygwin()
    if has("win32unix")
        echo "cygwin"
    else
        echo "other"
    endif
endfunction
"}}}
