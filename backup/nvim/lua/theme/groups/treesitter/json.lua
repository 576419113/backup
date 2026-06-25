local M = {}

M.groups = {
    ["@boolean.json"] = {  },
    ["@comment.json"] = {  },
    ["@conceal.json"] = {  },
    ["@constant.builtin.json"] = {  },
    ["@number.json"] = {  },
    ["@property.json"] = {  },
    ["@punctuation.bracket.json"] = {  },
    ["@punctuation.delimiter.json"] = {  },
    ["@spell.json"] = {  },
    ["@string.json"] = {  },
    ["@string.escape.json"] = {  },
}

M.setup = function()
    return M.groups
end

return M