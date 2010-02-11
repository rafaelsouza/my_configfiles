" An example for a gvimrc/vimrc file.
" The commands in this are executed when the GUI or vim is started.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2001 Sep 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"	      for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

" Switch on syntax highlighting if it wasn't on yet.
if !exists("syntax_on")
    syntax on
endif

"SETTINGS
"
set ch=2		" Make command line two lines high
set mousehide		" Hide the mouse when typing text

"sets the default grepping engine to be ack-grep with the -a flag
"change this to --ruby or some other stuff for searching only ruby 
"use it like this
":grep Dumper perllib

set grepprg=ack-grep\ -a 


" Switch on search pattern highlighting.
set hlsearch

"display current info all the time
set ruler

colorscheme twilight

"prettier font...
set guifont=Liberation\ Mono\ 12 

" those next 2 commands are taken from a tip in http://vim.sourceforge.net/tips/tip.php?tip_id=259
" They basically map to keys F1 -> toogle menu; F2 -> toggle toolbar

" get rid of toolbar
set guioptions-=T
:let g:toggleTool = 0
map <silent> <S-F2> :if g:toggleTool == 1<CR>:set guioptions-=T<CR>:set lines+=3<CR>:let g:toggleTool = 0<CR>:else<CR>:set lines-=3<CR>:set guioptions+=T<CR>:let g:toggleTool = 1<CR>:endif<CR> 

" get rid of menu
set guioptions-=m
:let g:toggleMenu = 0
map <silent> <S-F1> :if g:toggleMenu == 1<CR>:set guioptions-=m<CR>:set lines+=1<CR>:let g:toggleMenu = 0<CR>:else<CR>:set guioptions+=m<CR>:let g:toggleMenu = 1<CR>:endif<CR>

"line numbers please...
set number

"set the incremental search
set incsearch

"remember more history
set history=500

"Generally the :substitute command changes only the first occurrence of the word
"unless you use the 'g' option.To make the 'g' option the default use this:
set gdefault

"this is for vim omni completion of ruby code. Check out :help new-omni-completion or :help ft-ruby-omni
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1


"*****************************************************************************************************
"*****************************************************************************************************
"*****************************************************************************************************
"
"MAPPINGS 
"
" Make shift-insert work like in Xterm
map  <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
"this pastes what's copied, not what is selected
map  <leader>v <ESC>"+gp 
map  <leader>c "+y 

"reload vim configuration automatically whenever I edit it
"found here http://dailyvim.blogspot.com/2008/11/reload-vimrc.html?showComment=1228044660000#c2642014041159858949
au! BufWritePost $MYVIMRC source %

"this maps to James Buick's FuzzyFinder: TextMate plugin 
"Found here http://weblog.jamisbuck.org/2008/10/10/coming-home-to-vim
map <leader>t :FuzzyFinderTextMate<CR>

"minibufexpl plugin http://www.vim.org/scripts/script.php?script_id=159 
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
set hid "Hide abandoned buffers in order to not loose undo history (taken from http://heykevinle.blogspot.com/2007/06/vim-minibufexpl.html)

" this is a shortcut to the minibufexplorer
map <Leader>b :MiniBufExplorer<cr>
	     
" SPELLING OPTIONS 
" 
"set the spell checker for txt, html, README and tex files
autocmd BufNewFile,BufRead *.txt,*.html,README,*.tex,*.story setlocal spell spelllang=en_us
"autocmd BufNewFile,BufRead *.txt,*.html,README,*.tex setlocal spell spelllang=pt 

map <F2> :setlocal spell spelllang=en_us<CR>
map <F3> :setlocal spell spelllang=pt<CR>

"popup the a menu on mispelled words with the mouse
set mousemodel=popup

set textwidth=80

"found those on http://wiki.rubyonrails.org/rails/pages/HowtoUseVimWithRails
filetype plugin indent on " Enable filetype-specific indenting and plugins
augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs. For other types of
    " identation, add new file types.
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 bs=2 et
    " if not any of those files, fall to the default
    set ai sw=2 sts=2 bs=2 et
augroup END

"Autoidenting ruby code using the kode gem. Found on http://antono.info/en/50
nmap <leader>rci :%!ruby-code-indenter<cr>

"map the leader c key to the buffer delete
nmap <leader>d :bd<cr>

"write the buffer
nmap <leader>w :w<cr>

"write all the  buffers
nmap <leader>wa :wa<cr>
