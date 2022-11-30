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
  Plug 'windwp/nvim-autopairs'
  " Plug 'nvim-treesitter/nvim-treesitter-refactor' 
  
  " Completion
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'onsails/lspkind-nvim'

  " Snippets
  Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*'}
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'rafamadriz/friendly-snippets'
  
  " Telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  " Motion and searching extensions
  Plug 'haya14busa/is.vim'
  Plug 'phaazon/hop.nvim'

  " Status line
  Plug 'nvim-lualine/lualine.nvim'
  
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

" Always use system clipboard
set clipboard+=unnamedplus


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
set completeopt=menu,menuone,noinsert
" set completeopt=menu,menuone,noinsert,noselect

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
  
  -- Set up lspconfig.
  -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')

  lspconfig['clangd'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
  lspconfig['solargraph'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
  lspconfig['rust_analyzer'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
  }

  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = function(fallback)
        if cmp.visible() then
          -- cmp.confirm()
          -- cmp.mapping.confirm { 
          cmp.confirm({ 
            -- behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          })
        else
          fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
        end
      end,
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text", 
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
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

  -- Load snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  
  -- Treesitter
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "java", "ruby", "lua", "rust" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- -- the name of the parser)
      -- -- list of language that will be disabled
      -- -- disable = { "c", "rust" },
      -- -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      -- disable = function(lang, buf)
      --     local max_filesize = 100 * 1024 -- 100 KB
      --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      --     if ok and stats and stats.size > max_filesize then
      --         return true
      --     end
      -- end,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,

      -- Enable endwise plugin
      -- endwise = { enable = true },
    },
  }
  -- require'nvim-treesitter.configs'.setup {
  --   highlight = {
  --     enable = true,
  --     custom_captures = {
  --       -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
  --       ["foo.bar"] = "Identifier",
  --     },
  --   },
  --   incremental_selection = {
  --     enable = true,
  --     keymaps = {
  --       init_selection = "gnn",
  --       node_incremental = "grn",
  --       scope_incremental = "grc",
  --       node_decremental = "grm",
  --     },
  --   },
  --   indent = {
  --     enable = true,
  --   },
  --   endwise = {
  --       enable = true,
  --   },
  -- }

  -- Autopairs
  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
  local npairs = require("nvim-autopairs")
  npairs.setup({
    check_ts = true,
    -- ts_config = {
    --   -- lua = {'string'},-- don't add a pair on that treesitter node
    --   -- javascript = {'template_string'},
    --   java = false,-- don't check treesitter on java
    -- },
  })
  npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
  npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
  
  -- Telescope
  local ts_builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', ts_builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', ts_builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', ts_builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', ts_builtin.help_tags, {})
  require('telescope').load_extension('fzy_native')

  -- Web Dev Icons
  require('nvim-web-devicons').setup {
    -- globally enable different highlight colors per icon (default to true)
    -- if set to false all icons will have the default icon's color
    color_icons = true,
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
    -- -- your personnal icons can go here (to override)
    -- -- you can specify color or cterm_color instead of specifying both of them
    -- -- DevIcon will be appended to `name`
    -- override = {
    --  zsh = {
    --    icon = "",
    --    color = "#428850",
    --    cterm_color = "65",
    --    name = "Zsh"
    --  }
    -- },
  }

  -- Hop.nvim
  local hop = require('hop')
  hop.setup()
  local directions = require('hop.hint').HintDirection
  vim.keymap.set('', 'f', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  end, {remap=true})
  vim.keymap.set('', 'F', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  end, {remap=true})
  vim.keymap.set('', 't', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  end, {remap=true})
  vim.keymap.set('', 'T', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  end, {remap=true})
  vim.keymap.set('', 's', function()
    hop.hint_char2()
  end, {remap=true})
  -- Might want to add a shortcut to HopWord later on

  -- LuaLine
  require('lualine').setup {
    options = {  theme = 'OceanicNext' }
  }
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" ******************** LuaSnip ********************

" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'


" ******************** TO CHECK ********************

" set smartindent
" set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
" set showcmd
" set noimdisable
" set iminsert=0
" set imsearch=0

