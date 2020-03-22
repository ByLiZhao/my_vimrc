"Vim-plug settings. {{{
call plug#begin('~/.vim/plugged')

" general plugins
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
" enhance sessions
Plug 'tpope/vim-obsession'

"editing 
" Plug 'svermeulen/vim-easyclip'
" replace vim-easyclip with the following three
Plug 'svermeulen/vim-cutlass' "make cut better
Plug 'svermeulen/vim-yoink' " yank history
Plug 'svermeulen/vim-subversive' " replace
Plug 'sjl/gundo.vim'
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'

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

"auto completion
Plug 'Valloric/YouCompleteMe', {'do': 'python3 ./install.py --clangd-completer
  \ --cs-completer --go-completer 
  \ --ts-completer --rust-completer --java-completer'}
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"special file formats
Plug 'vim-latex/vim-latex', {'for': 'tex'}
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'chrisbra/csv.vim'


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

" for c and go programming language
" Doxygen for C,  C++ and Python
Plug 'vim-scripts/DoxygenToolkit.vim'
" work with go-lang.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
"}}}

" General Settings. {{{
set nocompatible
filetype plugin on
" }}}

" Highlight{{{
syntax enable
colorscheme gruvbox
set background=light
" let g:airline_theme='solarized'
let g:airline_theme='gruvbox'
" let g:airline_solarized_bg='light'
let g:airline_gruvbox_bf='light'
" let g:solarized_contrast = "high"
" let g:solarized_visibility= "high"
let g:gruvbox_contrast_light='high'
let g:gruvbox_visibility='high'

" }}}

" UI, indent, and folding {{{
if has("gui_running")
  " GUI is running or is about to start,  maximize gvim window.
  " this doesn't work on windows.
  set lines=999 columns=999
endif

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
" set folding 
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

"Tabs and spaces
" tabstop is the number of spaces a tab counts for. So, when Vim opens a file and reads a <TAB> character,
" it uses that many spaces to visually show the <TAB>.
set tabstop=4       " number of visual spaces per TAB
" softabstop is the number of spaces a tab counts for when editing.
"  So this value is the number of spaces that is inserted when you hit <TAB> 
"  and also the number of spaces that are removed when you backspace.
set softtabstop=4   " number of spaces in tab when editing
" expandtab turns <TAB>s into spaces. That's it. 
" So <TAB> just becomes a shortcut for "insert four spaces".
set expandtab       " tabs are spaces
" }}}

" Tab, buffer,  location list,  and quick-fix list {{{
" gt to go to next tab,  wrap at the end.
" press [w to previous tab,  and ]w to next tab
nnoremap <silent> [w <Esc>:argdo update<CR>:tabprevious<CR>
nnoremap <silent> ]w <Esc>:argdo update<CR>:tabnext<CR>
" press [t to previous matched tag,  and ]t to next matched tag.
nnoremap <silent> [t <Esc>:update<CR>:tprevious<CR>            
nnoremap <silent> [t <Esc>:update<CR>:tnext<CR>            

" press [a to previous file in arglist. ]a to next file in arglist.
nnoremap <silent> [a <Esc>:update<CR>:previous<CR>            
nnoremap <silent> ]a <Esc>:update<CR>:next<CR>     

" press [b to previous buffer in buffer list,  ]b to next buffer in buffer
" list.
nnoremap <silent> [b <Esc>:update<CR>:bprevious<CR>
nnoremap <silent> ]b <Esc>:update<CR>:bnext<CR>

"press [q to previous location of quick-fix list, and ]q to next location in
"quick-fix list.  
nnoremap <silent> [q <Esc>:update<CR>:cprevious<CR>            
nnoremap <silent> ]q <Esc>:update<CR>:cnext<CR>            

" press [l to previous location of location list,  and ]l to next location.
nnoremap <silent> [l <Esc>:update<CR>:lprevious<CR>
nnoremap <silent> ]l <Esc>:update<CR>:endif<CR> :lnext<CR>            
" }}}

" Editing enhancement {{{
"
" comma always followed by a space
inoremap  ,  ,<Space>
"
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
" press F2 in visual mode to execute the selected as shell command in a vim
" terminal,  go back to where you come from, 
xnoremap <F2> "xy:term<CR><c-w>"x<CR><c-w><c-p>

inoremap <leader>( ()<Left>
inoremap <leader>[ []<Left>
inoremap <leader>{ {}<Left>
inoremap <leader>< <><Left>
"
xnoremap <leader>( s()<Esc>P<Right>%
xnoremap <leader>[ s[]<Esc>P<Right>%
xnoremap <leader>{ s{}<Esc>P<Right>%
xnoremap <leader>< s<><Esc><Left>p?<<CR>:nohlsearch<CR>
"
" autocomplete quotes (visual mode)
xnoremap  <leader>'  s''<Esc>P<Right>
xnoremap  <leader>"  s""<Esc>P<Right>
xnoremap  <leader>`  s``<Esc>P<Right>

"select between pairs.
"select everything between bracket,  ([{ search back to nearest ([{, 
"not including ([{ itself.
")]} search forward to nearest )]}.
nnoremap <leader>( <Esc>?(<CR>:nohlsearch<CR>v])
nnoremap <leader>) <Esc>/)<CR>:nohlsearch<CR>v[(
"select between square bracket
nnoremap <leader>[ <Esc>?[<CR>:nohlsearch<CR>v%
nnoremap <leader>] <Esc>/]<CR>:nohlsearch<CR>v%
"select between braces
nnoremap <leader>{ <Esc>?{<CR>:nohlsearch<CR>v]}
nnoremap <leader>} <Esc>/}<CR>:nohlsearch<CR>v[{
"
" gm to add marker, because m is remapped
nnoremap gm m 

" set vim-cutlass
" let m, mm, and M denote "move"
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" set vim-yoink, 
" immediately after performing a paste, 
" one can cycle through the history by hitting <c-n> and <c-p>
let g:yoinkIncludeDeleteOperations = 1
nmap <c-p> <plug>(YoinkPostPasteSwapBack)
nmap <c-n> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
" notice that the below P is the capital P
nmap P <plug>(YoinkPaste_P)
" hitting <c-=> after a paste will toggle between formatted and unformatted
" unformatted is default
nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

" configure vim-subsersive
" s for substitute an text object with content in the register.
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" example: <leader>siwip to replace all instances of the current word under the cursor
" that exist within the paragraph under the cursor. 
" <leader>sl_ to replace all instances of the character under the cursor on the current line.
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
" replace current word, only match complete words
" this short cut conflicts with the C/C++ plugin.
" nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

" set up EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga=)
" align around "=" in a paragraph.
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip=),
" align around "=" in a paragraph.
nmap ga <Plug>(EasyAlign)

"}}}

" Useful shortcuts to input special character {{{
" don't access menu by using alt key combinations
" for example,  don't use alt-f to access file menu
set winaltkeys=no

" because the terminal emulator might treat Alt key as a way to input escape sequence. 
" Alt-1           ±
" Alt-2           ²,  superscript 2
" Alt-3           ³,  superscript 3
" Alt-5           µ,  10^-6
" Alt-Shift_5     ¥,  Yen,  or yuan
" Alt-7           ·,  mid-dot
" Alt-9           ¹,  subscript 1
" Alt-0           °,  degree
" Alt-Shift-0     ©,  copyright
" Alt-.(dot)      ®,  trademark
" Alt-;           »,  ditto mark,  and right merge mark
" Alt-+           «,  left merge mark.
if has("gui_running")
    " dot operator
    inoremap <a-.> <c-v>u22c5
    " partial diff 
    inoremap <a-,> <c-v>u2202
    " larger or eual
    inoremap <a->> <c-v>u2265
    " smaller or equal
    inoremap <a-<> <c-v>u2264
    "integration
    inoremap <a-/> <c-v>u222b
    " there exists symbol
    inoremap <a-?> <c-v>u2203
    " element symbol
    inoremap <a-:> <c-v>u2208
    " universal qualification
    inoremap <a-'> <c-v>u2200
    " union 
    inoremap <a-;> <c-v>u22c3
    " intersection
    inoremap <a-"> <c-v>u22c2
    " subset 
    inoremap <a-{> <c-v>u2282
    " super set 
    inoremap <a-}> <c-v>u2283
    " logical conjuction
    inoremap <a-\> <c-v>u22c0
    " logical disjunction 
    " <Bar> has to be escaped.
    inoremap <a-\|> <c-v>u22c1
    " Gradient 
    inoremap <a-[> <c-v>u2207
    " Laplace operator
    inoremap <a-]> <c-v>u2206

    " plus or minus symbol
    inoremap <a-+> <c-v>u00b1
    " approximately equal to symbol
    inoremap <a-=> <c-v>u2245
    " right arrow
    inoremap <a--> <c-v>u2192
    " double line right arrow
    inoremap <a-_> <c-v>u21d2

    " super scripts 9-0
    inoremap <a-1> <c-v>u00b9
    inoremap <a-2> <c-v>u00b2
    inoremap <a-3> <c-v>u00b3
    " alt-1 to input superscript 1
    inoremap <a-4> <c-v>u2074
    " alt-4 to input superscript 4
    inoremap <a-5> <c-v>u2075
    inoremap <a-6> <c-v>u2076
    inoremap <a-7> <c-v>u2077
    inoremap <a-8> <c-v>u2078
    inoremap <a-9> <c-v>u2079
    inoremap <a-0> <c-v>u2070

    " subscripts 9-0 
    inoremap <a-(> <c-v>u2089
    inoremap <a-*> <c-v>u2088
    inoremap <a-&> <c-v>u2087
    inoremap <a-^> <c-v>u2086
    inoremap <a-%> <c-v>u2085
    inoremap <a-$> <c-v>u2084
    inoremap <a-#> <c-v>u2083
    inoremap <a-@> <c-v>u2082
    inoremap <a-!> <c-v>u2081
    inoremap <a-)> <c-v>u2080

    " greek letters   
    " inoremap <a-u> <a-5> 
endif
"  }}}

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
" override the pagedown hotkey
nnoremap <c-f> :FZF -m<cr> "enable multiple selection with tab and <shift-tab>
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
" }}}

 " Window, winmanager and gutentags {{{ 
 " ctrl-j to the window below the current window
 " ctrl-k to the window above the current window
 " ctrl-h to the window in the left of the current window.
 " ctrl-l to the window in the right of the current window.
 nnoremap <c-j> <c-w><c-j>
 nnoremap <c-k> <c-w><c-k>
 nnoremap <c-h> <c-w><c-h>
 nnoremap <c-l> <c-w><c-l>

let g:winManagerWindowLayout = "BufExplorer"
let g:winManagerWidth = 40
nnoremap wm :WMToggle<cr>

nnoremap wt :TagbarToggle<cr>

"set vim-gutentags
"set root of project folder
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"name of tags file
let g:gutentags_ctags_tagfile = '.tags'
" put tag files in ~/.cache/tags
let s:vim_tags = expand('~/.vim_temp/tags')
let g:gutentags_cache_dir = '~/.vim_temp/tags' 
"set ctags parameters
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" create ~/.cache/tags if not existent. 
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
" }}}

" Set YouCompleteMe YCM-generator and UltiSnips{{{
" set python interpreter for ycm server
let g:ycm_server_python_interpreter='/usr/bin/python3'

" show detail information of a completion candidate in a top window
let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1

" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
" use clangd's caching and filtering algorithm
let g:ycm_clangd_uses_ycmd_caching = 0

"no diagnostic message
let g:ycm_show_diagnostics_ui = 0
let g:ycm_use_ultisnips_completer = 1

" config ycm-generator, generate .ycm_extra.config.py for c/c++ project
nnoremap <leader>yc <Esc>:YcmGenerateConfig<CR>
" jump to a header, or definition, or declaration.
nnoremap <leader>jd :YcmCompleter GoTo<CR>
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

" Set backup, swap and undofile {{{
"set writebackup " set backup actually override set writebackup
set backup
let s:backup_dir = expand('$HOME/.vim_temp/backup')
" if backup_dir doesn't exist, create it.
if !isdirectory(s:backup_dir)
   silent! call mkdir(s:backup_dir, 'p')
endif
set backupdir=~/.vim_temp/backup,~/.temp,/var/tmp,/tmp "for backup files
set backupskip+=/tmp/*,/temp/*

let s:swap_dir = expand('~/.vim_temp/swap')
set directory^=~/.vim_temp/swap "append path to head of directory, use absolute path
if !isdirectory(s:swap_dir)
   silent! call mkdir(s:swap_dir, 'p')
endif

set undofile " Maintain undo history between sessions
set undodir=~/.vim_temp/undodir
let s:undo_dir = expand('~/.vim_temp/undodir')
" create undo_dir if not existent. 
if !isdirectory(s:undo_dir)
   silent! call mkdir(s:undo_dir, 'p')
endif

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
  \ 'args': ['-Wall', '-Wextra',
  \ '-fwrapv', '-fno-delete-null-pointer-checks', '-pthread',
  \ '-I', '.', '-I', 'src', '-I', 'include', '-I', '..',
  \ ],
  \ }
let g:neoformat_enabled_c = ['clangformat']
"C++
let g:neomake_cpp_enabled_makers = ['clang', 'cppcheck']
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang',
   \ 'args': ['-Wall', '-Wextra', 
   \ '-fno-exceptions', '-fwrapv', '-fno-delete-null-pointer-checks',
   \ '-pthreads',
   \ '-Wno-sign-conversion',
   \ '-Wno-zero-as-null-pointer-constant', 
   \ '-Wno-padded', '-Wno-unused-parameter',
   \ '-I', '.', '-I', 'src', '-I', 'include', '-I', '..', 
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
autocmd  FileType cpp nnoremap <silent> <F4> :AsyncRun g++ -Wall -Wextra
                        \ -fno-exceptions -fwrapv -fno-delete-null-pointer-checks
                        \ -pthread -O2
                        \ -Wno-sign-conversion
                        \ -Wno-zero-as-null-pointer-constant 
                        \ -Wno-padded -Wno-unused-parameter
                        \ -I. -I src -I include -I.. 
                        \ "$(VIM_FILEPATH)" -o  "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

autocmd  FileType cpp nnoremap <silent> <leader>c :AsyncRun g++ -Wall -Wextra
                        \ -fno-exceptions -fwrapv -fno-delete-null-pointer-checks
                        \ -pthread -O2
                        \ -Wno-sign-conversion
                        \ -Wno-zero-as-null-pointer-constant 
                        \ -Wno-padded -Wno-unused-parameter
                        \ -I. -I src -I include -I.. 
                        \ "$(VIM_FILEPATH)" -c <cr>

autocmd  FileType c nnoremap <silent> <F4> :AsyncRun gcc -Wall -Wextra
                        \ -fwrapv -fno-delete-null-pointer-checks -pthread -O2
                        \ -I. -I src -I include -I..
                        \ "$(VIM_FILEPATH)" -o  "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

autocmd FileType c nnoremap <silent> <leader>c :AsyncRun gcc -Wall -Wextra
                        \ -fwrapv -fno-delete-null-pointer-checks -pthread -O2
                        \ -I. -I src -I include -I..
                        \ "$(VIM_FILEPATH)" -c <cr>

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

" use gopls for code completion.
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
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
let g:gundo_prefer_python3 = 1
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

" leave insert mode  with the <RightMouse>-key,  convenient when work iwth
" laptop. 
inoremap	<RightMouse> <ESC>

nnoremap rw <Esc>: /\(\<\w\+\>\)\_s*\<\1\><CR>
" type r-w will find repeated words in text.
nnoremap <F3> <Esc>:syntax sync fromstart<CR>
inoremap <F3> <C-o>:syntax sync fromstart<CR>
" press F3 will sync syntax from start

" let <c-w>gf check whether the file has already opened in a tab,
" if yes, just use that tab.
function! FavorExistingTabPage()
    let l:bufNr = bufnr('')
    for l:i in range(1, tabpagenr('$'))
        if l:i == tabpagenr()
            continue    " Skip current.
        endif
        let l:winIndex = index(tabpagebuflist(l:i), l:bufNr)
        if l:winIndex != -1
            " We found the buffer elsewhere.
            if l:i >= tabpagenr()
                let l:i -= 1 " Adapt to removal of tab page before the current.
            endif

            close!

            execute l:i . 'tabnext'
            execute (l:winIndex + 1) . 'wincmd w'
            break
        endif
    endfor
endfunction
" edit the file whose name is under or after the sursor: goto file
" if the file already opened in a tab, go to that tab.
nnoremap gf <C-W>gf:call FavorExistingTabPage()<CR>

vnoremap gf <C-W>gf:call FavorExistingTabPage()<CR>
"  }}}

"Folding method for this file {{{
set modelines=2
" vim:foldmethod=marker:foldlevel=0
" }}}
