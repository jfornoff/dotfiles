return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle diagnostics" }
  },
}
