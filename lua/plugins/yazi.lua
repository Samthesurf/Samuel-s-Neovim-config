return {
  "mikavilpas/yazi.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  cmd = { "Yazi" },
  keys = {
    {
      "<leader>-",
      "<cmd>Yazi<cr>",
      mode = { "n", "v" },
      desc = "Open yazi file manager",
    },
    {
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open yazi in nvim working directory",
    },
  },
  -- -@type YaziConfig
  opts = {
    open_for_directories = false,
  },
}
