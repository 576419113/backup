local npairs = require'nvim-autopairs'
local Rule = require'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'
-- 初始化
require("nvim-autopairs").setup()
-- 查看原始 rules
-- print(vim.inspect(require('nvim-autopairs').get_rules("'")))
-- !!!警告：npairs 仅使用 start_pairs 与 trigger_key 排序，谨慎处理
-- !!!注意：要么 start_pairs 唯一，要么有 trigger_key
local rules = {}

-- 插入配对
local insert_pairs = {
    [" "] = {
        { '{', '}' },
        { '[', ']' },
        { '(', ')' },
    }
}

-----------------------------------------------
-----------------------------------------------

-- 插入配对
for key, item in pairs(insert_pairs) do
    local r = Rule(key, key)
        :with_pair(function(opts)
            local result = false
            for _,items in ipairs(item) do
                if items[1] .. items[2] == opts.line:sub(opts.col - #items[1], opts.col + #items[2] - 1) then
                    result = true
                    break
                end
            end
            return result
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local result = false
            for _,items in ipairs(item) do
                if items[1] .. key .. key .. items[2] ==
                    opts.line:sub(col - #items[1] - #key + 1, col + #key + #item[2]) then
                    result = true
                    break
                end
            end
            return result
        end)
    table.insert(rules, r)
end

-- 查看当前 rules
--print(vim.inspect(rules))

-- 一次性规则添加
npairs.add_rules(rules)
