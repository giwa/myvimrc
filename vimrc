"------------------------------------------------------------
 " General preference
 "------------------------------------------------------------
" set noswapfile            " スワップファイルをつくらない
 set nocompatible          " vi互換モードをオフ（vimの拡張機能を有効)
 set hidden                " 編集中でも、保存しないで他のファイルを開けるようにする
 set confirm               " ファイルを保存していない場合に、ファイルの保存を確認するダイアログを出す
 set cmdheight=2           " 画面下部に表示されるコマンドラインの高さの設定
 set showcmd               " 入力したコマンドをステータスライン上に表示  例えばdを入力したらdと表示される
 set scrolloff=5           " カーソルの上または下に表示される最小限の行数  5に設定してあるので、下に5行は必ず表示される
 set visualbell            " ビープの代わりにビジュアルベル（画面フラッシュ）を使う
 set vb t_vb=              " ビープを鳴らさない
 set mouse=a               " 全モードでマウスを有効化
 set autowrite
 " キーコードはすぐにタイムアウト  マッピングはタイムアウトしない
 set notimeout ttimeout ttimeoutlen=200

 "------------------------------------------------------------
 " Color
 "------------------------------------------------------------
 syntax enable " ハイライトを有効化
 syntax on     " ハイライトを有効化
 set t_Co=256
 set background=dark
 colorscheme solarized

 highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
 match OverLength /\%>80v.\+/
 highlight OverLength ctermbg=red ctermfg=white
 match OverLength /\%81v.\+/
 set cc=80
 :hi ColorColumn ctermbg=234


 "------------------------------------------------------------
 " Status line
 "------------------------------------------------------------
 set laststatus=2 " ステータスラインを常に表示する
 set ruler        " ステータスライン上にルーラーを表示する（カーソルが何行目の何列目に置かれているか）

 " [ファイルフォーマット][エンコーディング][改行タイプ] 行数, 列数／総列数
 set statusline=%F%m%r%h%w\%=[FILETYPE=%Y][ENC=%{&fenc}][%{&ff}]%=%c,\%l/%L

let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

 highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
 match OverLength /\%>80v.\+/
 highlight OverLength ctermbg=red ctermfg=white
 match OverLength /\%81v.\+/
 set cc=80
 execute "set colorcolumn=" . join(range(81,335), ',')
 :hi ColorColumn ctermbg=234

 let mapleader=","
 inoremap <leader>, <C-x><C-o>

 "------------------------------------------------------------
 " Indent
 "------------------------------------------------------------
 set autoindent     " オートインデント
 set smartindent    " 新しい行を開始した時に、新しい行のインデントを現在行と同じ量にする
 set cindent        " Cプログラムの自動インデント
 set expandtab      " タブキーを空白に変換

 " オートインデント、改行、インサートモード開始直後にバックスペースキーで削除できるようにする
 set backspace=indent,eol,start

 " softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
 set tabstop=4 shiftwidth=4 softtabstop=0

 " MEMO
 " autoindent  : 改行時に半角スペース8文字を挿入する
 " smartindent : 新しい行をつくったときに高度な自動インデントを行う  cindentがONだと無効化される
 " tabstop     : タブ文字の幅を設定する  デフォルトは8
 " expandtab   : TABキー入力時に、タブ文字の代わりにスペースにする
 " softtabstop : タブ文字を入力した際にタブ文字の代わりに挿入されるホワイトスペースの量を設定する  shiftwidthと同じ値にすると良い
 " shiftwidth  : 「>>」等のコマンドや自動インデントの際に使う1レベル分のインデント量を設定する  tabstopと同じ値にすると良い


 "------------------------------------------------------------
 " Display
 "------------------------------------------------------------
 set number     " 行番号を表示
 set showmatch  " カッコの対応をハイライト
 set cursorline " カーソル行のハイライト
 "set list       " 不可視文字の表示
 "set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

 " Hilight full width space
 " ref: http://code-life.net/?p=2704
 function! ZenkakuSpace()
   highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
 endfunction

 if has('syntax')
   augroup ZenkakuSpace
     autocmd!
     autocmd ColorScheme       * call ZenkakuSpace()
     autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
   augroup END
   call ZenkakuSpace()
 endif


 "------------------------------------------------------------
 " Complision
 "------------------------------------------------------------
 set wildmenu       " コマンドラインモードでTABキーによる補完を有効化
 set wildchar=<tab> " コマンド補完を開始するキー
 set history=1000   " コマンド・検索パターンの履歴数
 set wildmode=list:longest,full

 " wildmodeのオプション色々
 " [none]       最初のマッチのみを補完する。
 " full         次のマッチを完全に補完する。最後のマッチの次には元の文字列が使われ、その次は再び最初のマッチが補完される
 " longest      共通する最長の文字列までが補完される。それ以上長い文字列を補完できないときは、次の候補に移る
 " longest:full longestと似ているが、'wildmenu' " が有効ならばそれを開始する
 " list"        複数のマッチがあるときは、全てのマッチを羅列する。
 " list:full    複数のマッチがあるときは、全てのマッチを羅列し、最初のマッチを補完する
 " list:longest 複数のマッチがあるときは、全てのマッチを羅列し、共通する最長の文字列までが補完される


 "------------------------------------------------------------
 " Search
 "------------------------------------------------------------
 set wrapscan   " 最後まで検索したら先頭に戻る
 set ignorecase " 大文字小文字を無視する
 set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
 set hlsearch   " 検索語を強調表示
 set incsearch  " インクリメンタルサーチを有効化




 "------------------------------------------------------------
 " Key map
 "------------------------------------------------------------
 " Escの2回押しでハイライト消去
 nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
 inoremap <C-j> <Esc>
 inoremap <silent> jj <ESC>
 inoremap <silent> hh <ESC>
 inoremap <silent> kk <ESC>
 " inoremap <silent> ll <ESC>
 map <C-n> :NERDTreeToggle<CR>
 " Delete in insert mode
 inoremap <C-x> <BS>


 "------------------------------------------------------------
 " Moving
 "------------------------------------------------------------
 set nostartofline " 移動コマンドを使ったとき、行頭に移動しない


 "------------------------------------------------------------
 " Encoding
 "------------------------------------------------------------
 set ffs=unix,dos,mac   " 改行文字
 set encoding=utf-8     " デフォルトエンコーディング
 set fileencodings=utf-8

 "------------------------------------------------------------
 " Others
 "------------------------------------------------------------
 " Yの動作をDやCと同じにする
 map Y y$

 " マッピングに関するMEMO
 " noreがつくものとつかないものの違い（mapとnoremapとか）
 " noreがつかないものを使うと、キーの再割当てが発生する
 " -> mapはキーシーケンスを展開した後、さらに別のマップを適用しようとする
 " -> noremapは一度だけ展開する
 " (例)
 " map {A} {X}
 " map {B} {A}
 " 上のようにマッピングされていた場合、Bを押すとAが実行され、さらにAに割り当てられたXが実行される
 " noremapだとマッピングを1度しか展開しない  混乱を避けるためにnore系を利用するのが無難かも

 " noremap  : ノーマルモード＋ビジュアルモード
 " noremap! : コマンドラインモード＋インサートモード
 " nnoremap : ノーマルモード限定
 " vnoremap : ビジュアルモード（選択モード）限定
 " cnoremap : コマンドラインモード限定
 " inoremap : 挿入モード限定


 " go
 let g:go_disable_autoinstall = 0

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""



 "------------------------------------------------------------
 " Plugin
 "------------------------------------------------------------
 filetype plugin on
 nmap <F9> :TagbarToggle<CR>
 map <C-n> :NERDTreeToggle<CR>

 " vim indent guide
 let g:indent_guides_auto_colors = 0
 hi IndentGuidesOdd  ctermbg=white
 hi IndentGuidesEven ctermbg=lightgrey

 "------------------------------------------------------------
 " Go
 "------------------------------------------------------------
 let g:go_disable_autoinstall = 0
 let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
 \ }


 "------------------------------------------------------------
 " NeoBundle
 "------------------------------------------------------------
 " Note: Skip initialization for vim-tiny or vim-small.
 "
 let g:neocomplete#enable_at_startup = 1

 if 0 | endif

 if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!
 NeoBundle 'Shougo/neocomplete.vim'
 NeoBundle 'majutsushi/tagbar.git'
 NeoBundle 'fatih/vim-go.git'
 NeoBundle 'scrooloose/nerdtree.git'
 NeoBundle 'othree/html5.vim'          " html5のタグのカラー
 NeoBundle 'kchmck/vim-coffee-script'
 NeoBundle 'zhaocai/GoldenView.Vim' "Always have a nice view for vim split windows
 NeoBundle 'derekwyatt/vim-scala' "syntax for scala
 NeoBundle 'bronson/vim-trailing-whitespace'
 NeoBundle 'nathanaelkane/vim-indent-guides'


 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck
