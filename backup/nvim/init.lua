--[[
-- lua/breeze --
--]]
require("breeze.init").setup()


--[[
-- lua/config --
--]]
-- 载入 nvim 选项
require("config.options")
-- 载入插件列表
require("config.plugins")
-- 载入 LSP 配置
require("config.lsp")


--[[
-- lua/plugins --
--]]
-- 载入 blink.cmp 自动补全插件
require("plugins.blink-cmp")
-- 载入 nvim-autopairs 配对插件
require("plugins.nvim-autopairs")
-- 载入 treesitter-manager 语法树插件
require("plugins.treesitter-manager")
-- 载入 mini.indentscope 缩进线插件
require("plugins.mini-indentscope")
-- 载入 mini.diff 文件差异插件
require("plugins.mini-diff")
-- 载入 conform 代码格式化插件
require("plugins.conform")
-- 载入 highlight-colors 插件
require("plugins.highlight-colors")
