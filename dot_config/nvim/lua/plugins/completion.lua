return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- LSP
    {
      'neovim/nvim-lspconfig',
      config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- 2. Define a helper to make the new syntax less verbose
        local function setup_server(name, opts)
          opts = opts or {}
          opts.capabilities = vim.tbl_deep_extend('force', capabilities, opts.capabilities or {})

          -- The new Neovim 0.11+ way
          vim.lsp.config(name, opts)
          vim.lsp.enable(name)
        end

        -- --- LSP CONFIGURATIONS ---
        setup_server('rust_analyzer', {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                buildScripts = { enable = true },
              },
            },
          }
        })
        setup_server('lua_ls')
        setup_server('bashls')
        setup_server('yamlls')
      end
    },
    ----- For Lua
    {
      'folke/lazydev.nvim',
      ft = 'lua',
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
      'quangnguyen30192/cmp-nvim-ultisnips',
      dependencies = {
        'SirVer/ultisnips',
      },
    },
  },
  config = function()
    vim.opt.completeopt = 'menu,menuone,noselect'

    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")


    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body)
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
        -- Snippets mappings
        ['<C-s>'] = cmp.mapping(cmp_ultisnips_mappings.expand_or_jump_forwards, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(cmp_ultisnips_mappings.jump_backwards, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'lazydev', group_index = 0 }, -- skip LuaLS completions when lazydev is active
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'ultisnips' },
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

    -- Teach cmp about autopairs so confirming a completion doesn't leave a duplicate closing bracket
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local telescope = require('telescope.builtin')

        local buf = { buffer = args.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf)
        vim.keymap.set('n', '<leader>yd', telescope.lsp_definitions, buf)
        vim.keymap.set('n', '<leader>yD', vim.lsp.buf.declaration, buf)
        vim.keymap.set('n', '<leader>yf', telescope.lsp_references, buf)
        vim.keymap.set('n', '<leader>yr', vim.lsp.buf.rename, buf)
        vim.keymap.set('n', '<leader>ya', vim.lsp.buf.code_action, buf)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, buf)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, buf)

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
