local plugins = {
    -- LSP 插件
    "https://github.com/neovim/nvim-lspconfig",
    -- 代码补全插件
    "https://github.com/saghen/blink.cmp",
    "https://github.com/saghen/blink.lib",
    -- 自动配对插件
    "https://github.com/windwp/nvim-autopairs",
    -- 语法树插件
    "https://github.com/romus204/tree-sitter-manager.nvim",
    -- 缩进线插件
    "https://github.com/nvim-mini/mini.indentscope",
    -- 文件差异
    "https://github.com/nvim-mini/mini.diff",
    -- 代码格式化插件
    "https://github.com/stevearc/conform.nvim",
    -- 颜色高亮预览插件
    "https://github.com/brenoprata10/nvim-highlight-colors",
}

vim.pack.add(plugins)
