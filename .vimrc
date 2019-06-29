"-------------------------------
" 覚えておくと便利なTips
"-------------------------------
" INSERT mode で Ctrl+p : 入力補完

"-------------------------------
" Vim Tab 設定
" refs http://qiita.com/wadako111/items/755e753677dd72d8036d
"-------------------------------
" tc     : create new tab
" tx     : close tab
" tn     : next tab
" tp     : previous tab
" t1..t9 : jump Nth from the left
"-------------------------------
source ~/.vim/vim_tab.vim

"-------------------------------
" 基本設定
"-------------------------------
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set number
set title
set ambiwidth=double
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set clipboard=unnamed             "OSのクリップボードを使用する
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set nrformats-=octal
set hidden
set history=50
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set wildmenu
set vb t_vb=                      "ビープ音を鳴らさない
set ruler                         "カーソルが何行目の何列目に置かれているかを表示する
set shell=/bin/bash
set autoread
filetype plugin indent on
syntax enable
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins

"-------------------------------
" .vimrc 再読み込み設定
"-------------------------------
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END


"-------------------------------
" プラグイン設定
"-------------------------------
" https://github.com/Shougo/dein.vim
"   $ mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
"   $ git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
"
" :call dein#install()
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/vimproc')
  call dein#add('Shougo/vimshell.vim')
  call dein#add('Shougo/vimfiler.vim')
  call dein#add('altercation/vim-colors-solarized')

  " Syntax checking
  call dein#add('scrooloose/syntastic')
  call dein#add('leshill/vim-json')

  " python向け
  call dein#add('davidhalter/jedi-vim')
  call dein#add('tell-k/vim-autopep8')

  " language-server-protocol
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/vim-lsp')
  call dein#add('prabirshrestha/asyncomplete.vim')
  call dein#add('prabirshrestha/asyncomplete-lsp.vim')
call dein#end()

"-------------------------------
" Shougo/unite.vim 設定
" refs http://blog.monochromegane.com/blog/2013/09/18/ag-and-unite/
"-------------------------------
" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

"-------------------------------
" Shougo/neocomplete.vim
" 補完設定
"-------------------------------
" refs https://github.com/Shougo/neocomplete.vim#configuration-examples
source ~/.vim/neocomplete.vimrc
let g:neocomplcache_enable_at_startup = 1
set nocompatible
filetype off
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/vimproc/
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/vimshell.vim/
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/neocomplete.vim/
let g:neocomplete#enable_cursor_hold_i = 1
syntax enable
filetype plugin indent on

"-------------------------------

"-------------------------------
" Shougo/vimfiler.vim↲
" ディレクトリエクスプローラ設定
"
" Tips:
"   * ファイラーから展開中の vim へ戻る場合は <TAB> キーで戻れる
"-------------------------------
" vim 実行時に デフォルトではファイルツリーを表示しない
" autocmd VimEnter * execute 'VimFilerBufferDir'
" 隠しファイル扱い
let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']
" vim 標準ファイルを置き換える
let g:vimfiler_as_default_explorer = 1
" インサートモードで開始しない
let g:unite_enable_start_insert = 0
" :tree / :filer でツリーを開く
noremap <silent> :tree :VimFiler -split -simple -winwidth=45 -no-quit
noremap <silent> :filer :VimFiler -split -simple -winwidth=45 -no-quit
" Ctrl-X と Ctrl+T でツリーを開く
noremap <C-X><C-T> :VimFiler -split -simple -winwidth=45 -no-quit<ENTER>

" Edit file by tabedit.
let g:vimfiler_edit_action = 'edit'
" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '|'
let g:vimfiler_tree_closed_icon = '+'
let g:vimfiler_file_icon = ''
let g:vimfiler_marked_file_icon = '*'
nmap <F2>  :VimFiler -split -horizontal -project -toggle -quit<CR>
autocmd FileType vimfiler nnoremap <buffer><silent>/  :<C-u>Unite file -default-action=vimfiler<CR>
autocmd FileType vimfiler nnoremap <silent><buffer> e :call <SID>vimfiler_tree_edit('open')<CR>
autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)

" http://baqamore.hatenablog.com/entry/2016/02/13/062555
augroup vimfiler
  autocmd!
  autocmd FileType vimfiler call s:vimfiler_settings()
augroup END
function! s:vimfiler_settings()
  " tree での制御は，<Space>
  map <silent><buffer> <Space> <NOP>
  nmap <silent><buffer> <Space> <Plug>(vimfiler_expand_tree)
  nmap <silent><buffer> <S-Space> <Plug>(vimfiler_expand_tree_recursive)

  " オープンは，<CR>(enter キー)
  nmap <buffer><expr> <CR> vimfiler#smart_cursor_map(
          \ "\<Plug>(vimfiler_cd_file)",
          \ "\<Plug>(vimfiler_open_file_in_another_vimfiler)")

  " マークは，<C-Space>(control-space)
  nmap <silent><buffer> <C-Space> <Plug>(vimfiler_toggle_mark_current_line)
  vmap <silent><buffer> <C-Space> <Plug>(vimfiler_toggle_mark_selected_lines)

  " ウィンドウを分割して開く
  nnoremap <silent><buffer><expr> <C-j> vimfiler#do_switch_action('split')
  nnoremap <silent><buffer><expr> <C-k> vimfiler#do_switch_action('vsplit')

  " 移動，<Tab> だけでなく <C-l> も
  nmap <buffer> <C-l> <plug>(vimfiler_switch_to_other_window)

  " 閉じる，<Esc> 2 回叩き
  nmap <buffer> <Esc><Esc> <Plug>(vimfiler_exit)
endfunction

"-------------------------------
" altercation/vim-colors-solarized
" カラースキーマ設定
"-------------------------------
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
set background=dark
colorscheme desert
syntax enable

"-------------------------------
" 行番号の色を設定
" http://qiita.com/mochizukikotaro/items/def041700846adb903fe
"-------------------------------
hi LineNr ctermbg=8 ctermfg=0
hi CursorLineNr ctermbg=4 ctermfg=0
set cursorline
hi clear CursorLine

"-------------------------------
" davidhalter/jedi-vim
"-------------------------------
let g:jedi#auto_initialization = 0

"-------------------------------
" scrooloose/syntastic
" pip3 install flake8 pyflakes pep8 pylint jedi
" Syntax Check設定
"-------------------------------
" 無視するエラーコード
" refs http://pep8.readthedocs.io/en/latest/intro.html#error-codes
" E501: 1行が長い
"-------------------------------
" https://github.com/vim-syntastic/syntastic/issues/1870

" :wq で終了する時もチェックする
let g:syntastic_check_on_wq = 0
" ファイルを開いた時にチェックを実行する
let g:syntastic_check_on_open = 1
" エラー行に sign を表示
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_auto_loc_list=1 " auto open error window when errors
let g:syntastic_check_on_open=1 " check for errors on file open
" let g:syntastic_error_symbol='✗'
let g:syntastic_error_symbol = "☠"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "☢"
let g:syntastic_style_warning_symbol = "☹"

let g:syntastic_ignore_files = ['\m\c\.sma$']
let g:syntastic_python_python_exec = 'python'
let g:syntastic_python_checkers = ['pep8', 'flake8']
let g:syntastic_python_pep8_args='--ignore=E501'
let g:syntastic_python_flake8_args='--ignore=E501'

"-------------------------------
" tell-k/vim-autopep8
" autopep8 設定
"-------------------------------
" Shift + F で自動修正
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction

autocmd FileType python noremap <buffer> <S-f> :call Autopep8()<CR>
let g:autopep8_ignore="E501"

"-------------------------------
" leshill/vim-json
" json check 設定
"
" jsonlintをインストールしておく必要があります
"   yum install -y nodejs npm
"   npm install -g jsonlint
"-------------------------------
autocmd BufNewFile,BufRead *.json set filetype=json

" syntastic の設定に下記を追記。
" 保存時に jsonlint でチェックするようにする
let g:syntastic_json_checkers=['jsonlint']

"-------------------------------
" prabirshrestha/vim-lsp
"-------------------------------
let g:lsp_diagnostics_enabled = 1
" debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:asyncomplete_log_file = expand('~/asyncomplete.log')

"-------------------------------
" please execute under the command.
"   $ pip3 install python-language-server
"-------------------------------
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

