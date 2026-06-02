-- 安装必要的本地库
require('blink.cmp').build()

-- blink.cmp 配置
require("blink.cmp").setup({
    -- 在 MarkDown 中禁用补全
    enabled = function() return not vim.tbl_contains({ "markdown" }, vim.bo.filetype) end,
    -- 在命令行中启用
    cmdline = { enabled = true },
    -- 补全配置
    completion = {
        -- 前后模糊搜索
        keyword = { range = 'full' },
        -- 补全触发
        trigger = {
            prefetch_on_insert = true,                    -- 提前请求补全项，减少延迟
            show_on_insert = false,                       -- 插入模式不自动显示
            show_on_keyword = true,                       -- 关键词显示
            show_on_trigger_character = true,             -- 输入关键符号显示
            show_on_backspace = false,                    -- 删除字符不显示
            show_on_backspace_in_keyword = false,         -- 删除字符在关键词内不显示
            show_on_backspace_after_accept = true,        -- 选完一个补全项后，再回到关键词中
            show_on_backspace_after_insert_enter = true,  -- 进入插入模式第一次回退
            -- 禁止这些字符触发补全
            show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
            show_on_accept_on_trigger_character = true,   -- 光标在触发字符后
            show_on_insert_on_trigger_character = true,   -- 插入模式光标在触发字符后
            -- 即使满足上面条件，也阻止补全
            show_on_x_blocked_trigger_characters = { "'", '"', '(' }
        },
        -- 禁用 LSP 的自动括号
        accept = { auto_brackets = { enabled = false } },
        -- 选表
        list = {
            -- 最大元素个数
            max_items = 200,
            -- 不自动预选，选中即插入
            selection = { preselect = false, auto_insert = true },
            -- 滚动循环
            cycle = { from_bottom = true, from_top = true },
        },
        menu = {
            -- 自动显示补全菜单
            auto_show = true,
            -- 补全菜单样式
            draw = {
                columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
                treesitter = { 'lsp' }
            },
        },
        -- 显示补全文档
        documentation = { auto_show = true, auto_show_delay_ms = 100, treesitter_highlighting = true },
    },
    -- 模糊搜索源
    fuzzy = { implementation = "prefer_rust_with_warning" },
    -- 配置补全源
    sources = {
        default = { 'lsp', 'path', 'buffer' },
    },
    -- 实验支持标志
    signature = { enabled = true }
})
