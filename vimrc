"Vim-plug settings. {{{
call plug#begin('~/.vim/plugged')

" general plugins
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'

"editing 
Plug 'svermeulen/vim-easyclip'
Plug 'sjl/gundo.vim'
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular'

"directories and buffers
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/winmanager'

"tags
Plug 'universal-ctags/ctags', { 'dir': '~/home_local/src/ctags', 'do': ''}
Plug 'vim-scripts/taglist.vim'
Plug 'ludovicchabant/vim-gutentags'

"auto completion
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"special file formats
Plug 'vim-latex/vim-latex'
Plug 'elzr/vim-json'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown'


"color
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"search
Plug 'junegunn/fzf', { 'dir': '~/home_local/src/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

"Programming enhancement
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
Plug 'skywind3000/asyncrun.vim' 
Plug 'vim-scripts/a.vim'
" in project vimrc, define makeprg, set path like let &path.="src/include,/usr/include/AL,"
" so that gf shorcut or <leader>ih of A.vim would work
Plug 'embear/vim-localvimrc'
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
"}}}

" General Settings. {{{
set nocompatible
filetype plugin on
" }}}

" Highlight{{{
syntax enable
if has("gui_running")
	colorscheme solarized
	set background=light
	let g:airline_theme='solarized'
	let g:airline_solarized_bg='light'
else
	colorscheme gruvbox
	set background=light
	let g:airline_theme='powerlineish'
endif
" }}}

" UI config {{{
" This enables automatic indentation as you type.
filetype indent on " load filetype-specific indent files
set number " show line numbers
set showcmd    " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set wildmode=longest:full,full  "matches full match 
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
let &colorcolumn=join(range(121,999),",") "set background color of line exceeding 120 letters.
set wrap  " will automatically wrap long lines to multiple virtual lines.
set linebreak  "only wrap at a character in the breakat option
set nolist  " list disables linebreak
set textwidth=0 "disable automatic word wrapping
set wrapmargin=0 " prevent Vim from automatically inserting line breaks in newly entered text. 
" }}}

" Set encoding {{{
set fileencodings=utf-8,ucs-bom,shift-jis,latin1,big5,gb18030,gbk,gb2312,cp936 
"set everything encoded by utf-8
set fileencoding=utf-8  
set encoding=utf-8
set termencoding=utf-8  
set guifontset=
set guifont=Consolas\ 14
set guifontwide=Microsoft\ Yahei\ 14
" }}}

" Spell {{{
set spell spelllang=en_us
set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
set spellfile=~/.vim/spell/lizhao-spell.add
inoremap <F2> <C-x><C-k>
" for word completeion
" }}}

" Searching {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Config ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
" open ag.vim
nnoremap <leader>a :Ack

" Config FZF 
" makes it work like CtrlP
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF -m<cr> "enable multiple selection with tab and <shift-tab>
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
" }}}

" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
"Tabs and spaces
set tabstop=4       " number of visual spaces per TAB
" tabstop is the number of spaces a tab counts for. So, when Vim opens a file and reads a <TAB> character,
" it uses that many spaces to visually show the <TAB>.
set softtabstop=4   " number of spaces in tab when editing
" softabstop is the number of spaces a tab counts for when editing.
"  So this value is the number of spaces that is inserted when you hit <TAB> 
"  and also the number of spaces that are removed when you backspace.
set expandtab       " tabs are spaces
" expandtab turns <TAB>s into spaces. That's it. 
" So <TAB> just becomes a shortcut for "insert four spaces".
" }}}

 " Set winmanager and gutentags {{{ 
let g:winManagerWindowLayout = "BufExplorer|TagList"
let g:winManagerWidth = 30
nnoremap wm :WMToggle<cr>

" Set Taglist
" Only tags of current file is shown
let Tlist_Show_One_File=1
" If Taglist window is the last window, exit vim.
let Tlist_Exit_OnlyWindow=1
 " Fold methods list for files not currently edited.
let Tlist_File_Fold_Auto_Close=1
 " Add a menu on GUI
let Tlist_Show_Menu=1

"set vim-gutentags
"set root of project folder
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"name of tags file
let g:gutentags_ctags_tagfile = '.tags'
" put tag files in ~/.cache/tags
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
"set ctags parameters
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" create ~/.cache/tags if not existent. 
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
" }}}

" Set YouCompleteMe {{{
let g:ycm_path_to_python_interpreter='/usr/local/bin/python3'

"press to invoke completion
let g:ycm_key_invoke_completion = '<F3>'
"Enter 3 letters string will invoke auto-completion
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
"no diagnostic message
let g:ycm_show_diagnostics_ui = 0
let g:UltiSnipsExpandTrigger="<c-j>"
" }}}

" Tex  and Markdown Settings {{{
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
autocmd BufRead,BufNewFile *.tex set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf ='okular --unique'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=-1 -src-specials -interaction=nonstopmode $*'
"Use <C-u> to clear a range that the vim might insert
autocmd FileType tex nnoremap <Leader>lb :<C-U>exec '!bibtex '.Tex_GetMainFileName(':p:t:r')<CR>
function! SyncTexForward()
        let execstr = "silent !okular --unique %:p:r.pdf\#src:".line(".")."%:p &"
        exec exec execstr
endfunction
autocmd FileType tex nnoremap <Leader>ls :call SyncTexForward()<CR>
let g:vimwiki_list = [{'path': '~/Documents/notes',
                       \ 'syntax': 'markdown', 'ext': '.md'}]

" }}}

" File specific settings {{{
augroup filegroup
    autocmd! 
    "clear autocmds for current group
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter,BufNewFile *.tex setlocal spell
    autocmd BufEnter,BufNewFile *.latex setlocal spell
    autocmd BufEnter,BufNewFile *.txt setlocal spell
    autocmd BufEnter,BufNewFile *.text setlocal spell
    autocmd BufEnter,BufNewFile readme setlocal spell
    autocmd BufEnter,BufNewFile ReadMe setlocal spell
    autocmd BufEnter,BufNewFile README setlocal spell 
    autocmd BufEnter,BufNewFile Readme setlocal spell
    autocmd BufEnter,BufNewFile *.md setlocal spell
    autocmd BufWritePre *.php, *.py, *.js, *.txt, *.text, *.hs, *.java,
                \readme, README, ReadMe, Readme, 
                \*.md 
                \:call <SID>StripTrailingWhitespaces()
    autocmd BufRead,BufNewFile *.c set filetype=c 
    autocmd FileType cs setlocal noexpandtab
    autocmd FileType cs setlocal list
    autocmd FileType cs setlocal listchars=tab:+\ ,eol:-
    autocmd FileType cs setlocal formatprg=par\ -w80\ -T4
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python setlocal tabstop=2
    autocmd FileType python setlocal shiftwidth=2
    autocmd FileType python setlocal softtabstop=2
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.md setlocal noexpandtab
    autocmd BufEnter *.md setlocal tabstop=4
    autocmd BufEnter *.md setlocal shiftwidth=4
    autocmd BufEnter *.md setlocal softtabstop=4
augroup END
" }}}

" Set backup {{{
set backup
set backupdir=~/.vim_tmp,~/.temp,/var/tmp,/tmp "for backup files
set backupskip=/tmp/*,/temp/*
set directory=~/.vim_tmp,~/.temp,/var/tmp,/tmp "for swap files
set writebackup
" }}}

" Work with TMux {{{
" allows cursor change in tmux mode. Show cursor as a vertical bar in Tmux
" instead of a block
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

"Custom functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespaces at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

" Programming enhancement, neomake, neoformat and autorun {{{
"open the error and warning list automatically:
let g:neomake_open_list = 2
let g:neoformat_only_msg_on_error = 1 "only msg when there is an error
"toggle Neomake with F11
nnoremap <F11> <Esc>::NeomakeToggle<CR>
"invoke the formatter for current buffer 
nnoremap <F12> <Esc>:Neoformat<CR>

function! MyOnBattery()
  if filereadable('/sys/class/power_supply/AC/online')
  return readfile('/sys/class/power_supply/AC/online') == ['0']
  else
          return '1'=='0'
  endif
endfunction

if MyOnBattery()
" When writing a buffer (no delay).        
  call neomake#configure#automake('w')
else
" When writing a buffer (no delay), and on normal mode changes (after 1000ms).        
  call neomake#configure#automake('nw', 1000)
endif
"C
let g:c_syntax_for_h=1
let g:neomake_c_enabled_makers = ['clang', 'cppcheck']
let g:neoformat_enabled_c = ['clangformat']
"C++
let g:neomake_cpp_enabled_makers = ['clang', 'cppcheck']
let g:neoformat_enabled_cpp = ['clangformat']
"python
let g:neomake_python_enabled_makers = ['python3', 'pylint']
let g:neoformat_enabled_python = ['yapf3']
"Shell
let g:neomake_shell_enabled_makers = ['shellcheck']

"compile shortcuts
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml', '.project'] 
" open quick fix after async_run
let g:asyncrun_open = 6
" ring when async_run returns
let g:asyncrun_bell = 1
" define the following for cpp projects
" Press F4 to compile current buffer
autocmd  FileType cpp nnoremap <silent> <F4> :AsyncRun g++ -Wall -Wextra -Werror -std=c++17 -pthread -O2 "$(VIM_FILEPATH)" -o  "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" Press F5 run the executable from current file 
autocmd  FileType cpp nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" Press F6 to make the whole project
autocmd  FileType cpp nnoremap <silent> <F6> :AsyncRun -cwd=<root> make <cr>
" Press F7 to run all tests
autocmd  FileType cpp nnoremap <silent> <F7> :AsyncRun -cwd=<root> -raw make test <cr>
" Press F8 to run the current project
autocmd  FileType cpp nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
" Press F9 to generate make file using cmake
autocmd  FileType cpp nnoremap <silent> <F9> :AsyncRun -cwd=<root> cmake . <cr>
" use F10 toggle quick fix window
autocmd  FileType cpp nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" }}}

" Some useful shortcuts. {{{
" " move vertically by visual line
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" These two allow us to move around lines visually. 
" So if there's a very long line that gets visually wrapped to two lines,
" j won't skip over the "fake" part of the visual line in favor of the next "real" line.
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" highlight last inserted text
"
" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <leader>n :call ToggleNumber()<CR>

nnoremap  la `[v`]
" This one is pretty cool. It visually selects the block of characters 
" you added last time you were in INSERT mode.
" jk is escape
inoremap jk <esc>
nnoremap rw <Esc>: /\(\<\w\+\>\)\_s*\<\1\><CR>
" type r-w will find repeated words in text.
nnoremap <F3> <Esc>:syntax sync fromstart<CR>
inoremap <F3> <C-o>:syntax sync fromstart<CR>
" press F11 will sync syntax from start
"  }}}

"Folding method for this file {{{
set modelines=2
" vim:foldmethod=marker:foldlevel=0
" }}}
