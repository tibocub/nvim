return {
  { -- Highlight, edit, and navigate code
    -- master branch is archived and breaks on nvim 0.12 (markdown injections); use main
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- installs only missing parsers, async
      require('nvim-treesitter').install {
        'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
        'javascript', 'css', 'cmake', 'dockerfile', 'yaml', 'toml', 'typescript', 'python',
      }
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          -- start highlighting if a parser exists for this filetype
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
