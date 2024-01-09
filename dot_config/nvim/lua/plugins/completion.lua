return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- LSP
    {
      'neovim/nvim-lspconfig',
      config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- LSP config for Rust
        lspconfig.rust_analyzer.setup {
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
            }
          }
        }

        -- LSP config for Lua
        require("neodev").setup({})
        lspconfig.lua_ls.setup({})
      end
    },
    ----- For Lua
    {
      'folke/neodev.nvim',
    },
    ---- Pictograms for the type of completions
    {
      'onsails/lspkind.nvim',
      init = function()
        require("lspkind").init()
      end
    },
    -- Code completion
    ---- via LSP
    'hrsh7th/cmp-nvim-lsp',
    ---- Show function parameters when writing a call
    "hrsh7th/cmp-nvim-lsp-signature-help",
    ---- from local buffer words
    'hrsh7th/cmp-buffer',
    ---- for file paths
    'hrsh7th/cmp-path',
    ---- for command line
    'hrsh7th/cmp-cmdline',
    ---- for available snippets
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'honza/vim-snippets',
      },
      config = function()
        local ls = require('luasnip')
        require("luasnip.loaders.from_snipmate").load()

        ls.config.set_config({
          history = true
        })
        vim.keymap.set({ 'i', 's' }, '<c-s>', function()
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          end
        end)

        vim.keymap.set({ 'i', 's' }, '<c-j>', function()
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end)
      end
    },
  },
  config = function()
    vim.opt.completeopt = 'menu,menuone,noselect'

    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-n>'] = cmp.mapping(function(_)
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end, { 'i', 's' }),
        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      }),
      sorting = {
        comparators = {}, -- We stop all sorting to let the lsp do the sorting
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol',
          maxwidth = 50,
          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[API]",
            path = "[path]",
            ultisnips = "[snip]",
          },
        }),
      },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    --- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
        vim.keymap.set('n', '<leader>yd', vim.lsp.buf.definition)
        vim.keymap.set('n', '<leader>yD', vim.lsp.buf.declaration)
        vim.keymap.set('n', '<leader>yf', vim.lsp.buf.references)
        vim.keymap.set('n', '<leader>yr', vim.lsp.buf.rename)
        vim.keymap.set('n', '<leader>ya', vim.lsp.buf.code_action)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

        -- Autoformat on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format { async = false }
          end
        })
      end,
    })
  end
}
