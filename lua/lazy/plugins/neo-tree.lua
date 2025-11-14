-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ['<leader>e'] = 'close_window',
        ['Y'] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg('+', path, 'c')
          end,
          desc = 'Copy Path to Clipboard',
        },
        ['O'] = {
          function(state)
            require('lazy.util').open(state.tree:get_node().path, { system = true })
          end,
          desc = 'Open with System Application',
        },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        indent_size = 2,
        padding = 1,
        indent_marker = '│',
        last_indent_marker = '└',
        expander_collapsed = '+',
        expander_expanded = '-',
        expander_highlight = 'NeoTreeExpander',
        highlight = 'NeoTreeIndentMarker',
      },
      git_status = {
        symbols = {
          unstaged = '¤',
          staged = 's',
        },
      },
      icon = {
        folder_closed = '■',
        folder_open = '■',
        folder_empty = '■',
        folder_empty_open = '■',
        use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = '*',
        highlight = 'NeoTreeFileIcon',
        provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
          if node.type == 'file' or node.type == 'terminal' then
            local success, web_devicons = pcall(require, 'nvim-web-devicons')
            local name = node.type == 'terminal' and 'terminal' or node.name
            if success then
              local devicon, hl = web_devicons.get_icon(name)
              icon.text = devicon or icon.text
              icon.highlight = hl or icon.highlight
            end
          end
        end,
      },
    },
  },
}
