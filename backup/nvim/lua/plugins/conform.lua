local format_path = vim.fn.stdpath("config") .. "/format"
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clang-format" },
        c = { "clang-format" },
    },
    formatters = {
        stylua = {
            prepend_args = { "--config-path", format_path .. "/stylua.toml" },
        },
        ["clang-format"] = {
            prepend_args = { "--style=file:" .. format_path .. "/clang-format.yaml" }
        }
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
})

vim.api.nvim_create_user_command("Cfmt", function()
    require("conform").format({ async = true })
end, {})
