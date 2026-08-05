local mdtable = require('utils.markdown_table')

vim.api.nvim_create_user_command("FixMdTable", function()
	mdtable.fix_current_table()
end, {})
