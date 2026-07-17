--[[
-- LSP 后端配置 --
--]]

-- 启用的 LSP 后端
local language = {
    -- shell
    "bashls",
    -- C系列
    "clangd",
    -- Web系列
    "cssls", "html", "denols", "tsserver",
    -- Markdown
    "marksman",
    -- Python
    "pylsp",
    -- Lua
    "lua_ls",
    -- Qml
    "qmlls",
    -- 配置文件系列
    "jsonls", "yamlls",
}

-- blink.cmp 兼容性
vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Lua 配置
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim", "hl" } },
        },
    },
})

-- Python 配置
vim.lsp.config("pylsp", {
    settings = {
        pylsp = {
            plugins = {
                -- 关闭 codestyle
                pycodestyle = { enabled = false },
            },
        },
    },
})

-- Shell 配置
vim.filetype.add({
  extension = {
    zsh = "zsh",
    zshrc = "zsh",
  },
})
vim.lsp.config("bashls", {
    filetypes = { "sh", "bash", "zsh" },
})

-- Qmlls 配置
vim.lsp.config("qmlls", {
    on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

-- 启用语言
vim.lsp.enable(language)

--[[
-- LSP 诊断数据配置 --
--]]

-- 诊断文字前缀
local diagnostic_icon = {
    [vim.diagnostic.severity.ERROR] = " ",
    [vim.diagnostic.severity.WARN] = " ",
    [vim.diagnostic.severity.INFO] = " ",
    [vim.diagnostic.severity.HINT] = " ",
}

-- 配置
vim.diagnostic.config({
    underline = true, -- 告警下划线
    update_in_insert = true, -- 插入时更新告警信息
    -- 行尾诊断文字
    virtual_text = {
        spacing = 4,
        update_in_insert = true,
        prefix = function(diag)
            return diagnostic_icon[diag.severity]
        end,
    },
    signs = true, -- 行号旁符号
})

--[[
-- LSP 颜色预览 --
--]]
vim.lsp.document_color.enable(true, { nil, nil }, { style = "virtual" })
