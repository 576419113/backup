-- 根据本地文件构造缓存组配置
local function disk_get(path)
    local temp_groups = {}
    local disk_groups = {}
    if vim.fn.filereadable(path) == 1 then
        local module = "theme." .. path:gsub("/", "."):sub(1, -5)
        package.loaded[module] = nil
        disk_groups = require(module).setup()
        for key, value in pairs(disk_groups) do
            local parts = {}
            for vk, vv in pairs(value) do
                if type(vv) == "string" then
                    vv = '"' .. vv .. '"'
                elseif type(vv) == "number" then
                    vv = tostring(vv)
                end
                parts[#parts + 1] = tostring(vk) .. " = " .. vv
            end
            temp_groups[key] = table.concat(parts, ", ")
        end
    end
    return temp_groups
end

-- 根据目标组和磁盘组写入磁盘，filetype区分主与类型模式
-- target_groups
-- {
--     ["@variable"] = { cpp, c }
-- }
-- disk_groups
-- {
--     ["variable"] = { fg = "#123456" }
-- }
local function disk_write(path, target_groups, disk_groups, filetype)
    local keys = {}
    for key in pairs(target_groups) do
        table.insert(keys, key)
    end
    table.sort(keys)
    local file = io.open(path, "w")
    if not file then
        goto done
    end
    file:write("local M = {}\n\nM.groups = {\n")
    for _, key in ipairs(keys) do
        if target_groups[key] then
            if filetype == nil then
                file:write(
                    string.format(
                        '    -- %s\n    ["%s"] = { %s },\n',
                        table.concat(target_groups[key], ","),
                        key,
                        disk_groups[key] or ""
                    )
                )
            else
                file:write(string.format('    ["%s.' .. filetype .. '"] = { %s },\n', key, disk_groups[key] or ""))
            end
        end
    end
    file:write("}\n\nM.setup = function()\n    return M.groups\nend\n\nreturn M")
    file:close()
    ::done::
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
for lang in pairs(tlangs) do
    local ok, queries = pcall(vim.treesitter.query.get, lang, "highlights")
    local disk_filetype_groups = disk_get("groups/treesitter/" .. lang)
    local target_filetype_groups = {}
    if ok and queries then
        for _, capture in ipairs(queries.captures or {}) do
            if capture:find("_") then
                goto treesitter_continue
            end
            if not target_treesitter_groups["@" .. capture] then
                target_treesitter_groups["@" .. capture] = {}
            end
            local list = target_treesitter_groups["@" .. capture]
            if not vim.tbl_contains(list, lang) then
                table.insert(list, lang)
            end
            if not target_filetype_groups["@" .. capture] then
                target_filetype_groups["@" .. capture] = {}
            end
            list = target_filetype_groups["@" .. capture]
            if not vim.tbl_contains(list, lang) then
                table.insert(list, lang)
            end
            ::treesitter_continue::
        end
    end
    disk_write("groups/treesitter/" .. lang .. ".lua", target_filetype_groups, disk_filetype_groups, lang)
end
disk_write("groups/treesitter.lua", target_treesitter_groups, disk_treesitter_groups)

-- ============================================================
-- lsp 高亮组
-- ============================================================

for _, client in ipairs(vim.lsp.get_clients()) do
    print(string.format("Client: %s (id=%d)", client.name, client.id))
    local provider = client.server_capabilities.semanticTokensProvider
    if provider and provider.legend then
        local legend = provider.legend
        print("  Token Types:")
        for _, token in ipairs(legend.tokenTypes) do
            print(token)
        end
        print("  Token Modifiers:")
        for _, token in ipairs(legend.tokenModifiers) do
            print(token)
        end
    else
        print("  ⚠ No semanticTokensProvider")
    end
end
