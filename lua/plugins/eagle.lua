-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/soulis-1256/eagle.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "soulis-1256/eagle.nvim",
  config = function()
    vim.o.mousemoveevent = true
    require("eagle").setup({})
  end,
}
