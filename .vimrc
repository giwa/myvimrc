"------------------------------------------------------------
 " 基本設定
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
 " ステータスライン
 "------------------------------------------------------------
 set laststatus=2 " ステータスラインを常に表示する
 set ruler        " ステータスライン上にルーラーを表示する（カーソルが何行目の何列目に置かれているか）

 " [ファイルフォーマット][エンコーディング][改行タイプ] 行数, 列数／総列数
 set statusline=%F%m%r%h%w\%=[FILETYPE=%Y][ENC=%{&fenc}][%{&ff}]%=%c,\%l/%L

 " MEMO
 " powerlineというプラグインを入れるとステータスラインを強化できるようだ


 "------------------------------------------------------------
 " インデント
 "------------------------------------------------------------
 set autoindent     " オートインデント
 set smartindent    " 新しい行を開始した時に、新しい行のインデントを現在行と同じ量にする
 set cindent        " Cプログラムの自動インデント
 set expandtab      " タブキーを空白に変換

 " オートインデント、改行、インサートモード開始直後にバックスペースキーで削除できるようにする
 set backspace=indent,eol,start

 " softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
 set tabstop=2 shiftwidth=2 softtabstop=0

 "filetype plugin on " ファイルタイプの検索を有効にする
 "filetype indent on " ファイルタイプに合わせたインデントを利用する

 " MEMO
 " autoindent  : 改行時に半角スペース8文字を挿入する
 " smartindent : 新しい行をつくったときに高度な自動インデントを行う  cindentがONだと無効化される
 " tabstop     : タブ文字の幅を設定する  デフォルトは8
 " expandtab   : TABキー入力時に、タブ文字の代わりにスペースにする
 " softtabstop : タブ文字を入力した際にタブ文字の代わりに挿入されるホワイトスペースの量を設定する  shiftwidthと同じ値にすると良い
 " shiftwidth  : 「>>」等のコマンドや自動インデントの際に使う1レベル分のインデント量を設定する  tabstopと同じ値にすると良い


 "------------------------------------------------------------
 " 表示
 "------------------------------------------------------------
 set number     " 行番号を表示
 set showmatch  " カッコの対応をハイライト
 set cursorline " カーソル行のハイライト
 "set list       " 不可視文字の表示
 "set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

 " 全角スペースのハイライト表示
 " 参考：http://code-life.net/?p=2704
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

 " MEMO
 " 不可視文字とはタブ文字や行末文字のことを指す

 "------------------------------------------------------------
 " 補完
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
 " タグ
 "------------------------------------------------------------
 " とりあえず何もしない


 "------------------------------------------------------------
 " 検索
 "------------------------------------------------------------
 set wrapscan   " 最後まで検索したら先頭に戻る
 set ignorecase " 大文字小文字を無視する
 set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
 set hlsearch   " 検索語を強調表示
 set incsearch  " インクリメンタルサーチを有効化

 " Escの2回押しでハイライト消去
 nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

 " MEMO
 " incsearch : " インクリメンタルサーチとは「検索文字列を入力完了する前に、入力中の文字列にマッチしている場所へ移動する」機能


 "------------------------------------------------------------
 " 移動
 "------------------------------------------------------------
 set nostartofline " 移動コマンドを使ったとき、行頭に移動しない

 " インサートモードでもhjklで移動（Ctrlを押しながら）
 inoremap <C-j> <Down>
 inoremap <C-k> <Up>
 inoremap <C-h> <Left>
 inoremap <C-l> <Right>

 " インサートモードでも削除
 inoremap <C-x> <BS>

 "------------------------------------------------------------
 " カラー
 "------------------------------------------------------------
 syntax enable " ハイライトを有効化
 syntax on     " ハイライトを有効化

 "------------------------------------------------------------
 " 編集
 "------------------------------------------------------------
 " とりあえず何もしない

 "------------------------------------------------------------
 " エンコーディング
 "------------------------------------------------------------
 set ffs=unix,dos,mac   " 改行文字
 set encoding=utf-8     " デフォルトエンコーディング
 set fileencodings=utf-8

 "------------------------------------------------------------
 " その他
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


 "------------------------------------------------------------
 " プラグイン
 "------------------------------------------------------------
 " molokai.vim
 let g:molokai_original = 1
 set t_Co=256
 colorscheme molokai

 " neocomplcache
 let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化

 " coffee script
 autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!

 " unite.vim
 " 入力モードで開始する
 let g:unite_enable_start_insert=0

 " ctrlp
 let g:ctrolp_use_migemo    = 1 " ミゲモ検索
 let g:ctrlp_jump_to_buffer = 2 " タブで開かれた場合はそのタブに切り替える
 let g:ctrlp_open_new_file  = 1 " 新規作成時にタブで開く

 " NeoBundle
 filetype off

if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 call neobundle#rc(expand('~/.vim/bundle/'))

 " originalrepos on github
 NeoBundle 'Shougo/neobundle.vim'      " プラグイン管理

 NeoBundle 'Shougo/vimproc'

 NeoBundle 'Shougo/vimproc'            " 非同期処理のため
 NeoBundle 'VimClojure'                " vimにおけるクロージャの開発環境
 NeoBundle 'Shougo/vimshell'           " vimからシェルを起動する
 NeoBundle 'Shougo/unite.vim'          " vim上で使用出来る統合ユーザーインターフェース
 NeoBundle 'Shougo/neocomplcache'      " 補完
 NeoBundle 'Shougo/neosnippet'         " スニペット
 NeoBundle 'jpalardy/vim-slime'        " ??
 NeoBundle 'mattn/zencoding-vim'       " zencodingプラグイン
 NeoBundle 'othree/html5.vim'          " html5のタグのカラー
 NeoBundle 'Townk/vim-autoclose'       " カッコやダブルコーテーションを自動で閉じる
 NeoBundle 'kien/ctrlp.vim.git'        " コマンドラインでのファイル補完
 "NeoBundle 'scrooloose/syntastic.git' " シンタックスのチェック（重たくなるようなのでとりあえず解除）
 NeoBundle 'tpope/vim-pathogen'        " プラグイン管理
 NeoBundle 'thinca/vim-quickrun'       " 各種ソースコードをすばやく実行
 NeoBundle 'scrooloose/nerdcommenter'  " コメントアウト<Leader>c<Space> コメントアウト解除<Leadar>cu

 filetype plugin indent on     " required
