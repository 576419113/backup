local M = {}

M.groups = {
    ["@character.special.make"] = {  },
    ["@comment.make"] = {  },
    ["@function.make"] = {  },
    ["@function.builtin.make"] = {  },
    ["@keyword.make"] = {  },
    ["@keyword.conditional.make"] = {  },
    ["@keyword.import.make"] = {  },
    ["@operator.make"] = {  },
    ["@punctuation.special.make"] = {  },
    ["@spell.make"] = {  },
    ["@string.make"] = {  },
    ["@string.special.path.make"] = {  },
    ["@string.special.symbol.make"] = {  },
    ["@variable.builtin.make"] = {  },
}

M.setup = function()
    return M.groups
end

return M