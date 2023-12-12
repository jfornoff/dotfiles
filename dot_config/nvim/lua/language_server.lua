vim.opt.completeopt = 'menu,menuone,noselect'

-- Initialize
local lspkind = require("lspkind")
lspkind.init()

-- Set up nvim-cmp.
local cmp = require('cmp')

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
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      else
        cmp.complete()
      end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
  }, {
    { name = 'buffer' },
  }),
  sorting = {
    comparators = {}, -- We stop all sorting to let the lsp do the sorting
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 40, -- half max width
      menu = {
        buffer = "[buffer]",
        nvim_lsp = "[CiderLSP]",
        nvim_lua = "[API]",
        path = "[path]",
        ultisnips = "[snip]",
      },
    }),
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
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

-- First part of setup on LSP for Lua (https://github.com/folke/neodev.nvim)
require("neodev").setup({})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
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

-- Second part of setup on LSP for Lua.
lspconfig.lua_ls.setup({})

-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})
