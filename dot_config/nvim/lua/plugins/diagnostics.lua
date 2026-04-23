return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    vim.diagnostic.config({
      virtual_lines = { current_line = true },
      virtual_text = false,
    })
  end,
  keys = {
    { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle diagnostics" }
  },
}
