local M = {}

M.groups = {
    ["@attribute.lua"] = {  },
    ["@boolean.lua"] = {  },
    ["@comment.lua"] = {  },
    ["@comment.documentation.lua"] = {  },
    ["@constant.lua"] = {  },
    ["@constant.builtin.lua"] = {  },
    ["@constructor.lua"] = {  },
    ["@function.lua"] = {  },
    ["@function.builtin.lua"] = {  },
    ["@function.call.lua"] = {  },
    ["@function.method.lua"] = {  },
    ["@function.method.call.lua"] = {  },
    ["@keyword.lua"] = {  },
    ["@keyword.conditional.lua"] = {  },
    ["@keyword.coroutine.lua"] = {  },
    ["@keyword.directive.lua"] = {  },
    ["@keyword.function.lua"] = {  },
    ["@keyword.operator.lua"] = {  },
    ["@keyword.repeat.lua"] = {  },
    ["@keyword.return.lua"] = {  },
    ["@label.lua"] = {  },
    ["@module.builtin.lua"] = {  },
    ["@number.lua"] = {  },
    ["@operator.lua"] = {  },
    ["@property.lua"] = {  },
    ["@punctuation.bracket.lua"] = {  },
    ["@punctuation.delimiter.lua"] = {  },
    ["@spell.lua"] = {  },
    ["@string.lua"] = {  },
    ["@string.escape.lua"] = {  },
    ["@string.regexp.lua"] = {  },
    ["@variable.lua"] = {  },
    ["@variable.builtin.lua"] = {  },
    ["@variable.member.lua"] = {  },
    ["@variable.parameter.lua"] = {  },
    ["@variable.parameter.builtin.lua"] = {  },
}

M.setup = function()
    return M.groups
end

return M