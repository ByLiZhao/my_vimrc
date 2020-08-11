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

" work with go-lang.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Building and version control 
" dispatch to different makers, works with tmux and terminal.
Plug 'mh21/errormarker.vim'
Plug 'tpope/vim-fugitive'
call plug#end()
"}}}

" General Settings. {{{
set nocompatible
filetype plugin on
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
nnoremap <silent> [w <Esc>:update<CR>:tabprevious<CR>
nnoremap <silent> ]w <Esc>:update<CR>:tabnext<CR>
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
" inoremap  ,  ,<Space>
"
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
" press F2 in visual mode to execute the selected as shell command in a vim
" terminal,  go back to where you come from, 
xnoremap <F2> "xy:term<CR><c-w>"x<CR><c-w><c-p>
" insert () [] {} <> pairings.
inoremap <leader>( ()<Left>
inoremap <leader>[ []<Left>
inoremap <leader>{ {}<Left>
inoremap <leader>< <><Left>
inoremap <leader>" ""<Left>
inoremap <leader>' ''<Left>
inoremap <leader>` ``<Left>
" italic in markdown 
inoremap <leader>- **<Left>
" Bold in markdown
inoremap <leader>_ ****<Left><Left>

" The following commands are replaced with corresponding commands in
" vim-surrounding. In visual mode press S, followed with surroudning.
" add surrounding pair in visual mode, NOTE: doesn't work with visual line
" mode.
" xnoremap <leader>( s()<Esc>P<Right>%
" xnoremap <leader>[ s[]<Esc>P<Right>%<Esc>:nohlsearch<CR>
" xnoremap <leader>{ s{}<Esc>P<Right>%
" xnoremap <leader>< s<><Esc><Left>p?<<CR>:nohlsearch<CR>
"
" autocomplete quotes (visual mode)
" xnoremap  <leader>'  s''<Esc>P<Right>
" xnoremap  <leader>"  s""<Esc>P<Right>
" xnoremap  <leader>`  s``<Esc>P<Right>

"select between pairs.
"select everything between surroundings,  
" Notice that with nested surroundings, following commands are different from
" "va(" or "va)".
" select between brackets.
" cursor at (, matching nearest )
nnoremap <leader>( <Esc>/)<CR>:nohlsearch<CR>v[(
" cursor at ), matching nearest (
nnoremap <leader>) <Esc>?(<CR>:nohlsearch<CR>v])
"select between square bracket
" cursor at [, matching nearest ]
nnoremap <leader>[ <Esc>/]<CR>:nohlsearch<CR>v%
" cursor at ], matching nearest [
nnoremap <leader>] <Esc>?[<CR>:nohlsearch<CR>v%
"select between braces
" cursor at {, matching nearest }
nnoremap <leader>{ <Esc>/}<CR>:nohlsearch<CR>v[{
" cursor at }, matching nearest {
nnoremap <leader>} <Esc>?{<CR>:nohlsearch<CR>v]}
"
" gm to add marker, because m is remapped
" vim's built-in gm command is shadowed.
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
if has("gui_running")
    " dot operator, ⋅
    inoremap <a-.> <c-v>u22c5
    " partial diff, ∂
    inoremap <a-,> <c-v>u2202
    " larger or eual,≥
    inoremap <a->> <c-v>u2265
    " smaller or equal,≤
    inoremap <a-<> <c-v>u2264
    "integration, ∫
    inoremap <a-/> <c-v>u222b
    " there exists symbol, ∃
    inoremap <a-?> <c-v>u2203
    " element symbol, ∈
    inoremap <a-:> <c-v>u2208
    " universal qualification, ∀
    inoremap <a-;> <c-v>u2200
    " union, ⋃
    inoremap <a-'> <c-v>u22c3
    " intersection, ⋂ 
    inoremap <a-"> <c-v>u22c2
    " subset, ⊂ 
    inoremap <a-{> <c-v>u2282
    " super set, ⊃ 
    inoremap <a-}> <c-v>u2283
    " logical conjuction, ⋀ 
    inoremap <a-\> <c-v>u22c0
    " logical disjunction, ⋁
    " <Bar> has to be escaped.
    inoremap <a-\|> <c-v>u22c1
    " Gradient, ∇ 
    inoremap <a-[> <c-v>u2207
    " Laplace operator, ∆
    inoremap <a-]> <c-v>u2206

    " plus or minus symbol, ±
    inoremap <a-+> <c-v>u00b1
    " approximately equal to symbol, ≅
    inoremap <a-=> <c-v>u2245
    " right arrow, →
    inoremap <a--> <c-v>u2192
    " double line right arrow, ⇒
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
    "  <a-J> <a-v> and <a-V> are not mapped. 
    "  <a-j> is for inserting special math symbols.
    " alpha and capital alpha.
    inoremap <a-a> <c-v>u03b1
    inoremap <a-A> <c-v>u0391
    " beta and capital beta
    inoremap <a-b> <c-v>u03b2
    inoremap <a-B> <c-v>u0392
    " chi and capital chi
    inoremap <a-c> <c-v>u03c7
    inoremap <a-C> <c-v>u03a7
    "delta and capital delta
    inoremap <a-d> <c-v>u03b4
    inoremap <a-D> <c-v>u0394
    " epsilon and capital epsilon
    inoremap <a-e> <c-v>u03b5
    inoremap <a-E> <c-v>u0395
    " phi and capital phi
    inoremap <a-f> <c-v>u03c6
    inoremap <a-F> <c-v>u03a6
    " gamma and capital gamma
    inoremap <a-g> <c-v>u03b3
    inoremap <a-G> <c-v>u0393
    " eta and capital eta
    inoremap <a-h> <c-v>u03b7
    inoremap <a-H> <c-v>u0397
    " iota and capital iota
    inoremap <a-i> <c-v>u03b9
    inoremap <a-I> <c-v>u0399
    " kappa and capital kappa
    inoremap <a-k> <c-v>u03ba
    inoremap <a-K> <c-v>u039a
    " lambda and capital lambda
    inoremap <a-l> <c-v>u03bb
    inoremap <a-L> <c-v>u039b
    " mu and capital mu
    inoremap <a-m> <c-v>u03bc
    inoremap <a-M> <c-v>u039c
    " nu and capital nu
    inoremap <a-n> <c-v>u03bd
    inoremap <a-N> <c-v>u039d
    " omicron and capital omicron
    inoremap <a-o> <c-v>u03bf
    inoremap <a-O> <c-v>u039f
    " pi and capital pi
    inoremap <a-p> <c-v>u03c0
    inoremap <a-P> <c-v>u03a0
    " theta and capital theta
    inoremap <a-q> <c-v>u03b8
    inoremap <a-Q> <c-v>u0398
    " rho and capital rho
    inoremap <a-r> <c-v>u03c1
    inoremap <a-R> <c-v>u03a1
    " sigma and capital sigma
    inoremap <a-s> <c-v>u03c3
    inoremap <a-S> <c-v>u03a3
    " tau and capital tau
    inoremap <a-t> <c-v>u03c4
    inoremap <a-T> <c-v>u03a4
    " upsilon and capital upsilon
    inoremap <a-u> <c-v>u03c5
    inoremap <a-U> <c-v>u03ab
    " omega and capital omega
    inoremap <a-w> <c-v>u03c9
    inoremap <a-W> <c-v>u03a9
    " xi and capital xi
    inoremap <a-x> <c-v>u03be
    inoremap <a-X> <c-v>u039e
    " psi and capital xi
    inoremap <a-y> <c-v>u03c8
    inoremap <a-Y> <c-v>u03a8
    " zeta and capital zeta
    inoremap <a-z> <c-v>u03b6
    inoremap <a-Z> <c-v>u0396

    " special math symbols,  also define corresponding digraph
    " circle-add symbol,⊕,  
    inoremap <a-j>o+ <c-v>u2295 
    dig o+ 8853 
    " circle-minus symbol, ⊖
    inoremap <a-j>o- <c-v>u2296
    dig o- 8854
    " circle-star symbol, ⊛ 
    inoremap <a-j>o* <c-v>u229b
    dig o* 8859
    " circle-dot symbol, ⊙
    inoremap <a-j>o. <c-v>u2299
    dig o. 8857
    " circle times, ⊗
    inoremap <a-j>ox <c-v>u2297
    dig ox 8855
    " circle-equal symbol, ⊜
    inoremap <a-j>o= <c-v>u229c
    dig o= 8860
    " circle-slash symbol, ⊖
    inoremap <a-j>o/ <c-v>u2298
    dig o- 8854

    " bullet symbol,  b for bullet-like, ∙ 
    inoremap <a-j>b. <c-v>u2219
    dig b. 8729
    " asterisk, ∗
    inoremap <a-j>b* <c-v>u2217
    dig b* 8727

    " math operators 
    " division, ÷
    inoremap <a-j>// <c-v>u00f7
    dig // 247
    " function composition, ∘
    inoremap <a-j>/o <c-v>u2218
    dig /o 8728
    " diamond operator, ⋄ 
    inoremap <a-j>\o <c-v>u22c4
    dig \o 8900
    " multiplication. the same code point for dot operator, ⋅
    inoremap <a-j>/. <c-v>u22c5
    dig /. 8901
    " star operator,⋆ 
    inoremap <a-j>/* <c-v>u22c6
    dig /* 8902
    " times, ⨉
    inoremap <a-j>\* <c-v>u2a09
    dig \* 10761
    " cross-product,  ⨯
    inoremap <a-j>** <c-v>u2a2f
    dig ** 10799

    " set related 
    " empty set, ∅
    inoremap <a-j>/0 <c-v>u2205
    dig /0 8709
    " full set, Ω, don't consufse with greek letter Omega Ω(937)
    inoremap <a-j>/O <c-v>u2126
    dig /O 8486
    " in set symbol, ∈
    inoremap <a-j>(- <c-v>u2208
    dig (- 8712
    " include in set ∋ 
    inoremap <a-j>-) <c-v>u220b
    dig -) 8715
    " not in set,  ∉
    inoremap <a-j>(+ <c-v>u2209
    dig (+ 8713
    " not include in set, ∌
    inoremap <a-j>+) <c-v>u220c
    dig +) 8716
    " exist,  ∃
    inoremap <a-j>-] <c-v>u2203
    dig -] 8707
    " not exist, ∄
    inoremap <a-j>+] <c-v>u2204
    dig +] 8708
    " any in set, ∀
    inoremap <a-j>v- <c-v>u2200
    dig v- 8704
    " subset, ⊂
    inoremap <a-j>(( <c-v>u2282
    dig (( 8834
    " has subset, ⊃
    inoremap <a-j>)) <c-v>u2283
    dig )) 8835
    " subset or equal, ⊆
    inoremap <a-j>(= <c-v>u2286
    dig (= 8838
    " has subset or equal, ⊇
    inoremap <a-j>)= <c-v>u2287
    dig )= 8839
    " not subset, ⊄
    inoremap <a-j>(/ <c-v>u2284
    dig (/ 8836
    " not has subset, ⊅ 
    inoremap <a-j>)/ <c-v>u2285
    dig )/ 8837
    " not subset or equal, ⊈
    inoremap <a-j>(\ <c-v>u2288
    dig (\ 8840
    " not has subset or equal, ⊉
    inoremap <a-j>)\ <c-v>u2289
    dig )\ 8841

    " smaller or equal, ≤
    inoremap <a-j><= <c-v>u2264
    dig <= 8804
    " bigger or equal ≥
    inoremap <a-j>>= <c-v>2265
    dig >= 8805
    " not smaller, ≮ 
    inoremap <a-j></ <c-v>u226e
    dig </ 8814
    " not larger, ≯
    inoremap <a-j>>/ <c-v>u226f
    dig >/ 8815
    " not smaller or equal, ≰
    inoremap <a-j><\ <c-v>u2270
    dig <\ 8816
    " not larger or equal, ≱ 
    inoremap <a-j>>\ <c-v>u2271
    dig >\ 8817
    " way bigger, ≪
    inoremap <a-j><< <c-v>u226a
    dig << 8810
    " way smaller, ≫
    inoremap <a-j>>> <c-v>u226b
    dig >> 8811
    " proportion, ∝
    inoremap <a-j>oc <c-v>u221d
    dig oc 8733

    " proceed order, ≺
    inoremap <a-j>/< <c-v>u227a
    dig /< 8826
    " succeed order, ≻ 
    inoremap <a-j>/> <c-v>u227b
    dig />8827
    " proceed or equal order, ≼
    inoremap <a-j>\< <c-v>u227c
    dig \< 8828
    " succeed or euqal order, ≽
    inoremap <a-j>\> <c-v>u227d
    dig \> 8829
    " not proceed, ⊀ 
    inoremap <a-j>%< <c-v>u2280
    dig %< 8832
    " not succeed, ⊁ 
    inoremap <a-j>%> <c-v>u2281
    dig %> 8833


    " integral
    " 1-dime integral, ∫ 
    inoremap <a-j>1/ <c-v>u222b
    dig 1/ 8747
    " 2-dim integral, ∬
    inoremap <a-j>2/ <c-v>u222c
    dig 2/ 8748
    " 3-diem integral, ∭
    inoremap <a-j>3/ <c-v>u222d
    dig 3/ 8749
    " curve integral, ∮
    inoremap <a-j>1f <c-v>u222e
    dig 1f 8750
    " surface integral, ∯
    inoremap <a-j>2f <c-v>u222f
    dig 2f 8751
    " volume integral,∰ 
    inoremap <a-j>3f <c-v>u2230
    dig 3f 8752
    " clockwiase integral, ∱
    inoremap <a-j>>f <c-v>u2231
    dig >f 8753
    "" counter clockwise integral, ⨑
    inoremap <a-j><f <c-v>u2a11
    dig <f 10769
    " clockwise contour integral, ∲
    inoremap <a-j>)f <c-v>u2232
    dig )f 8754
    " counter clockwise contour integral, ∳
    inoremap <a-j>(f <c-v>u2233
    dig (f 8755

    " numbers and Furier transformation
    " infinity, ∞ 
    inoremap <a-j>oo <c-v>u221e
    dig oo 8734
    " real set,  ℝ, ℝ
    inoremap <a-j>/R <c-v>u211d
    dig /R 8477
    " complex set, ℂ
    inoremap <a-j>/C <c-v>u2102
    dig /C 8450
    " set of quaternions, ℍ
    inoremap <a-j>/H <c-v>u210d
    dig /H 8461
    " set of natural numbers, ℕ
    inoremap <a-j>/N <c-v>u2115
    dig /N 8469
    " set of integers, ℤ
    inoremap <a-j>/Z <c-v>u2124
    dig /Z 8484
    " set of prime numbers, ℙ
    inoremap <a-j>/P <c-v>u2119
    dig /P 8473
    " set of rational numbers, ℚ
    inoremap <a-j>/Q <c-v>u211a
    dig /Q 8474
    " Furier transformation, ℱ
    inoremap <a-j>/f <c-v>u2131
    dig /f 8497
    
    " units and constant 
    " Aleph, ℵ
    inoremap <a-j>/a <c-v>u2135
    dig /a 8501
    " Euler constant, ℯ
    inoremap <a-j>/e <c-v>u212f
    dig /e 8495
    " Planck constant,  ℎ
    inoremap <a-j>/h <c-v>u210e
    dig /h 8462
    " normalized Planck constant, ℏ
    inoremap <a-j>\h <c-v>u210f
    dig \h 8463
    " math pi,ℼ  don't confuse with greek leter π(960)
    inoremap <a-j>/p <c-v>u213c
    dig /p 8508
    " imaginary unit i,ⅈ  don't confuse with english letter i
    inoremap <a-j>/i <c-v>u2148
    dig /i 8520
    " imaginary unit j,ⅉ  don't confuse with english letter j
    inoremap <a-j>/j <c-v>u2149
    dig /j 8521
    " Clesius, ℃ 
    inoremap <a-j>/c <c-v>u2103
    dig /c 8451

    " Miscellaneous 
    " mid dot, ·, don't confuse with dot operator ⋅  
    inoremap <a-j>-. <c-v>u00b7
    dig -. 183
    " ellipses horizontal, …
    inoremap <a-j>.. <c-v>u2026
    dig .. 8230
    " (mathematical) left angle bracket ⟨
    inoremap <a-j>[[ <c-v>u27e8
    dig [[ 10216
    " (methemetical) right angle bracket, ⟩
    inoremap <a-j>]] <c-v>u27e9
    dig ]] 10217 
    " left guillemet, in latin 1 encoding, «, as quotatoin and ditto mark.
    inoremap <a-j>\[ <c-v>u00ab
    dig \[ 171
    " right guillemet, in latin 1 encoding, »
    dig \] 187
    " copyright mark, captital O and c,©.
    " Oc 
    inoremap <a-j>Oc <c-v>u00a9
    dig Oc 169
    " trademark character, ® 
    inoremap <a-j>Or <c-v>u00ae
    dig Or 174

    " only digraph
    " my surname in Chinese, 李, in unified CJK encoding
    inoremap <a-j>li <c-v>u674e
    dig li 26446
    " my given name in Chinese, 昭, in unified CJK encoding
    inoremap <a-j>za <c-v>u662d
    dig za 26157
endif
"  }}}

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
" 
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

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
let g:instant_markdown_slow = 1 "don't update too fast
let g:instant_markdown_autostart = 1 " auto-start preview
"server startup and curl activity is logged in the specified log.
let g:instant_markdown_allow_unsafe_content = 1 "allow scripts.
let g:instant_markdown_allow_external_content = 1 " allow external resource
let g:instant_markdown_logfile = '~/.vim_temp/instant_markdown.log'
let g:instant_markdown_mathjax = 1 " embed latex math in markdown
let g:instant_markdown_browser = "chromium --new-window"
let g:instant_markdown_port = 8999 " default port
let g:instant_markdown_autoscroll = 1 " auto scroll to corresponding cursor location
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
    autocmd FileType python setlocal noexpandtab
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    " autocmd BufEnter *.md setlocal noexpandtab
    " autocmd BufEnter *.md setlocal tabstop=4
    " autocmd BufEnter *.md setlocal shiftwidth=4
    " autocmd BufEnter *.md setlocal softtabstop=4
    autocmd FileType markdown setlocal noexpandtab
    autocmd FileType markdown setlocal tabstop=4
    autocmd FileType markdown setlocal shiftwidth=4
    autocmd FileType markdown setlocal softtabstop=4
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

" Programming enhancement, neomake, neoformat autorun, Hotkeys: F4-12 {{{
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
  \ 'args': ['-Wall', '-Wextra', '-fsyntax-only',
  \ '-fwrapv', '-fno-delete-null-pointer-checks', '-pthread',
  \ '-I', '.', '-I', 'src', '-I', 'include', '-I', '..',
  \ ],
  \ }
let g:neoformat_enabled_c = ['clangformat']
"C++
let g:neomake_cpp_enabled_makers = ['clang', 'cppcheck']
" add -fsyntax-only to supress clang amke *.gch files.
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang',
   \ 'args': ['-Wall', '-Wextra', '-fsyntax-only', 
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
" define the following for cpp, c and java  projects
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

autocmd FileType java nnoremap <silent> <F4> :AsyncRun javac "$(VIM_FILEPATH)" <cr>

" Press F5 run the executable from current file 
autocmd  FileType cpp nnoremap <silent> <F5> :AsyncRun -mode=term -pos=right -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
autocmd  FileType c nnoremap <silent> <F5> :AsyncRun -mode=term -pos=right -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" couldn't make the java command to work with AsyncRun
" autocmd  FileType java nnoremap <silent> <F5> :!java -cp '%:p:h' '%:t:r' <cr>
autocmd  FileType java nnoremap <silent> <F5> :AsyncRun -mode=term -pos=right -raw -cwd=$(VIM_FILEDIR) cd "$(VIM_FILEDIR)/"&&java "$(VIM_FILENOEXT)" <cr>
autocmd  FileType python nnoremap <silent> <F5> :AsyncRun -mode=term -pos=right -raw -cwd=$(VIM_FILEDIR) python "$(VIM_FILEPATH)" <cr>

" Press F6 to Looks up the current line for a header and jumps to it.
" work with c, cpp, objc, objcpp, cuda
autocmd  FileType cpp nnoremap <silent> <F6> :YcmCompleter GoToInclude <cr>
autocmd  FileType c nnoremap <silent> <F6> :YcmCompleter GoToInclude <cr>
autocmd  FileType cuda nnoremap <silent> <F6> :YcmCompleter GoToInclude <cr>

" Press F7 to Looks up the symbol under the cursor and jumps to its declaration.
" Supported in filetypes: c, cpp, objc, objcpp, cuda, cs, go, java, javascript, python, rust, typescript
autocmd  FileType cpp nnoremap <silent> <F7> :YcmCompleter GoToDeclaration <cr>
autocmd  FileType c nnoremap <silent> <F7> :YcmCompleter GoToDeclaration <cr>
autocmd  FileType cuda nnoremap <silent> <F7> :YcmCompleter GoToDeclaration <cr>
autocmd  FileType go nnoremap <silent> <F7> :YcmCompleter GoToDeclaration <cr>
autocmd  FileType java nnoremap <silent> <F7> :YcmCompleter GoToDeclaration <cr>
autocmd  FileType python nnoremap <silent> <F7> :YcmCompleter GoToDeclaration <cr>
autocmd  FileType rust nnoremap <silent> <F7> :YcmCompleter GoToDeclaration <cr>

" Press F8 to kooks up the symbol under the cursor and jumps to its definition
" Supported in filetypes: c, cpp, objc, objcpp, cuda, cs, go, java, javascript, python, rust, typescript
" For C-family languages, only works when the definition is in current TU.
autocmd  FileType cpp nnoremap <silent> <F8> :YcmCompleter GoToDefinition <cr>
autocmd  FileType c nnoremap <silent> <F8> :YcmCompleter GoToDefinition <cr>
autocmd  FileType cuda nnoremap <silent> <F8> :YcmCompleter GoToDefinition <cr>
autocmd  FileType go nnoremap <silent> <F8> :YcmCompleter GoToDefinition <cr>
autocmd  FileType java nnoremap <silent> <F8> :YcmCompleter GoToDefinition <cr>
autocmd  FileType python nnoremap <silent> <F8> :YcmCompleter GoToDefinition <cr>
autocmd  FileType rust nnoremap <silent> <F8> :YcmCompleter GoToDefinition <cr>

" Press F9 to toggle c/cpp and header file
autocmd FileType cpp nnoremap <silent> <F9> :call CurtineIncSw()<CR>
autocmd FileType cpp inoremap <silent> <F9> :call CurtineIncSw()<CR>
autocmd FileType c nnoremap <silent> <F9> :call CurtineIncSw()<CR>
autocmd FileType c inoremap <silent> <F9> :call CurtineIncSw()<CR>

" use F10 toggle quick fix window
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <silent> <F10> :call ToggleQuickFix()<cr>

" for Go-lang semantic engine.
" use gopls for code completion.
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" }}}

" Building, and version control {{{
" define AsyncRun project root markers.
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml', '.project'] 

" let errormarker work with Asyncrun
let g:asyncrun_auto = "make"

" let AsyncRun work with airline 
let g:asyncrun_status = ''
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" let AsyncRun work with vim-fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

" make related custom commands.
" Run "make" asynchronously 
command AsyncMake AsyncRun -cwd=<root> make -j$(nproc) 
" Run "make run" asynchronously.
command AsyncMakeRun AsyncRun -cwd=<root> -mode=term -pos=right -raw make run 
" Run "make test" asynchronously.
command AsyncMakeTest AsyncRun -cwd=<root> -mode=term -pos=right make test
" Run "make clean" asynchronously.
command AsyncMakeClean AsyncRun -cwd=<root> -mode=term -pos=right -raw make clean

" Cmake related custom commands.
" :CMake creates a build directory and generates cmake project
command CMake AsyncRun -cwd=<root> -mode=term -pos=right -raw mkdir -p build&& cd build&& cmake ..
" :CMakeBuild builds current cmake project in subdirectory build.
command CMakeBuild AsyncRun -cwd=<root> cmake --build build -j $(nproc)
" :CMakeInstall install the built project, CMake 3.15+ only
command CMakeInstall AsyncRun -cwd=<root> -mode=term -pos=right -raw cmake --install build 
" :CMakeClean removes the whole build directory
command CMakeClean AsyncRun -cwd=<root> -mode=term -pos=right -raw rm -rf build
" :CMakeTest to run all the test
command CMakeTest AsyncRun -cwd=<root> -mode=term -pos=right -raw cd build& ctest 

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
" Press j and k to enter terminal normal mode.
tnoremap jk <C-\><C-n>
" Press Esc to quit terminal window from insert mode
tnoremap <F1> <C-\><C-n>:q! <cr>

" leave insert mode  with the <RightMouse>-key,  convenient when work iwth
" laptop. 
inoremap <RightMouse> <Esc>

nnoremap rw <Esc>: /\(\<\w\+\>\)\_s*\<\1\><CR>
" type r-w will find repeated words in text.

" press F3 will sync syntax from start
nnoremap <F3> <Esc>:syntax sync fromstart<CR>
inoremap <F3> <C-o>:syntax sync fromstart<CR>

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
