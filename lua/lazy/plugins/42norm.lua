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

    -- Workaround: the plugin never reads the formatter's stdout, so c_formatter_42 dies with a broken pipe (exit 120)
    local formatter = require("42norm.formatter")
    local orig_format = formatter.format
    formatter.format = function(cmd)
      local popen = io.popen
      io.popen = function(...)
        local h = popen(...)
        if not h then return h end
        return setmetatable({}, {
          __index = function(_, k)
            if k == "close" then
              return function()
                h:read("*a")
                return h:close()
              end
            end
            return function(_, ...) return h[k](h, ...) end
          end,
        })
      end
      local ok, err = pcall(orig_format, cmd)
      io.popen = popen
      if not ok then error(err) end
    end

    require("42norm").setup({
      format_on_save = false,
      header_on_save = false,
      lint_on_change = true,
      timeout = 3000,
      ignore = {},
    })
  end,
}
