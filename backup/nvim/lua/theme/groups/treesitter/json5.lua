local M = {}

M.groups = {
    ["@boolean.json5"] = {  },
    ["@comment.json5"] = {  },
    ["@constant.json5"] = {  },
    ["@keyword.json5"] = {  },
    ["@number.json5"] = {  },
    ["@spell.json5"] = {  },
    ["@string.json5"] = {  },
}

M.setup = function()
    return M.groups
end

return M