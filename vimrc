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
Plug 'universal-ctags/ctags', { 'dir': '~/home_local/src/ctags', 
  \ 'do': './autogen.sh && ./configure --prefix=$HOME/home_local
  \ && make && make install'}
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'

" enhance sessions
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

"auto completion
Plug 'Valloric/YouCompleteMe', {'do': 'python3 ./install.py --clangd-completer
  \ --cs-completer --go-completer 
  \ --ts-completer --rust-completer --java-completer'}
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"special file formats
Plug 'vim-latex/vim-latex'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}


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
Plug 'ericcurtin/CurtineIncSw.vim' "to replace a.vim
" in project vimrc, define makeprg, set path like let &path.="src/include,/usr/include/AL,"
" so that <leader-h> shortcut works, compiler options can be passed to
" noemake, or anything that needs to be configured project-wise
Plug 'embear/vim-localvimrc'

" for c programming language
Plug 'WolfgangMehner/c-support'
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
colorscheme solarized
set background=light
let g:airline_theme='solarized'
let g:airline_solarized_bg='light'
let g:solarized_contrast = "high"
let g:solarized_visibility= "high"

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
let &colorcolumn=join(range(81,999),",") "set background color of line exceeding 81 letters.
set wrap  " will automatically wrap long lines to multiple virtual lines.
set linebreak  "only wrap at a character in the breakat option
set nolist  " list disables linebreak
set textwidth=0 "disable automatic word wrapping
set wrapmargin=0 " prevent Vim from automatically inserting line breaks in newly entered text. 
" }}}

" Editing enhancement {{{
" because easyclip has mapped m to cut
nnoremap gm m " gm to add marker
imap <c-v> <plug>EasyClipInsertModePaste
cmap <c-v> <plug>EasyClipCommandModePaste
"}}}

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
let g:winManagerWindowLayout = "FileExplorer|BufExplorer"
let g:winManagerWidth = 30
nnoremap wm :WMToggle<cr>

nnoremap wt :TagbarToggle<cr>

"set vim-gutentags
"set root of project folder
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"name of tags file
let g:gutentags_ctags_tagfile = '.tags'
" put tag files in ~/.cache/tags
let s:vim_tags = expand('~/.vim_temp/tags')
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

" Set YouCompleteMe YCM-generator and UltiSnops{{{
" set python interpreter for ycm server
let g:ycm_server_python_interpreter='/usr/bin/python3'

" show detail information of a completion candidate in a top window
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
" use clangd's caching and filtering algorithm
let g:ycm_clangd_uses_ycmd_caching = 0

"no diagnostic message
let g:ycm_show_diagnostics_ui = 0
let g:ycm_use_ultisnips_completer = 1

" config ycm-generator, generate .ycm_extra.config.py for c/c++ project
nnoremap <leader>yc <Esc>:YcmGenerateConfig<CR>

let g:UltiSnipsExpandTrigger="<c-l>"

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

" vim-instant-markdown settings
let g:instant_markdown_autostart = 0 " don't auto-start preview
"server startup and curl activity is logged in the specified log.
let g:instant_markdown_logfile = '~/.vim_tmp/instant_markdown.log'
let g:instant_markdown_mathjax = 1 " embed latex math in markdown
autocmd FileType markdown nnoremap <leader>lv :InstantMarkdownPreview<CR>
autocmd FileType markdown nnoremap <leader>ls :InstantMarkdownStop<CR>
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
                \ readme, README, ReadMe, Readme, 
                \ *.md 
                \ :call <SID>StripTrailingWhitespaces()
    autocmd BufRead,BufNewFile *.c set filetype=c 
    autocmd FileType tex setlocal tabstop=2
    autocmd FileType tex setlocal shiftwidth=2
    autocmd FileType tex setlocal softtabstop=2
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
let s:backup_dir = expand('~/.vim_temp/backup')
" if backup_dir doesn't exist, create it.
if !isdirectory(s:backup_dir)
   silent! call mkdir(s:backup_dir, 'p')
endif
set backupdir=s:backup_dir,~/.temp,/var/tmp,/tmp "for backup files
" set backupdir=~/.vim_tmp,~/.temp,/var/tmp,/tmp "for backup files
set backupskip=/tmp/*,/temp/*
" set directory=~/.vim_tmp,~/.temp,/var/tmp,/tmp "for swap files

let s:swap_dir = expand('~/.vim_temp/swap')
set directory^=s:swap_dir// "append path to head of directory, use absolute path
if !isdirectory(s:swap_dir)
   silent! call mkdir(s:swap_dir, 'p')
endif
set writebackup

set undofile " Maintain undo history between sessions
" set undodir=~/.vim_temp/undodir
let s:undo_dir = expand('~/.vim_temp/undodir')
set undodir=s:undo_dir 
" create undo_dir if not existent. 
if !isdirectory(s:undo_dir)
   silent! call mkdir(s:undo_dir, 'p')
endif

" }}}

" Obsession and prosession setting-up {{{
let s:ps_dir = expand('~/.vim_temp/sessions')
let g:prosession_dir = s:ps_dir
" create directory for prosessions if not existent. 
if !isdirectory(s:ps_dir)
   silent! call mkdir(s:ps_dir, 'p')
endif

"  }}}

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
nnoremap <F11> <Esc>:NeomakeToggle<CR>
inoremap <F11> <Esc>:NeomakeToggle<CR>
"invoke the formatter for current buffer 
nnoremap <F12> <Esc>:Neoformat<CR>
inoremap <F12> <Esc>:Neoformat<CR>

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
let g:neomake_c_enabled_makers = ['clang']
let g:neomake_c_clang_maker = {
  \ 'exe': 'clang',
  \ 'args': ['-Wall', '-Wextra', '-pedantic',
  \ '-std=c11', '-fwrapv', '-fno-delete-null-pointer-checks', '-pthread',
  \ '-I', 'src', '-I', 'include', 
  \ ],
  \ }
let g:neoformat_enabled_c = ['clangformat']
"C++
let g:neomake_cpp_enabled_makers = ['clang', 'cppcheck']
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang',
   \ 'args': ['-Wall', '-Wextra', '-pedantic',
   \ 'std=c++17', '-fno-exceptions', '-fwrapv', '-fno-delete-null-pointer-checks',
   \ '-pthreads',
   \ '-Wno-sign-conversion',
   \ '-Wno-zero-as-null-pointer-constant', 
   \ '-Wno-padded', '-Wno-unused-parameter',
   \ '-I', 'src', '-I', 'include', 
   \ ],
   \ }
let g:neoformat_enabled_cpp = ['clangformat']
"python
let g:neomake_python_enabled_makers = ['python', 'pylint']
let g:neoformat_enabled_python = ['yapf']
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
autocmd  FileType cpp nnoremap <silent> <F4> :AsyncRun g++ -Wall -Wextra -pedantic
                        \ -std=c++17 -fno-exceptions -fwrapv -fno-delete-null-pointer-checks
                        \ -pthread -O2
                        \ -Wno-sign-conversion
                        \ -Wno-zero-as-null-pointer-constant 
                        \ -Wno-padded -Wno-unused-parameter
                        \ -I src -I include 
                        \ "$(VIM_FILEPATH)" -o  "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
autocmd  FileType c nnoremap <silent> <F4> :AsyncRun gcc -Wall -Wextra -pedantic
                        \ -std=c11 -fwrapv -fno-delete-null-pointer-checks -pthread -O2
                        \ -I src -I include
                        \ "$(VIM_FILEPATH)" -o  "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" Press F5 run the executable from current file 
autocmd  FileType cpp nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
autocmd  FileType c nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" Press F6 to make the whole project
autocmd  FileType cpp nnoremap <silent> <F6> :AsyncRun -cwd=<root> make <cr>
autocmd  FileType c nnoremap <silent> <F6> :AsyncRun -cwd=<root> make <cr>

" Press F7 to run all tests
autocmd  FileType cpp nnoremap <silent> <F7> :AsyncRun -cwd=<root> -raw make test <cr>
autocmd  FileType c nnoremap <silent> <F7> :AsyncRun -cwd=<root> -raw make test <cr>

" Press F8 to run the current project
autocmd  FileType cpp nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
autocmd  FileType c nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>

" Press F9 to generate make file using cmake
autocmd  FileType cpp nnoremap <silent> <F9> :AsyncRun -cwd=<root> cmake . <cr>
autocmd  FileType c nnoremap <silent> <F9> :AsyncRun -cwd=<root> cmake . <cr>

" use F10 toggle quick fix window
autocmd  FileType cpp nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
autocmd  FileType c nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" toggle c/cpp and header file
autocmd FileType cpp nnoremap <leader>h :call CurtineIncSw()<CR>
autocmd FileType cpp inoremap <leader>h :call CurtineIncSw()<CR>
autocmd FileType c nnoremap <leader>h :call CurtineIncSw()<CR>
autocmd FileType c inoremap <leader>h :call CurtineIncSw()<CR>

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
" press F3 will sync syntax from start
nnoremap gf <C-W>gf
vnoremap gf <C-W>gf "gf open file under cursor in new tab.
"  }}}

"Folding method for this file {{{
set modelines=2
" vim:foldmethod=marker:foldlevel=0
" }}}
