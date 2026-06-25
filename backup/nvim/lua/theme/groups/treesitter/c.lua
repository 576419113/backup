local M = {}

M.groups = {
    ["@attribute.c"] = {  },
    ["@boolean.c"] = {  },
    ["@character.c"] = {  },
    ["@comment.c"] = {  },
    ["@comment.documentation.c"] = {  },
    ["@constant.c"] = {  },
    ["@constant.builtin.c"] = {  },
    ["@constant.macro.c"] = {  },
    ["@function.c"] = {  },
    ["@function.builtin.c"] = {  },
    ["@function.call.c"] = {  },
    ["@function.macro.c"] = {  },
    ["@keyword.c"] = {  },
    ["@keyword.conditional.c"] = {  },
    ["@keyword.conditional.ternary.c"] = {  },
    ["@keyword.directive.c"] = {  },
    ["@keyword.directive.define.c"] = {  },
    ["@keyword.import.c"] = {  },
    ["@keyword.modifier.c"] = {  },
    ["@keyword.operator.c"] = {  },
    ["@keyword.repeat.c"] = {  },
    ["@keyword.return.c"] = {  },
    ["@keyword.type.c"] = {  },
    ["@label.c"] = {  },
    ["@number.c"] = {  },
    ["@operator.c"] = {  },
    ["@property.c"] = {  },
    ["@punctuation.bracket.c"] = {  },
    ["@punctuation.delimiter.c"] = {  },
    ["@punctuation.special.c"] = {  },
    ["@spell.c"] = {  },
    ["@string.c"] = {  },
    ["@string.escape.c"] = {  },
    ["@type.c"] = {  },
    ["@type.builtin.c"] = {  },
    ["@type.definition.c"] = {  },
    ["@variable.c"] = {  },
    ["@variable.builtin.c"] = {  },
    ["@variable.parameter.c"] = {  },
}

M.setup = function()
    return M.groups
end

return M