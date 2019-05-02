set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tmhedberg/simpylfold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Konfekt/FastFold'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()            " required
filetype plugin indent on    " required

" configure fastfold
" https://github.com/Konfekt/FastFold
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" configure simplefold
let g:SimpylFold_docstring_preview = 1

" syntastic default configure
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']

" highlighing by syntax
syntax on

" show inserted commands in normal mode
set showcmd

" tab completion for all path related tasks
set path+=**

" display all matching files when tab complete
set wildmenu

" look for the ctags index file in the source directory
command! MakeTags !ctags -R .
command! MakePyScope !find "$PWD/" -name "*.py" > cscope.files && cscope -Rbv -i cscope.files -f cscope.outset tags=tags

" enable folding
set foldmethod=indent
set foldlevel=99

" enable folding with the space bar
nnoremap <space> za

" set encoding
set encoding=utf-8

set nu rnu

if has('gui_running')
	if has("win32")
		set guifont=Consolas:h11
	elseif has('gui_macvim')
		set guifont=Menlo:h14
		set macmeta
	endif
	set guioptions=e
	set showtabline=1
	set background=light
	colorscheme solarized
	call togglebg#map("<F5>")
else
	colorscheme zenburn
endif

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=80 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" highlight python self and cls
augroup python
    autocmd!
    autocmd FileType python
                \   syn keyword pythonSelf self
                \ | highlight def link pythonSelf Special
    		\ | syn keyword pythonCls cls
    		\ | highlight def link pythonCls Special
augroup end

au BufNewFile,BufRead *.js,*.html,*.css
    \   set tabstop=2
    \ | set softtabstop=2
    \ | set shiftwidth=2

" remove whitespace command
command! ClearWhitespaces %s/^\s\+$//e | %s/\s\+$//e

" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this, 'r').read(), dict(__file__=activate_this))
EOF

set laststatus=2
set statusline=
" set statusline+=[%n] " buffer number
set statusline+=%m " buffer edited status
set statusline+=\ %F " file path
set statusline+=%*
set statusline+=%=
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=\ %{fugitive#head()} " git info
set statusline+=\ %y " file type
set statusline+=\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}] " file encoding
set statusline+=\ %P " file percentage

command! OpenVimRC e $HOME/.vimrc
command! UpdateVimRC source $HOME/.vimrc

" kite configuration
let g:kite_auto_complete=0

" enable FlyMode for brackets
let g:AutoPairsFlyMode=1
