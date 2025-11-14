-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- modular approach: using `require 'path.name'` will
  -- include a plugin definition from file lua/path/name.lua

  require 'lazy.plugins.gitsigns',

  require 'lazy.plugins.which-key',

  require 'lazy.plugins.telescope',

  require 'lazy.plugins.lspconfig',

  require 'lazy.plugins.conform',

  require 'lazy.plugins.blink-cmp',

  require 'lazy.plugins.todo-comments',

  require 'lazy.plugins.mini',

  require 'lazy.plugins.treesitter',

  require 'lazy.plugins.debug',

  -- require 'lazy.plugins.indent_line',

  require 'lazy.plugins.lint',

  require 'lazy.plugins.autopairs',

  require 'lazy.plugins.neo-tree',

  require 'lazy.plugins.nvim-colorizer',
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '$',
      config = 'cfg',
      event = 'event',
      ft = 'ft',
      init = 'init',
      keys = 'keys',
      plugin = 'plug',
      runtime = 'rt',
      require = 'req',
      source = 'src',
      start = 'start',
      task = 'task',
      lazy = 'lazy',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
