return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    -- Use LSP formatting when the attached server supports it.
    -- Formatters listed in formatters_by_ft are only used as fallback for
    -- filetypes where no LSP formatter is available.
    --
    -- TODO: if two LSP clients both support formatting for the same filetype,
    -- narrow it down with default_format_opts = { filter = function(c) return c.name == "rust_analyzer" end }
    default_format_opts = {
      lsp_format = "prefer",
      timeout_ms = 500,
    },
    format_on_save = {},
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
    },
  },
}
