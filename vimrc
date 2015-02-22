" /**************************************
" * Vimto                               *
" * My .vimrc.                          *
" * https://github.com/stuartmemo/vimto *
" ***************************************

" /******************
" * General config  *
" ******************/
set autoindent              " auto-indent
set backspace=indent,eol,start 
set clipboard^=unnamed      " share clipboard with mac
set encoding=utf-8
set expandtab               " convert tabs to spaces        
set ignorecase              " ignore case when searching    
set ls=2                    " show status line              
set nobackup                " don't create a backup file    
set nocompatible            " use vim defaults
set nofoldenable            " stop code folding
set noswapfile              " don't bother with .swp files either
set number                  " show line number
set shiftwidth=4            " number of spaces in auto-indent
set showmatch               " hightlight search matches     
set smartindent             " smart-indent
set tabstop=4               " number of spaces in tab       
syntax on                   " turn on syntax highlighting   

" /**********
" * Colours *
" **********/
set t_Co=256                " use 256 colours
colorscheme molokai         " set colorscheme
let g:molokai_original = 1  " use dark grey background
let mapleader = "\<Space>"

" /******************************************
" * File types                              *
" * Detect file types and set unknown ones. *
" ******************************************/
filetype plugin on
filetype plugin indent on

autocmd BufRead,BufNewFile *.feature set filetype=ruby
autocmd BufRead,BufNewFile *.handlebars set filetype=html
autocmd BufRead,BufNewFile *.hbs set filetype=html
autocmd BufRead,BufNewFile *.spv set filetype=html
autocmd BufRead,BufNewFile *.js highlight javaScriptComment ctermfg=Magenta
autocmd BufRead,BufNewFile *.js highlight javaScriptLineComment ctermfg=Magenta
autocmd BufRead,BufNewFile *.less set filetype=css
autocmd BufRead,BufNewFile *.sass set filetype=css
autocmd BufRead,BufNewFile *.scss set filetype=css

" /**********************************************
" * Vundle                                      *
" * Vundle, the plug-in manager for Vim.        *
" * https://github.com/gmarik/Vundle.vim        *
" **********************************************/
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    " Needs vim installed with Lua.
    Plugin 'Shougo/neocomplete.vim'

    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'Shougo/neosnippet'
    Plugin 'Shougo/neosnippet-snippets'
    Plugin 'bling/vim-airline'
    Plugin 'gmarik/Vundle.vim'  " Let Vundle manage Vundle.
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'kien/ctrlp.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'scrooloose/syntastic'
    Plugin 'tpope/vim-fugitive'
call vundle#end()

" /******************************************************
" * The Silver Searcher                                 *
" * A code-searching tool similar to ack, but faster.   *
" * https://github.com/ggreer/the_silver_searcher       *
" ******************************************************/
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" /**********************************************
" * NERDTree                                    *
" * A tree explorer plugin for vim.             *
" * https://github.com/scrooloose/nerdtree      *
" **********************************************/

" Open NERDTree when vim is launched.
autocmd VimEnter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:nerdtree_tabs_open_on_console_startup = 1

" /**********************************************
" * Syntastic                                   *
" * Syntax checking hacks for vim.              *
" * https://github.com/scrooloose/syntastic     *
" **********************************************/
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args="--report=csv --standard=PSR2"

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" Define dictionary.

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif

let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" /***************
" * Key Mappings *
" ***************/

" Allow uppercase 'W' to write.
command W w

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" map ; :
map <Leader> <Plug>(easymotion-prefix)

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd VimEnter * wincmd p

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
