# Boilerplate config
````bash
" ~/.vimrc "
filetype plugin indent on
set tabstop=4 shiftwidth=4 expandtab
" If vim barfs here, your locale may be broken/not generated "
set listchars=nbsp:ʭ,tab:>-,extends:»,precedes:«,trail:• list
set hlsearch
set bg=dark
" force some indents in .sh "
autocmd Filetype sh setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
````
