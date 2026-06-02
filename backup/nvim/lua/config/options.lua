local o = vim.opt

--[[
-- 补全与缩进 --
--]]
--[[ 与 blink.cmp 有冲突
o.autocomplete = true                       -- 显示补全菜单
o.autocompletedelay = 100                   -- 补全延迟100ms
--]]
o.autoindent = true                         -- 自动缩进
o.copyindent = true                         -- 复制已有行的缩进
o.expandtab = true                          -- Tab 键为空格
o.preserveindent = true                     -- 尽量保持缩进结构
o.shiftround = true                         -- 缩进shiftwidth的整数倍
o.shiftwidth = 4                            -- 缩进4为一级
o.smartindent = true                        -- 智能缩进
o.smarttab = true                           -- 智能Tab键


--[[
-- 外观更进 --
--]]
o.cursorline = true                         -- 高亮当前行
o.display = "uhex"                          -- 不可见字符显示为Hex
-- 不显示右侧续行标记和缓冲区结束符号
o.fillchars:append({ eob = " ", lastline = " " })
o.guicursor = "a:block"                     -- 所有模式均为方块
-- 修正符号显示
o.list = true
o.listchars = { tab = "⇥ ", trail = "·", nbsp = "␣" }
o.number = true                             -- 显示行号
o.relativenumber = true                     -- 显示相对行号
o.showmode = true                           -- 显示当前模式


--[[
-- 其他 --
--]]
o.clipboard = "unnamedplus"                 -- 使用系统剪切板
o.history = 100                             -- 保存100条历史命令
o.mouse = "a"                               -- 允许使用鼠标
o.mousehide = true                          -- 输入时隐藏鼠标
o.updatetime = 100                          -- 磁盘同步时间为100ms
