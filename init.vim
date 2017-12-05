" ******************** PLUGINS ********************

" Not required, as this is already the default in NeoVim or Vim 8+
" set nocompatible

" Enable file type detection and language-dependent indenting.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" Note: this is required by many different functions provided either by the
" editor or by plugins, such as vim-commentary.
filetype plugin indent on

" path to dein.vim
set runtimepath+=~/.nvim-dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.nvim-dein'))
  " plugins' root path
  call dein#begin(expand('~/.nvim-dein'))

  " Plugin management
  call dein#add('Shougo/dein.vim')

  " Color schemes
  call dein#add('flazz/vim-colorschemes')

  " Denite & co.
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neomru.vim')
  " call dein#add('Shougo/neoyank.vim') " Not needed, at least for now

  " Completion
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('fishbullet/deoplete-ruby')
  call dein#add('awetzel/elixir.nvim')

  " Snippets
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')

  " Motion and searching extensions
  call dein#add('easymotion/vim-easymotion')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('haya14busa/incsearch-easymotion.vim')

  " Async grepping
  call dein#add('mhinz/vim-grepper')
  " call dein#add('Numkil/ag.nvim') " Async neovim-specific plugin

  " Async testing
  call dein#add('janko-m/vim-test')
  call dein#add('neomake/neomake')

  " Tim Pope's stuff
  call dein#add('vim-ruby/vim-ruby')
  call dein#add('tpope/vim-abolish')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-dispatch')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-projectionist')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-unimpaired')

  " Easy align
  call dein#add('junegunn/vim-easy-align')

  """""""""""""""""""""""""""""""""" TODO """"""""""""""""""""""""""""""""""""""""

  " Expand region
  call dein#add('terryma/vim-expand-region')

  " Local .vimrc support
  call dein#add('embear/vim-localvimrc')

  " Filer - choose which one to adopt
  " call dein#add('scrooloose/nerdtree')
  " call dein#add('tpope/vim-vinegar')
  " call dein#add('Shougo/vimfiler.vim')

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  call dein#end()
  call dein#save_state()
endif

" make test commands execute using dispatch.vim
let test#strategy = "neovim"



" ******************** GENERAL SETTINGS ********************

syntax enable

" Improve the cursor visibility
set cursorline

" Show the cursor position all the time
set ruler

" Use line numbers
set number

" Set minimum width of number field
set numberwidth=5

" Be more liberal with hidden buffers
set hidden

" Enable local, i.e., per-project, .exrc configuration files.
set exrc

" Disable annoying K command, that attempts to display man pages
" (see http://blog.sanctum.geek.nz/vim-annoyances/)
nnoremap K <nop>

" Enable syntax based folding method
set foldmethod=syntax

" Effectively disable folds unless they are requested
set foldlevelstart=99
set foldlevel=99

" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces

" Allow to override the following settings via modelines
let g:secure_modelines_allowed_items = [
            \ "syntax",      "syn",
            \ "textwidth",   "tw",
            \ "softtabstop", "sts",
            \ "tabstop",     "ts",
            \ "shiftwidth",  "sw",
            \ "expandtab",   "et",   "noexpandtab", "noet",
            \ "filetype",    "ft",
            \ "foldmethod",  "fdm",
            \ "readonly",    "ro",   "noreadonly", "noro",
            \ "rightleft",   "rl",   "norightleft", "norl"
            \ ]


" ******************** COLORS ********************

" Use true color
set termguicolors

" Set dark background
set background=dark

" Use lucius colorscheme
colorscheme lucius

" Fix hideous colors for Search (which make denite.nvim almost unusable)
augroup FixSearch
  autocmd!
  autocmd ColorScheme * highlight Search ctermfg=117 guifg=#87d7ff ctermbg=104 guibg=#8787d7
augroup END


" ******************** EDITING ********************

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Use , as <Leader> special character
let g:mapleader=','

" Disable the hideous highlighting of matching paretheses
let g:loaded_matchparen=1

" Toggle paste mode with F9
set pastetoggle=<F9>

" Select previously pasted text
" (from: http://vim.wikia.com/wiki/Selecting_your_pasted_text)
nnoremap gp `[v`]


" ******************** INVISIBLE CHARACTERS ********************

" This configuration was taken from vimcasts.org (episode 1)

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Show invisible characters by default
set list


" ******************** WHITESPACE AND INDENTATION ********************

" This configuration is taken (in part) from vimcasts.org (episodes 4 and 5)

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let s:_s=@/
  let s:l = line(".")
  let s:c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=s:_s
  call cursor(s:l, s:c)
endfunction

" Strip trailing spaces
nnoremap <silent> _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Re-indent the whole file
nnoremap <silent> _= :call Preserve("normal gg=G")<CR>

" Remove blank lines
nnoremap <silent> __ :%g/^$/d<CR>


" ******************** FILETYPE SPECIFIC INDENTATION ********************

augroup vim
  " Make sure to clear any previous settings in this group
  autocmd!

  " Vimscript source code: set 2-space indentation
  autocmd FileType vim  setlocal ts=8 sw=2 sts=2 expandtab
augroup END

augroup java
  " Make sure to clear any previous settings in this group
  autocmd!

  " Java source code: set 4-space indentation
  autocmd FileType java  setlocal ts=8 sw=4 sts=4 expandtab
augroup END

augroup ruby
  " Make sure to clear any previous settings in this group
  autocmd!

  " Ruby source code: set 2-space indentation
  autocmd FileType ruby  setlocal ts=8 sw=2 sts=2 expandtab
  autocmd FileType eruby setlocal ts=8 sw=2 sts=2 expandtab
augroup END

augroup c
  " Make sure to clear any previous settings in this group
  autocmd!

  autocmd FileType c     setlocal ts=8 sw=8 sts=8 expandtab
augroup END


" ******************** FILE OPENING SHORTCUTS ********************

" This configuration was taken from vimcasts.org (episode 14)

" Shortcuts to open files from the same directory as the file in the current
" buffer. Additionally, this allows to expand the directory of the current
" file anywhere at the command line by pressing %%.
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" noremap <Leader>ew :e %%
" noremap <Leader>es :sp %%
" noremap <Leader>ev :vsp %%
" noremap <Leader>et :tabe %%


" ******************** MATCHIT ********************

" This configuration was taken from vimcasts.org
" (http://vimcasts.org/blog/2010/12/a-text-object-for-ruby-blocks/)

runtime macros/matchit.vim


" ******************** NEOVIM EXTENSIONS ********************

" Shows the effects of :substitute, :smagic, and :snomagic commands
" incrementally, as you type.
if exists('&inccommand')
  set inccommand=split
endif


" ******************** DENITE ********************

" Find file within current directory by name
nnoremap <C-p> :Denite file_rec<CR>

" Find MRU file by name
nnoremap <Leader>m :Denite file_mru<CR>

" Find buffer by name
" (Note: -auto-preview seems useless and it is also broken at the moment)
nnoremap <Leader>b :Denite buffer<CR>

" Jump to line of file displayed in current buffer by content
nnoremap <Leader>l :Denite line<CR>

" Jump to line of file within current directory by content
nnoremap <Leader>r :Denite grep -no-quit<CR>

" Find yank by content (in order to paste it in current buffer)
" nnoremap <Leader>y :Denite neoyank<CR>


" ******************** DEOPLETE ********************

" Enable Deoplete at startup
let g:deoplete#enable_at_startup = 1


" ******************** TO CHECK ********************

" set smartindent
" set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
" set showcmd
" set noimdisable
" set iminsert=0
" set imsearch=0

" No preview window when auto-completion
" set completeopt-=preview
