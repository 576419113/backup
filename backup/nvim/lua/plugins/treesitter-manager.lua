local parsers = {
    -- Shell
    "bash",
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
    "markdown", "markdown_inline"
}

require("tree-sitter-manager").setup({
    ensure_installed = parsers, -- list of parsers to install at the start of a neovim session. If set to "all", install all parsers.
    highlight = true,
})
