local M = {}

------------------------------------------------------------
-- utils
------------------------------------------------------------

local function is_table_line(line)
    return line:match("^%s*|") ~= nil
end

local function parse_row(line)
    local cells = {}

    line = line:gsub("^%s*|", "")
    line = line:gsub("|%s*$", "")

    for cell in (line .. "|"):gmatch("(.-)|") do
        table.insert(cells, vim.trim(cell))
    end

    return cells
end

local function is_separator_cell(cell)
    local s = cell:gsub("%s", "")
    return s:match("^:?-+:?$") ~= nil
end

local function is_separator_row(cells)
    for _, c in ipairs(cells) do
        if not is_separator_cell(c) then
            return false
        end
    end
    return true
end

------------------------------------------------------------
-- formatting
------------------------------------------------------------

local function format_row(cells, widths)
    local out = {}

    for i, cell in ipairs(cells) do
        local w = widths[i] or 0
        table.insert(out, " " .. cell .. string.rep(" ", w - vim.fn.strdisplaywidth(cell)) .. " ")
    end

    return "|" .. table.concat(out, "|") .. "|"
end

local function parse_alignment(cell)
    local left = cell:sub(1, 1) == ":"
    local right = cell:sub(-1) == ":"
    return left, right
end

local function format_separator(sep_cells, widths)
    local out = {}

    for i, cell in ipairs(sep_cells) do
        local left, right = parse_alignment(cell)

        local size = (widths[i] or 0) + 2
        local dashes = string.rep("-", math.max(3, size))

        if left then
            dashes = ":" .. dashes:sub(2)
        end

        if right then
            dashes = dashes:sub(1, -2) .. ":"
        end

        table.insert(out, dashes)
    end

    return "|" .. table.concat(out, "|") .. "|"
end

------------------------------------------------------------
-- main
------------------------------------------------------------

function M.fix_current_table()
    local bufnr = 0
    local cursor = vim.api.nvim_win_get_cursor(0)[1]

    --------------------------------------------------------
    -- find table bounds
    --------------------------------------------------------

    local start_line = cursor
    while start_line > 1 do
        local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 2, start_line - 1, false)[1]
        if not is_table_line(line) then
            break
        end
        start_line = start_line - 1
    end

    local end_line = cursor
    local last = vim.api.nvim_buf_line_count(bufnr)

    while end_line < last do
        local line = vim.api.nvim_buf_get_lines(bufnr, end_line, end_line + 1, false)[1]
        if not is_table_line(line) then
            break
        end
        end_line = end_line + 1
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

    if #lines < 2 then
        return
    end

    --------------------------------------------------------
    -- parse rows
    --------------------------------------------------------

    local rows = {}
    local widths = {}
    local separator = nil

    for _, line in ipairs(lines) do
        local cells = parse_row(line)

        if is_separator_row(cells) then
            separator = cells
        else
            table.insert(rows, cells)

            for i, cell in ipairs(cells) do
                local w = vim.fn.strdisplaywidth(cell)
                widths[i] = math.max(widths[i] or 0, w)
            end
        end
    end

    --------------------------------------------------------
    -- build output
    --------------------------------------------------------

    local output = {}

    for _, row in ipairs(rows) do
        table.insert(output, format_row(row, widths))
    end

    if separator then
        table.insert(output, 2, format_separator(separator, widths))
    end

    vim.api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, output)
end

return M
