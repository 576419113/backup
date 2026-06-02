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


--[[
-- lua/breeze --
--]]
require("breeze.init").setup()


--[[
-- lua --
--]]
--require("diffsigns")
