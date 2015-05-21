" /**************************************
" * Vimto                               *
" * My .vimrc.                          *
" * https://github.com/stuartmemo/vimto *
" ***************************************

" /******************
" * General config  *
" ******************/
set autoindent                  " auto-indent
set backspace=indent,eol,start  " make backspace behave normally
set encoding=utf-8              " set vim's character encoding
set expandtab                   " convert tabs to spaces        
set ignorecase                  " ignore case when searching    
set ls=2                        " show status line              
set nobackup                    " don't create a backup file    
set nofoldenable                " stop code folding
set noswapfile                  " don't bother with .swp files either
set number                      " show line number
set shiftwidth=4                " number of spaces in auto-indent
set showmatch                   " hightlight search matches     
set smartindent                 " smart-indent
set t_Co=256                    " use 256 colours
set tabstop=4                   " number of spaces in tab       
set textwidth=80                " set line width to 80 characters
syntax on

if $TMUX == ''
    set clipboard=unnamed
endif

" /**********
" * Colours *
" **********/
colorscheme molokai         " set colorscheme
let g:molokai_original = 1  " use dark grey background
let mapleader = "\<Space>"
highlight LineNr ctermbg=none
highlight LineNr ctermfg=237

" /**********************************************
" * Vundle                                      *
" * Vundle, the plug-in manager for Vim.        *
" * https://github.com/gmarik/Vundle.vim        *
" **********************************************/

set nocompatible                    " use vim defaults
filetype off                        " filetype needs to be off before Vundle
set rtp+=~/.vim/bundle/Vundle.vim   " set the runtime path to include Vundle and initialize

call vundle#begin()
    Plugin 'bling/vim-airline'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'gmarik/Vundle.vim'  " let Vundle manage Vundle
    Plugin 'honza/vim-snippets'
    Plugin 'SirVer/ultisnips'
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'kien/ctrlp.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'scrooloose/syntastic'
    Plugin 'tpope/vim-fugitive'
    Plugin 'ryanoasis/vim-webdevicons'
call vundle#end()

filetype plugin indent on           " required

" /******************************************
" * File types                              *
" * Detect file types and set unknown ones. *
" ******************************************/
autocmd BufRead,BufNewFile *.feature set filetype=ruby
autocmd BufRead,BufNewFile *.handlebars set filetype=html
autocmd BufRead,BufNewFile *.hbs set filetype=html
autocmd BufRead,BufNewFile *.spv set filetype=html
autocmd BufRead,BufNewFile *.js highlight javaScriptComment ctermfg=Magenta
autocmd BufRead,BufNewFile *.js highlight javaScriptLineComment ctermfg=Magenta
autocmd BufRead,BufNewFile *.less set filetype=css
autocmd BufRead,BufNewFile *.sass set filetype=css
autocmd BufRead,BufNewFile *.scss set filetype=css

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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
autocmd VimEnter * NERDTree     " Open NERDTree when vim is launched
autocmd VimEnter * wincmd p     " Move cursor to file being edited
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " automatically close nerdtree if it's the last thing open
let g:nerdtree_tabs_open_on_console_startup = 1

" /**********************************************
" * Syntastic                                   *
" * Syntax checking hacks for vim.              *
" * https://github.com/scrooloose/syntastic     *
" **********************************************/
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args="--report=csv --standard=PSR2"

let g:webdevicons_conceal_nerdtree_brackets = 0

" /***************
" * Key Mappings *
" ***************/

" Allow uppercase 'W' to write.
command W w

" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key 
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

autocmd bufenter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
