local parsers = {
    -- Shell
    "bash", "zsh",
    -- C/C++系列
    "c", "cpp", "cmake", "make",
    -- Python
    "python",
    -- Web系列
    "html", "html_tags", "javascript", "css",
    -- Lua系列
    "lua", "luadoc", "luap",
    -- 配置文件系列
    "xml", "json", "json5", "ini", "toml", "yaml",
    -- MarkDown系列
    "markdown", "markdown_inline",
    -- Qml 系列
    "qmldir", "qmljs",
}

require("tree-sitter-manager").setup({
    ensure_installed = parsers,
    highlight = true,
})
