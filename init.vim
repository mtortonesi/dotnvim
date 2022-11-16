" ******************** PLUGINS ********************

if &compatible
  set nocompatible
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - For Vim: '.vim/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

  " Modeline security
  Plug 'ciaranm/securemodelines'

  " Color schemes
  Plug 'flazz/vim-colorschemes'

  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Automatically update the parsers
  " Plug 'nvim-treesitter/playground' 
  " Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  
  " Completion
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'onsails/lspkind-nvim'

  " Snippets
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'rafamadriz/friendly-snippets'
  " Plug 'norcalli/snippets.nvim'
  
  " Telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " Motion and searching extensions
  " Plug 'easymotion/vim-easymotion'
  Plug 'haya14busa/is.vim'
  " Plug 'haya14busa/incsearch.vim'
  " Plug 'haya14busa/incsearch-easymotion.vim'
  
  " Easy align
  Plug 'junegunn/vim-easy-align'

  " Async testing
  Plug 'janko-m/vim-test'
  Plug 'neomake/neomake'

  " Tim Pope's stuff
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  " Plug 'tpope/vim-endwise' " Plays bad with compe
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-unimpaired'

  " Rust support
  Plug 'rust-lang/rust.vim'

  " Zig support
  Plug 'ziglang/zig.vim'

  " Facilitate opening files from grep output
  Plug 'bogado/file-line'

  """""""""""""""""""""""""""""""""" TODO """"""""""""""""""""""""""""""""""""""""

  " Expand region
  Plug 'terryma/vim-expand-region'

  " Local .vimrc support
  Plug 'embear/vim-localvimrc'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Initialize plugin system
call plug#end()

" Enable file type detection and language-dependent indenting.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" Note: this is required by many different functions provided either by the
" editor or by plugins, such as vim-commentary.
filetype plugin indent on

" make test commands execute using dispatch.vim
let test#strategy = "neovim"



" ******************** GENERAL SETTINGS ********************

syntax enable

" Enable mouse
set mouse=a

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

" Disable annoying conceal
set conceallevel=0

" Disable modelines, use securemodelines.vim instead
set nomodeline

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

" Use xdiff with patience algorithm (https://vimways.org/2018/the-power-of-diff/)
set diffopt=internal,algorithm:patience,indent-heuristic


" ******************** COLORS ********************

" Use true color
set termguicolors

" Set dark background
set background=dark

" Use lucius colorscheme
colorscheme ir_black
" colorscheme lucius

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
  set inccommand=nosplit
endif


" ******************** NVIM-CMP ********************

" Setup completion menu mode
set completeopt=menu,menuone ",noselect
" set completeopt=menuone,noselect

lua <<EOF
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  end
  
  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }
  -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  require('lspconfig')['clangd'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
  }
  require('lspconfig')['solargraph'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
  }
  require('lspconfig')['rust_analyzer'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
      -- Server-specific settings...
      settings = {
        ["rust-analyzer"] = {}
      }
  }

  local cmp = require('cmp')
  local lspkind = require('lspkind')
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    formatting = {
      format = lspkind.cmp_format({
        with_text = false, 
        -- maxwidth = 50,
        menu = ({
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          vsnip = "[Snip]",
          --luasnip = "[LuaSnip]",
          path = "[Path]",
          nvim_lua = "[Lua]",
          -- latex_symbols = "[Latex]",
        })
      })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  require'lspconfig'.clangd.setup{
    capabilities = capabilities
  }
  require'lspconfig'.solargraph.setup{
    capabilities = capabilities
  }
EOF

" ******************** TO CHECK ********************

" set smartindent
" set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
" set showcmd
" set noimdisable
" set iminsert=0
" set imsearch=0

