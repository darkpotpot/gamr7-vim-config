filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on
call pathogen#helptags()

"Set mapleader
let mapleader = ","
let g:mapleader = ","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" This means that you can have unwritten changes to a file and open a new file using :e, 
" without being forced to write or undo your changes first. 
" Also, undo buffers and marks are preserved while the buffer is open. 
" This is an absolute must-have
set hidden

" Also, I like Vim to have a large undo buffer, a large history of commands, 
" ignore some file extensions when completing names by pressing Tab,
" and be silent about invalid cursor moves and other errors.
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't bevv
set noerrorbells         " don't beep

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" It clears the search buffer when you press ,/
" (Tired of clearing highlighted searches by searching for “ldsfhjkhgakjks")
nmap <silent> ,/ :nohlsearch<CR>

" This lets you use w!! to do that after you opened the file that requires root privileges
cmap w!! w !sudo tee % >/dev/null


set whichwrap=b,s,<,>,[,]
syntax enable
colo desert
set nu
set guifont=ProggyCleanTT\ 12
set hls
set guioptions-=T "get rid of toolbar
filetype plugin on
set smartindent
set autoindent
set expandtab
set list
set cursorline
set hidden
set listchars=tab:>-,trail:.,nbsp:+
set tags=tags;$HOME
se et ts=8 sw=4 softtabstop=4 smarttab
au BufEnter *.py set sw=4 sts=4 ts=4 et sta ai
nnoremap <silent> <C-N> :bn<CR>
nnoremap <silent> <C-P> :bp<CR>
map <F2> :NERDTreeToggle
map <F3> :py GenerateTags()
map <F4> :cd %:h
map <F5> :!gnome-terminal -e "python2.6 -m pdb %"<CR><CR>
map <F6> :!xterm -hold -e "python2.6 -m pdb % -v"<CR><CR>
map <F11> :se path=.,~/gamr7/git-trunk/code/app/,~/gamr7/git-trunk/code/
map <F12> :Align 
map œ $
imap œ $
vmap œ $
cmap œ $

let g:Tb_MaxSize = 40
let g:Tb_VSplit = 40
let g:Tb_MoreThanOne = 1

" to avoid to have to do shift for save
nnoremap ; :

" to avoid doing ctrl+c or ESC to exit insert mode
inoremap jj <ESC>

let g:delimitMate_apostrophes = ''

""""""""""""""""""""""""""""""
" Python section
""""""""""""""""""""""""""""""

" encrypt/decrypt gcf on the fly
autocmd BufReadPre,FileReadPre      *.gcf set bin modifiable
autocmd BufReadPost,FileReadPost    *.gcf '[,']!python ~/gamr7/code/gamr7_lib/security/gcf_converter.py --decrypt <afile>
autocmd BufReadPost,FileReadPost    *.gcf set nobin
autocmd BufWritePost,FileWritePost  *.gcf !python ~/gamr7/code/gamr7_lib/security/gcf_converter.py --encrypt <afile>
au BufRead,BufNewFile *.gcf		set filetype=xml

"Python iMaps
" au FileType python set cindent
au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $s self
au FileType python inoremap <buffer> $c ##<cr>#<space><cr>#<esc>kla
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $d """<cr>"""<esc>O
au FileType python inoremap <buffer> $ss self.
au FileType xml exe ":silent 1,$!tidy -xml -i -w 0 2>/dev/null"


""""""""""""""""""""""""""""""
"For syntax errors
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m


""""""""""""""""""""""""""""""
" Better 'gf'
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

""""""""""""""""""""""""""""""
" Python section
""""""""""""""""""""""""""""""

python << EOL
import os
import subprocess
def GenerateTags():
    old_cwd=os.getcwd()
    os.chdir(os.path.expanduser('~/gamr7'))
    cmd = "ctags -R --tag-relative=yes --languages=Python --python-kinds=-i -f ~/gamr7/tags ~/gamr7"
    subprocess.Popen(cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, close_fds=True).stdin
    os.chdir(old_cwd)
EOL

