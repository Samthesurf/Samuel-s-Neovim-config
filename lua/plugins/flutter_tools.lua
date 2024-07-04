-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/akinsho/flutter-tools.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  ft = {dart},
  dependencies = {
      'stevearc/dressing.nvim',
  },
  config = function ()
    require("flutter-tools").setup{}
  end,
}
