local M = {}

M.groups = {
    ["@boolean.vim"] = {  },
    ["@character.special.vim"] = {  },
    ["@comment.vim"] = {  },
    ["@constant.vim"] = {  },
    ["@constant.builtin.vim"] = {  },
    ["@function.vim"] = {  },
    ["@function.call.vim"] = {  },
    ["@function.macro.vim"] = {  },
    ["@keyword.vim"] = {  },
    ["@keyword.conditional.vim"] = {  },
    ["@keyword.conditional.ternary.vim"] = {  },
    ["@keyword.exception.vim"] = {  },
    ["@keyword.function.vim"] = {  },
    ["@keyword.operator.vim"] = {  },
    ["@keyword.repeat.vim"] = {  },
    ["@label.vim"] = {  },
    ["@module.vim"] = {  },
    ["@number.vim"] = {  },
    ["@number.float.vim"] = {  },
    ["@operator.vim"] = {  },
    ["@property.vim"] = {  },
    ["@punctuation.bracket.vim"] = {  },
    ["@punctuation.delimiter.vim"] = {  },
    ["@punctuation.special.vim"] = {  },
    ["@spell.vim"] = {  },
    ["@string.vim"] = {  },
    ["@string.regexp.vim"] = {  },
    ["@string.special.vim"] = {  },
    ["@string.special.path.vim"] = {  },
    ["@type.vim"] = {  },
    ["@variable.vim"] = {  },
    ["@variable.builtin.vim"] = {  },
    ["@variable.parameter.vim"] = {  },
}

M.setup = function()
    return M.groups
end

return M