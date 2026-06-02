-- 符号
vim.fn.sign_define("DiffChange", {
    text = "┃",
    texthl = "DiagnosticWarn",
})
vim.fn.sign_define("DiffSave", {
    text = "┃",
    texthl = "DiagnosticInfo",
})

-- 缓存磁盘内容
local disk_lines = {}
local function cache_disk_file(bufnr)
    bufnr = bufnr or 0
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == "" then return end
    local f = io.open(path, "r")
    if not f then return end
    disk_lines[bufnr] = vim.split(f:read("*a"), "\n")
    f:close()
end

-- 清除旧 sign
local function clear_signs(bufnr)
    vim.fn.sign_unplace("DiffChange", { buffer = bufnr })
end

-- 计算 diff 并打 sign
local function update_marks(bufnr)
    bufnr = bufnr or 0
    if not disk_lines[bufnr] then return end
    clear_signs(bufnr)
    local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local diff = vim.diff(
        table.concat(disk_lines[bufnr], "\n"),
        table.concat(buf_lines, "\n"),
        { result_type = "unified" }
    )
    for hunk in diff:gmatch("@@.-@@\n(.-)\n") do
        local line_num = tonumber(hunk:match("@@ %-%d+,%d+ %+(%d+)")) or 0
        for line in hunk:gmatch("[^\n]+") do
            if line:sub(1, 1) == "+" then
                vim.fn.sign_place(
                    0, "DiffSings", "DiffChange", bufnr,
                    { lnum = line_num, priority = 10 }
                )
            elseif line:sub(1, 1) == "-" then
                vim.fn.sign_place(
                    0, "DiffSigns", "DiffSave", bufnr,
                    { lnum = line_num, priority = 10 }
                )
            end
            line_num = line_num + 1
        end
    end
end

-- 自动事件
local group = vim.api.nvim_create_augroup("DiffSigns", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
    group = group,
    callback = function(ev)
        cache_disk_file(ev.buf)
        update_marks(ev.buf)
    end,
})

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
    group = group,
    callback = function(ev)
        update_marks(ev.buf)
    end,
})
