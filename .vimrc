" ~/.vimrc - former my /etc/vim/vimrc

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" Лучше не включать, а то комменты сливаются с переменными VAR=
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
" Не включать: ломает вставку мышью.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Табы всегда заменяем четырьмя пробелами.
set tabstop=4
set shiftwidth=4
set expandtab
" Если этого в каком-то файле не требуется, дописываем в начало строку вида
" /* vi:set ts=8:set noexpandtab: */
set modeline

" Некоторые типы файлов определяются не так, как я хочу
" virsh edit $domainname
au BufNewFile,BufRead /tmp/virsh*       setf xml

