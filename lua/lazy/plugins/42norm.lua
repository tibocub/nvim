return {
  "MoulatiMehdi/42norm.nvim",

  keys = {
    {
      "<leader>nf",
      function()
        require("42norm").format()
      end,
      desc = "42 Formatter",
    },
    {
      "<leader>nh",
      function()
        require("42norm.header").stdheader()
      end,
      desc = "Insert 42 header",
    },
  },

  config = function()
    vim.g.user42 = "tlabesse"
    vim.g.mail42 = "tlabesse@learner.42.tech"

    require("42norm").setup({
      format_on_save = false,
      header_on_save = false,
      lint_on_change = false,
      timeout = 3000,
      ignore = {},
    })
  end,
}
