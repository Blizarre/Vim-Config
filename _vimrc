set nocompatible
"
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file

set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

syntax on
set hlsearch

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
"behave mswin

colorscheme darkblue

set nobackup
set nowritebackup

" Afficher le browser au fichier courant
map <C-B> :Explore<CR>

" Mettre en plein écran : Attention, n'est pas réversible :-/
map <c-w>F <c-w>_<c-w><Bar>

map <F2> :w<CR>
imap <F2> <ESC>:w<CR>

map <F3> :bp<CR>
imap <F3> <ESC>:bp<CR>i

map <F4> :bn<CR>
imap <F4> <ESC>:bn<CR>i


set autoindent

" Efface le buffer courant et affiche un autre buffer
nmap <leader>d :bprevious<CR>:bdelete #<CR>

set fileformats=dos,unix

set tabstop=4
set shiftwidth=4
set expandtab

au GUIEnter * simalt ~xn

" Changement auto de répertoire courant pour celui du buffer courant
set autochdir

" pour les tags : aller à définition et aller à def dans split
autocmd FileType c,cpp set tags=d:\Data\e_smarac_view_tags\tags
autocmd FileType c,cpp map <C-D> <C-]>
autocmd FileType c,cpp map <C-S-D> <C-W><C-]>

" Communication avec Windows
imap <C-V> <ESC>"+pi

"Spell check
set spelllang=fr_fr

autocmd FileType markdown map <F5> :!pandoc "%:p" -t docx -o "%:p:r.docx"<CR>
autocmd FileType markdown map <C-D> :s/^\(TODO\\|WARN\)/DONE/g<CR>
