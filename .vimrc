set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tmhedberg/simpylfold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Konfekt/FastFold'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jiangmiao/auto-pairs'
Plugin 'isruslan/vim-es6'
Plugin 'mattn/emmet-vim'
Plugin 'cespare/vim-toml'
Plugin 'rust-lang/rust.vim'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set nu rnu
set showcmd
set incsearch
set path+=**
set timeoutlen=1000 ttimeoutlen=10
set foldmethod=indent
set foldlevel=99

set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos

set wildmenu
set wildignore=*.o,*.obj,*~,*.pyc "stuff to ignore when tab completing
set wildignore+=.venv/**,venv/**,env/**
set wildignore+=node_modules/**
set wildignore+=.git/**
set wildignore+=*DS_Store*
set wildignore+=build/**
" set wildignore+=dist/**
set wildignore+=*/__pycache__/

set laststatus=2
set statusline=
" set statusline+=[%n] " buffer number
set statusline+=%m " buffer edited status
set statusline+=\ %{fugitive#head()} " git info
" set statusline+=\ %P " file percentage
set statusline+=\ %F " file path
set statusline+=%*
set statusline+=%=
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"set statusline+=\ %y " file type
" set statusline+=\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}] " file encoding

set backupdir=~/.vim/.backup//
set directory=~/.vim/.swap//
set undodir=~/.vim/.undo//

function SetGuiFont()
	try
		set guifont=UbuntuMono-Regular:h18
	catch /.*/
		echom "Caught error: " . v:exception
		if has("win32")
			set guifont=Consolas:h11
		elseif has("gui_macvim")
			set guifont=Menlo:h15
		endif
	endtry
endfunction

if has('gui_running')
	call SetGuiFont()

	set guioptions=e
	set showtabline=1
	set background=dark
	colorscheme solarized
	call togglebg#map("<F5>")
else
	colorscheme zenburn
endif

if has('gui_macvim')
	set macmeta
endif

nnoremap <space> za
" uppercase word
inoremap <c-u> <esc>viwUea
nnoremap zuz <Plug>(FastFoldUpdate)
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

command! ClearWhitespaces %s/^\s\+$//e | %s/\s\+$//e
command! MakeTags !ctags -R .
command! MakePyScope !find "$PWD/" -name "*.py" > cscope.files && cscope -Rbv -i cscope.files -f cscope.outset tags=tags

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_preview = 1
let g:netrw_list_hide= '.*\.swp$,.*\.pyc$,__pycache__,\.git'

let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
let g:SimpylFold_docstring_preview = 1

let g:AutoPairsFlyMode=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exe = 'npm run lint --'

let g:kite_auto_complete=1
let g:kite_tab_complete=1

function SetPythonOptions()
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal shiftwidth=4
    setlocal textwidth=80
    setlocal expandtab
    setlocal autoindent
    setlocal fileformat=unix

    syntax keyword pythonSelf self
    syntax keyword pythonCls cls

    highlight def link pythonSelf Special
    highlight def link pythonCls Special

endfunction

autocmd FileType netrw setl bufhidden=delete
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python call SetPythonOptions()
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  try:
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    exec(open(activate_this, 'r').read(), dict(__file__=activate_this))
  except Exception:
    pass
EOF

