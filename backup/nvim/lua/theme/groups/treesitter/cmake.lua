local M = {}

M.groups = {
    ["@boolean.cmake"] = {  },
    ["@comment.cmake"] = {  },
    ["@constant.cmake"] = {  },
    ["@function.cmake"] = {  },
    ["@function.builtin.cmake"] = {  },
    ["@function.macro.cmake"] = {  },
    ["@keyword.conditional.cmake"] = {  },
    ["@keyword.directive.cmake"] = {  },
    ["@keyword.function.cmake"] = {  },
    ["@keyword.modifier.cmake"] = {  },
    ["@keyword.operator.cmake"] = {  },
    ["@keyword.repeat.cmake"] = {  },
    ["@keyword.return.cmake"] = {  },
    ["@module.cmake"] = {  },
    ["@none.cmake"] = {  },
    ["@nospell.cmake"] = {  },
    ["@punctuation.bracket.cmake"] = {  },
    ["@punctuation.special.cmake"] = {  },
    ["@spell.cmake"] = {  },
    ["@string.cmake"] = {  },
    ["@string.escape.cmake"] = {  },
    ["@type.cmake"] = {  },
    ["@variable.cmake"] = {  },
    ["@variable.parameter.cmake"] = {  },
}

M.setup = function()
    return M.groups
end

return M