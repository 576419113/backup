--[[高亮设置语法
nvim_set_hl({ns_id}, {name}, {val})
配置高亮组，默认情况下替换整个配置(如`nvim_set_hl(0, 'Visual', {})`将清除Visual组)，除非指定了`update`选项。
注意：
# fg与bg也支持字面量"fg"或者"bg"，这将应用Normal组的fg与bg(若Norml组fg/bg不存在则返回错误)
# 一旦link被使用，所有其他属性都会被忽略​
语法：
# {ns_id} = integer. 0表示全局配置
# {name} = string. 高亮组名称
# {val} = map. 选项表，可以为以下的选项
- altfont = boolean. 使用替代字体
- bg = string. 背景色，颜色名称或者RGB
- bg_indexed = boolean. 背景色仅为ctermbg的颜色估计，采用ctermbg的样式
- blend = integer. 前景与背景混合程度，0-100
- blink = boolean. 闪烁
- bold = boolean. 加粗
- conceal = boolean. 若为真，“能”隐藏此部分，但隐藏逻辑又其他组件控制
- cterm: cterm attribute map. 设置终端文本的显示属性
- ctermbg: 设置终端背景的显示属性
- ctermfg: 设置终端前景的显示属性
- default = boolean. 只有当该高亮组尚未定义​时所有的配置才生效
- dim = boolean. 变暗
- fg = string. 前景色，颜色名称或者RGB
- fg_indexed = boolean. 前景色仅为ctermfg的颜色估计，采用ctermfg的样式
- force = boolean (default false). 直接覆盖此高亮组
- italic = boolean. 斜体
- link = string. 链接到高亮组名称
- link_global = string. 与link相似，但为全局配置
- nocombine = boolean. 只使用当前高亮定义，不要把其他高亮组的属性合并进来
- overline = boolean. 上划线
- reverse = boolean. 前景色与背景色反色
- sp = string. 特殊装饰(如下划线)的颜色，可以是名称或RGB
- standout = boolean. 突出显示
- strikethrough = boolean. 删除线
- undercurl = boolean. 波浪下划线
- underdashed = boolean. 虚线下划线
- underdotted = boolean. 点状下划线
- underdouble = boolean. 双下划线
- underline = boolean. 下划线
- update = boolean (default false). 只修改你明确写出来的高亮属性，其余全部保留原样
--]]

local M = {}

local groups = require("breeze.groups").setup()

local function str_to_map(str)
    if type(str) ~= "string" then
        return nil
    end
    local ok, chunk = pcall(load, "return " .. str)
    if not ok or not chunk then
        return nil
    end
    local success, result = pcall(chunk)
    if success and type(result) == "table" then
        return result
    end
    return nil
end

M.setup = function()
    local color = {}
    vim.cmd.hi("clear")
    if vim.o.background == "dark" then
        color = require("breeze.breeze-dark").setup()
        vim.g.colors_name = "breeze-dark"
    else
        color = require("breeze.breeze-light").setup()
        vim.g.colors_name = "breeze-light"
    end
    for group,group_value in pairs(groups) do
        local value = {}
        if group_value:find("#", 1, true) then
            value = str_to_map(group_value:sub(2, -1))
            vim.api.nvim_set_hl(0, group, value)
        else
            if color[group_value] == nil then
                vim.notify("group " .. group .. " mismatched!", vim.log.levels.WARN)
                goto continue
            end
            value = color[group_value]
            vim.api.nvim_set_hl(0, group, value)
        end
        ::continue::
    end
end

return M
