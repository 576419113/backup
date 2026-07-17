-- 根据本地文件构造缓存组配置
-- 返回字符串键值表
local function disk_get(path)
    local temp_groups = {}
    local disk_groups = {}
    if vim.fn.filereadable(path) == 1 then
        local module = "breeze." .. path:gsub("/", "."):sub(1, -5)
        package.loaded[module] = nil
        disk_groups = require(module).setup()
        for key, value in pairs(disk_groups) do
            local parts = {}
            for vk, vv in pairs(value) do
                if type(vv) == "string" then
                    vv = '"' .. vv .. '"'
                elseif type(vv) == "number" then
                    vv = tostring(vv)
                elseif type(vv) == "boolean" then
                    vv = tostring(vv)
                end
                parts[#parts + 1] = tostring(vk) .. " = " .. vv
            end
            temp_groups[key] = table.concat(parts, ", ")
        end
    end
    return temp_groups
end

-- ============================================================
-- treesitter 高亮组
-- ============================================================

local disk_treesitter_groups = disk_get("groups/treesitter.lua")
local target_treesitter_groups = {}
local tlangs = {}
for _, path in ipairs(vim.api.nvim_get_runtime_file("queries/*/*.scm", true)) do
    local lang = path:match("queries/([^/]+)/")
    if lang then
        tlangs[lang] = true
    end
end
local langs_captures = {}
for lang in pairs(tlangs) do
    langs_captures[lang] = {}
    local ok, queries = pcall(vim.treesitter.query.get, lang, "highlights")
    if ok and queries then
        for _, capture in ipairs(queries.captures or {}) do
            if capture:sub(1, 1) == "_" then
                goto treesitter_continue
            end
            if not target_treesitter_groups["@" .. capture] then
                target_treesitter_groups["@" .. capture] = {}
            end
            local list = target_treesitter_groups["@" .. capture]
            if not vim.tbl_contains(list, lang) then
                table.insert(list, lang)
            end
            if not vim.tbl_contains(langs_captures[lang], "@" .. capture) then
                table.insert(langs_captures[lang], "@" .. capture)
            end
            ::treesitter_continue::
        end
    end
    table.sort(langs_captures[lang])
    local temp = langs_captures[lang]
    langs_captures[lang] = table.concat(temp, ", ")
end
-- 写入磁盘
local keys = {}
for key in pairs(target_treesitter_groups) do
    table.insert(keys, key)
end
table.sort(keys)
local file = io.open("groups/treesitter.lua", "w")
if not file then
    print("Error open files!")
    goto done
end
file:write("local M = {}\n\nM.groups = {\n")
for _, key in ipairs(keys) do
    if target_treesitter_groups[key] then
        file:write(
            string.format(
                '    -- %s\n    ["%s"] = { %s },\n',
                table.concat(target_treesitter_groups[key], ","),
                key,
                disk_treesitter_groups[key] or ""
            )
        )
    else
        file:write(
            string.format(
                '    ["%s"] = { %s },\n',
                key,
                disk_treesitter_groups[key] or ""
            )
        )
    end
end
file:write("}\n\nM.setup = function()\n    return M.groups\nend\n\nreturn M\n\n")
keys = {}
for key in pairs(langs_captures) do
    table.insert(keys, key)
end
table.sort(keys)
for _,key in ipairs(keys) do
    file:write(string.format('-- %s: %s\n\n', key, langs_captures[key]))
end
file:close()
::done::
