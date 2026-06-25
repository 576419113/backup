local M = {}

M.groups = {
    ["@character.special.bash"] = {  },
    ["@comment.bash"] = {  },
    ["@constant.bash"] = {  },
    ["@function.bash"] = {  },
    ["@function.builtin.bash"] = {  },
    ["@function.call.bash"] = {  },
    ["@keyword.bash"] = {  },
    ["@keyword.conditional.bash"] = {  },
    ["@keyword.conditional.ternary.bash"] = {  },
    ["@keyword.directive.bash"] = {  },
    ["@keyword.function.bash"] = {  },
    ["@keyword.import.bash"] = {  },
    ["@keyword.repeat.bash"] = {  },
    ["@label.bash"] = {  },
    ["@none.bash"] = {  },
    ["@nospell.bash"] = {  },
    ["@number.bash"] = {  },
    ["@operator.bash"] = {  },
    ["@punctuation.bracket.bash"] = {  },
    ["@punctuation.delimiter.bash"] = {  },
    ["@punctuation.special.bash"] = {  },
    ["@spell.bash"] = {  },
    ["@string.bash"] = {  },
    ["@string.regexp.bash"] = {  },
    ["@string.special.bash"] = {  },
    ["@string.special.path.bash"] = {  },
    ["@variable.bash"] = {  },
    ["@variable.builtin.bash"] = {  },
    ["@variable.parameter.bash"] = {  },
}

M.setup = function()
    return M.groups
end

return M