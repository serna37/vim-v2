let mapleader = "\<SPACE>"

" ##################          FILE          ###################
" file
set fileformat=unix " LF
set fileencoding=utf8 " charset
" vim specific
set noswapfile " no create swap file
set nobackup " no create backup file
set noundofile " no create undo file
set hidden " enable go other buffer without save
set autoread " re read file when changed outside vim
set clipboard+=unnamed " copy yanked fot clipboard
" reopen, go row
aug reopenGoRow
    au!
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "norm g`\"" | endif
aug END

" ##################     VISUALIZATION      ###################
" enable syntax highlight
syntax on
" window
set background=dark " basic color
set title " show filename on terminal title
set showcmd " show enterd command on right bottom
" visible
set list " show invisible char
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:% " custom invisible char
" row number + relativenumber
set number relativenumber
" always show sign column width
set signcolumn=yes
" cursor
set scrolloff=5 " page top bottom offset view row
set cursorline cursorcolumn " show cursor line/column
set ruler " show row/col position number at right bottom
" show status, tabline
set laststatus=2 showtabline=2

" ##################         WINDOW        ###################
set splitright
" buffer move / close
nnoremap <C-n> <Plug>(buf-prev)
nnoremap <C-p> <Plug>(buf-next)
nnoremap <Leader>x <Plug>(buf-close)
nnoremap <Leader>t :cal popup_create(term_start([&shell],#{hidden:1,term_finish:'close'}),#{border:[],minwidth:&columns*3/4,minheight:&lines*3/4})<CR>
nnoremap <Leader>g :cal popup_create(term_start(['lazygit'],#{hidden:1,term_finish:'close'}),#{border:[],minwidth:&columns*3/4,minheight:&lines*3/4})<CR>
nnoremap <Leader>z :Goyo<CR>

" ##################         MOTION         ###################
" row move
nnoremap j gj
nnoremap k gk
vnoremap <Tab> 5gj
vnoremap <S-Tab> 5gk
nnoremap <Tab> 5j<Plug>(anchor)
nnoremap <S-Tab> 5k<Plug>(anchor)
nnoremap H H<Plug>(anchor)
nnoremap M M<Plug>(anchor)
nnoremap L L<Plug>(anchor)
nnoremap <C-j> <Plug>(edgemotion-j)
nnoremap <C-k> <Plug>(edgemotion-k)
nnoremap <leader>w <Plug>(QuickScopeToggle)
nnoremap <Leader>m :CocCommand fzf-preview.Bookmarks<CR>
nnoremap <Leader>v <Plug>(ide-menu)

" ##################         EDIT           ###################
" basic
set virtualedit=all " virtual cursor movement
set whichwrap=b,s,h,l,<,>,[,],~ " motion over row
set backspace=indent,eol,start " backspace attitude on insert mode
" parentheses
set showmatch " jump pair of parentheses when write
set matchtime=3 " jump term sec
" return normal & save
inoremap jj <Esc>:w<CR>
" row visual
nnoremap vv ^v$h
" save
nnoremap <C-s> :w<CR>
" move cursor at insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-k> <C-o>k
inoremap <C-j> <C-o>j
inoremap <C-a> <C-o>A
" d = delete(no clipboard)
nnoremap d "_d
vnoremap d "_d
" x = cut(yank register)
nnoremap x "+x
vnoremap x "+x
" p P = paste(from yank register)
nnoremap p "+p
nnoremap P "+P
vnoremap p "+p
vnoremap P "+P
" block move at visual mode
vnoremap <C-j> "zx"zp`[V`]
vnoremap <C-k> "zx<Up>"zP`[V`]

" ##################       COMPLETION       ###################
" indent
set autoindent " uses the indent from the previous line
set smartindent " more smart indent than autoindent
set smarttab " use shiftwidth
set shiftwidth=4 " auto indent width
set tabstop=4 " view width of Tab
set expandtab " Tab to Space
" word
set wildmenu " command mode completion enable
set wildchar=<Tab> " command mode comletion key
set wildmode=full " command mode completion match mode
set complete=.,w,b,u,U,k,kspell,s,i,d,t " insert mode completion resource
set completeopt=menuone,noinsert,preview,popup " insert mode completion window
" completion with Tab
inoremap <expr><CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap <expr><Tab> pumvisible() ? '<C-n>' : '<C-t>'
inoremap <expr><S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'

" ##################         SEARCH         ###################
" search
set incsearch " incremental search
set hlsearch " highlight match words
set ignorecase " ignore case search
set smartcase " don't ignore case when enterd UPPER CASE"
set shortmess-=S " show hit word's number at right bottom
nnoremap # *N<Plug>(quickhl-manual-this)
nnoremap <silent><Leader>q <Plug>(quickhl-manual-reset):noh<CR>
nnoremap s <Plug>(easymotion-sn)
nnoremap <Leader>s :CocCommand fzf-preview.Lines<CR>
nnoremap <Leader>e :CocCommand explorer --width 30<CR>
nnoremap <Leader>f :CocCommand fzf-preview.ProjectFiles<CR>
nnoremap <Leader>b :CocCommand fzf-preview.Buffers<CR>
nnoremap <Leader>h :CocCommand fzf-preview.MruFiles<CR>
nnoremap <Leader><Leader>s :CocCommand fzf-preview.ProjectGrep 

" ##################         OTHERS         ###################
" basic
scriptencoding utf-8 " this file's charset
set ttyfast " fast terminal connection
set regexpengine=0 " chose regexp engin
" fold
set foldmethod=marker " fold marker
set foldlevel=0 " fold max depth
set foldlevelstart=5 " fold depth on start view
set foldcolumn=1 " fold preview


" ############################################################
" #### PLUGIN MANAGE
" ############################################################
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'simeji/winresizer'
Plug 'yuttie/comfortable-motion.vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/vim-edgemotion'
Plug 'rhysd/clever-f.vim'
Plug 'unblevable/quick-scope'
Plug 't9md/vim-quickhl'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'junegunn/goyo.vim'
Plug 'markonm/traces.vim'
Plug 'thinca/vim-quickrun'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" coc extentions
let s:coc_extensions = [
    \ 'coc-explorer',
    \ 'coc-snippets',
    \ 'coc-fzf-preview',
    \ 'coc-sh',
    \ 'coc-vimlsp',
    \ 'coc-json',
    \ 'coc-sql',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-clangd',
    \ 'coc-go',
    \ 'coc-pyright',
    \ 'coc-java'
    \ ]

let s:coc_config = ['{',
    \ '    "snippets.ultisnips.pythonPrompt": false,',
    \ '    "explorer.icon.enableNerdfont": true,',
    \ '    "explorer.file.showHiddenFiles": true,',
    \ '    "python.formatting.provider": "yapf",',
    \ '    "pyright.inlayHints.variableTypes": false',
    \ '}',
    \]

" to disable inlay hint in clangd, create file
" mkdir -p ~/Library/Preferences/clangd && vi ~/Library/Preferences/clangd/config.yaml
" InlayHints:
"  Enabled: No

fu! CocSetup() abort
    exe 'CocInstall '.join(s:coc_extensions, ' ')
    cal writefile(s:coc_config, $HOME.'/.vim/coc-settings.json')
endf

com! CocSetupAll cal CocSetup()

" comfortable motion -----------------------
let g:comfortable_motion_interval = 1000.0 / 60
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 5.0

" cleaver-f --------------------------------
let g:clever_f_smart_case = 1
aug cleaver_f
    au!
    au ColorScheme * highlight CleverFDefaultLabel cterm=bold,underline ctermfg=9 ctermbg=245
aug END

" quick scope ------------------------------
aug qs_colors
  au!
  au ColorScheme * highlight QuickScopePrimary ctermfg=204 cterm=underline
  au ColorScheme * highlight QuickScopeSecondary ctermfg=81 cterm=underline
aug END

" airline ----------------------------------
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1

fu! s:moveBuf(flg) abort
    let current_id = ''
    let buf_arr = []
    for v in split(execute('ls'), '\n')->map({ _,v -> split(v, ' ')})
        let x = copy(v)->filter({ _,v -> !empty(v) })
        if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
            cal add(buf_arr, x[0])
            if stridx(x[1], '%') != -1
                let current_id = x[0]
            endif
        endif
    endfor
    let buf_idx = a:flg == 'next' ? match(buf_arr, current_id) + 1 : match(buf_arr, current_id) - 1
    let buf_id = buf_idx == len(buf_arr) ? buf_arr[0] : buf_arr[buf_idx]
    exe 'b '.buf_id
endf

fu! s:closeBuf() abort
    let now_b = bufnr('%')
    cal s:moveBuf('prev')
    execute('bd ' . now_b)
endf

noremap <silent><Plug>(buf-prev) :<C-u>cal <SID>moveBuf('prev')<CR>
noremap <silent><Plug>(buf-next) :<C-u>cal <SID>moveBuf('next')<CR>
noremap <silent><Plug>(buf-close) :<C-u>cal <SID>closeBuf()<CR>

" coc.nvim --------------------------------
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
autocmd CursorHold * silent cal CocActionAsync('highlight')
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
nnoremap <Leader>d <Plug>(coc-definition)
nnoremap <Leader>r :CocCommand fzf-preview.CocReferences<CR>
nnoremap <Leader>o :CocCommand fzf-preview.CocOutline<CR>
nnoremap <Leader>? :cal CocAction('doHover')<CR>
nnoremap <Leader>, <plug>(coc-diagnostic-next)
nnoremap <Leader>. <plug>(coc-diagnostic-prev)
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" ultisnips --------------------------------
" TODO なんか変
"let g:UltiSnipsExpandTrigger="<Down>"

" ################# Anchor #################
" Tab 5row Anchor
aug anchor_color
    au!
    au ColorScheme * hi DarkRed ctermfg=204
    au ColorScheme * hi DarkOrange ctermfg=180
    au ColorScheme * hi DarkBlue ctermfg=39
aug END
sign define anch text=➤ texthl=DarkRed
let s:anc_tid = 0
fu! s:anchor_set() abort
    cal timer_stop(s:anc_tid)
    cal sign_unplace('anchor')
    let l = line('.')
    let lines = l-5 > 0 ? [l-5, l, l+5] : [l, l+5]
    for v in lines
        cal sign_place(0, 'anchor', 'anch', bufname('%'), #{lnum: v})
    endfor
    let s:anc_tid = timer_start(2000, { tid -> sign_unplace('anchor') })
endf
noremap <silent><Plug>(anchor) :<C-u>cal <SID>anchor_set()<CR>

" ################# IDE #################
" IDE menu
let s:idemenu = #{
    \ menuid: 0, mttl: ' IDE MENU (j / k) Enter choose ',
    \ menu: [
        \ '[⚙️  Test]         test by oj cmd',
        \ '[Format]          applay format for this file',
        \ '[ReName]          rename current word recursively',
        \ '[🚀 ContestCode]  checkout contest code',
        \ '[Snippet]         edit snippets',
        \ '[⏱️ AcTimer]      start timer for AtCoder ',
        \ '[🔓 AcStop]       stop timer for AtCoder',
        \ '[🎬 All Cut]      cut all & next Problem ',
    \ ],
    \ cheatid: 0, cheattitle: ' LSP KeyMaps ',
    \ cheat: [
        \ ' (Space d) [Definition]     Go to Definition ',
        \ ' (Space r) [Reference]      Reference ',
        \ ' (Space o) [Outline]        view outline on popup ',
        \ ' (Space ?) [Document]       show document on popup scroll C-f/b ',
        \ ' (Space ,) [Next Diagnosis] jump next diagnosis ',
        \ ' (Space .) [Prev Diagnosis] jump prev diagnosis ',
    \ ],
    \ }

fu! s:idemenu.open() abort
    let self.menuid = popup_menu(self.menu, #{title: self.mttl, border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ callback: 'Idemenu_exe'})
    cal setwinvar(self.menuid, '&wincolor', 'String')
    cal matchadd('DarkRed', '\[.*\]', 16, -1, #{window: self.menuid})
    let self.cheatid = popup_create(self.cheat, #{title: self.cheattitle, line: &lines-5, border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰']})
    cal setwinvar(self.cheatid, '&wincolor', 'String')
    cal matchadd('DarkRed', '\[.*\]', 16, -1, #{window: self.cheatid})
    cal matchadd('DarkBlue', '(.*)', 16, -1, #{window: self.cheatid})
endf


fu! Idemenu_exe(_, idx) abort
    if a:idx == 1
        " ❯ python3 -m pip install online-judge-tools
        let contest_txt = readfile('contest_setting.txt')[0]
        cal popup_notification(['contest_setting : '.contest_txt], #{border:[], zindex:999, line: &lines-30, col: &columns-40, time:2000})
        let work_dir = '~/work/ac_cpp'
        let test_cmd = 'g++ -std=c++20 main.cpp && oj t'
        let contest_cd = split(contest_txt, '_')[0]
        let pre = 'cd '.work_dir.' && rm -rf test && oj d https://atcoder.jp/contests/'.contest_cd.'/tasks/'.contest_txt
        cal system(pre)
        let cmd = 'cd '.work_dir.' && '.test_cmd
        let s:ac_test_winid = bufwinid('ac_test')
        if s:ac_test_winid == -1
            sil! exe 'vne ac_test'
        else
            call win_gotoid(s:ac_test_winid)
            exe '%d'
        endif
        setl buftype=nofile bufhidden=wipe modifiable
        setl nonumber norelativenumber nocursorline nocursorcolumn signcolumn=no
        setl filetype=log
        cal matchadd('DarkBlue', 'SUCCESS')
        sil! exe 'r!'.cmd
        let s:test_timer_id = timer_start(200, {tid -> s:ac_test_timer(tid)}, { 'repeat' : 10 })
    elseif a:idx == 2
        cal CocActionAsync('format')
    elseif a:idx == 3
        cal CocActionAsync('rename')
    elseif a:idx == 4
        echohl DarkBlue
        let code = input('AtCode Contest Code :', readfile('contest_setting.txt')[0])
        echohl None
        cal writefile([code], 'contest_setting.txt')
        cal popup_notification(['contest_setting : '.code], #{border:[], zindex:999, line: &lines-30, col: &columns-40, time:2000})
    elseif a:idx == 5
        exe 'CocList snippets'
    elseif a:idx == 6
        cal s:atcoder_timer_start()
    elseif a:idx == 7
        cal s:atcoder_timer_stop()
    elseif a:idx == 8
        exe '%d'
        exe 'w'
        let alp = #{a:'b',b:'c',c:'d',d:'e',e:'f',f:'g'}
        let contest_txt = readfile('contest_setting.txt')[0]
        let contest_cd = split(contest_txt, '_')[0]
        let question_cd = split(contest_txt, '_')[1]
        let next = contest_cd.'_'.get(alp, question_cd, '')
        cal writefile([next], 'contest_setting.txt')
        cal popup_notification(['contest_setting : '.next], #{border:[], zindex:999, line: &lines-30, col: &columns-40, time:2000})
    endif
    cal popup_close(s:idemenu.cheatid)
    retu 0
endf

fu! s:idemenu() abort
    cal s:idemenu.open()
endf
noremap <silent><Plug>(ide-menu) :<C-u>cal <SID>idemenu()<CR>


" AtCoder用テストsuccess時のベル
let s:test_timer_id = 0
let s:ac_test_winid = -1
fu! s:ac_test_timer(tid) abort
    for i in getline(0, line("$"))
        if match(i, "test success") != -1
            cal s:bell_hero()
            cal timer_stop(a:tid)
            retu
        endif
    endfor
endf

fu! s:bell_hero() abort
    cal job_start(["/bin/zsh","-c","afplay /System/Library/Sounds/Hero.aiff"])
endf
fu! s:bell_submarine() abort
    cal job_start(["/bin/zsh","-c","afplay /System/Library/Sounds/Submarine.aiff"])
endf

" AtCoder用100分タイマー
let s:actimer_sec = 0
let s:actimer_view = ['000:00']
let s:actimer_pid = -1
let s:actimer_tid = -1

fu! s:atcoder_timer_start() abort
    let s:actimer_sec = 0
    let s:actimer_view = ['000:00']
    cal timer_stop(s:actimer_tid)
    cal popup_close(s:actimer_pid)
    let s:actimer_pid = popup_create(s:actimer_view, #{
        \ zindex: 99, mapping: 0, scrollbar: 1,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'], borderhighlight: ['DarkBlue'],
        \ line: &lines-10, col: 10,
        \ })
    let s:actimer_tid = timer_start(1000, { tid -> s:atcoder_timer(tid) }, { 'repeat' : -1 })
endf

fu! s:atcoder_timer_stop() abort
    cal timer_stop(s:actimer_tid)
    cal popup_close(s:actimer_pid)
endf

fu! s:atcoder_timer(tid) abort
    let s:actimer_sec += 1
    " bell at 1min, 3min, 8min, 18min, 40min
    if s:actimer_sec==60 || s:actimer_sec==180 || s:actimer_sec==480 || s:actimer_sec==1080 || s:actimer_sec==2400
        cal s:bell_submarine()
    endif
    " bell every 20min
    if s:actimer_sec>2400 && s:actimer_sec%1200==0
        cal s:bell_submarine()
    endif
    " LPAD 0埋め
    let minutes = s:actimer_sec / 60
    let minutes = minutes < 10 ? '00'.minutes : '0'.minutes
    let seconds = s:actimer_sec % 60
    if seconds < 10
        let seconds = '0'.seconds
    endif
    " view
    let s:actimer_view = [minutes.':'.seconds]
    cal setbufline(winbufnr(s:actimer_pid), 1, s:actimer_view)
    if s:actimer_sec > 5400
        cal matchadd('DarkRed', '[^ ]', 16, -1, #{window: s:actimer_pid})
    endif
endf

" startify -------------------------------
let s:start = #{}

" ぼっちざろっく{{{
let s:start.btr_logo = [
    \'                                                                                                                                              dN',
    \'                                                                                                              ..                             JMF',
    \'                                                                                                         ..gMMMM%                           JMF',
    \'                                                                                                       .MM9^ .MF                           (MF',
    \'                                                                                              .(,      ("   .M#                  .g,      .MF',
    \'                                        .,  dN                                             gg,,M@          .M#                  .M#!      (M>',
    \'                                        JM} M#             .MNgg.                     .g,  ?M[ 7B         .MMg+gg,.           .MM"        ."',
    \'                                ...gNMN,.Mb MN           .gMM9!                      .(MN,  .=           .MMM9=  ?MN,         (WN,      .MM ',
    \'                   jN-      ..gMMN#!     (Mp(M}       .+MMYMF                    ..kMMWM%               ,M#^       dN.          .WNJ,   JM',
    \'                   MM     .MM9^  dN,                 dNB^ (M%                   ?M"!  ,M\        .,               .M#   .&MMMN,    ?"   M#',
    \'                   MN            .MN#^                    dM:  ..(J-,                 ,B         .TM             .M#   ,M@  .MF',
    \'                   MN.       ..MMBMN_                     dN_.MM@"!?MN.   TMm     .a,                           (M@         MM^',
    \'                   MN.     .MM"  JMb....       ..        dMMM=     .Mb            ?HNgJ..,                   .MM^',
    \'                   dM{          -MMM#7"T""   .dN#TMo       ?      .MM^                 ?!                 +gM#=',
    \'                   (M]         .MN(N#       .M@  .MF              .MM^                                      ~',
    \'                   .MN          ?"""             MM!            .MMD',
    \'                    ?N[                                         7"',
    \'                     TMe',
    \'                      ?MN,',
    \'                        TMNg,'
    \]
"}}}

" AtCoder{{{
let s:start.ac_logo = [
    \'                                                                           .',
    \'                                                                         .dN.',
    \'                                                                      ..d@M#J#(,',
    \'                                                                   vRMPMJNd#dbMG#(F',
    \'                                                         (O.  U6..  WJNdPMJFMdFdb#`  .JU` .Zo',
    \'                                                      .. +NM=(TB5.-^.BMDNdJbEddMd ,n.?T@3?MNm  ..',
    \'                                                     .mg@_J~/?`.a-XNxvMMW9""TWMMF.NHa._ ?_,S.Tmg|',
    \'                                                  .Js ,3,`..-XNHMT"= ...d"5Y"X+.. ?"8MNHHa.. (,b uZ..',
    \'                                                 J"17"((dNMMB"^ ..JTYGJ7"^  ?"T&JT9QJ..?"TMNNHa,?727N',
    \'                                                 .7    T"^..JT"GJv"=`             ?"4JJT9a.,?T"`  .7!',
    \'                                                         M~JY"!     ....<.Zj+,(...     .7Ta_M',
    \'                                             .JWkkWa,    d-F     .+;.ge.ga&.aa,ua+.g,     ,}#    .(Wkkkn,',
    \'                                            .W9AaeVY=-.. J;b   .XH3dHHtdHHDJHHH(HHH(WH,   J(F  ..?T4agdTH-',
    \'                                             6XkkkH=!    ,]d  .HHtdHHH.HHHbJHHH[WHHH(HHL  k.]    _7HkkkHJ:',
    \'                                             JqkP?H_      N(; TYY?YYY9(YYYD?YYYt7YYY\YY9 .Fd!     .WPjqqh',
    \'                                             .mmmH,``      d/b WHHJHH@NJHHH@dHHHFdHHHtHH#`.1#       `(dqqq]',
    \'                                            ,gmmgghJQQVb  ,bq.,YY%7YYY(YYY$?YYY^TYYY(YY^ K.]  JUQmAJmmmmg%',
    \'                                             ggggggggh,R   H,]  T#mTNNbWNN#dNN#(NN@(N@! .t#   d(Jgggggggg:',
    \'                                            .@@@@@#"_JK4,  ,bX.   ?i,1g,jge.g2+g2i,?`   K.t  .ZW&,7W@@@@@h.',
    \'                                        `..H@@@@@P   7 .H`  W/b        .^."?^(!        -1#   W, ?   T@@@@@Ma,`',
    \'                                        dH@HHHM"       U\   .N,L        ..            .$d    .B`     ."MHHH@HN.',
    \'                                   ....JMHHHHH@              ,N(p      .dH.d"77h.    .$J\              dHHHHHMU....',
    \'                                  ` WHH#,7MHHM{               ,N,h     d^.W,        .^J^               .MHHM"_d#HN.',
    \'                                   ,jH#Mo .MMW:                .W,4,  J\   Ta.-Y` .J(#                 .HMM- .M#MF!',
    \'                                     .MN/ d@?M+                  7e(h.           .3.F                  .MDd# (MML`',
    \'                                     .M4%  ?H, 7a,                .S,7a.       .Y.#^                .,"`.d=  ,PWe',
    \'                                    .! ?     dN .N,                 (N,7a.   .Y(d=                 .d! d@     4 .!',
    \'                                             .W` .!                   ?H,?GJ".d"                    ^  B',
    \'                                                                        (SJ.#=',
    \'                                                       J             ....            .M:',
    \'                                                      JUb     .   .#    (\            M~',
    \'                                                     .\.M;  .W@"` M}       .y7"m. .J"7M~ .v74e ,M7B',
    \'                                                    .F  ,N.  J]   M]       M)  JF M_  M~ d-     M`',
    \'                                                   .W,  .db, Jh.   Th...J\ /N..Y` ?N-.Ma.-M&.> .M-',
    \]
"}}}

let g:startify_custom_header = s:start.btr_logo
com! AtCoderLogo cal AtCoderLogo()
fu! AtCoderLogo() abort
    let g:startify_custom_header = s:start.ac_logo
endf


" onedark ---------------------------------
colorscheme onedark

