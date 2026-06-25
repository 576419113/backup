local M = {}

M.groups = {
    ["@comment.luadoc"] = {  },
    ["@constant.builtin.luadoc"] = {  },
    ["@function.macro.luadoc"] = {  },
    ["@keyword.luadoc"] = {  },
    ["@keyword.coroutine.luadoc"] = {  },
    ["@keyword.function.luadoc"] = {  },
    ["@keyword.import.luadoc"] = {  },
    ["@keyword.modifier.luadoc"] = {  },
    ["@keyword.return.luadoc"] = {  },
    ["@module.luadoc"] = {  },
    ["@nospell.luadoc"] = {  },
    ["@number.luadoc"] = {  },
    ["@operator.luadoc"] = {  },
    ["@punctuation.bracket.luadoc"] = {  },
    ["@punctuation.delimiter.luadoc"] = {  },
    ["@punctuation.special.luadoc"] = {  },
    ["@spell.luadoc"] = {  },
    ["@string.luadoc"] = {  },
    ["@string.special.path.luadoc"] = {  },
    ["@type.luadoc"] = {  },
    ["@type.builtin.luadoc"] = {  },
    ["@variable.luadoc"] = {  },
    ["@variable.builtin.luadoc"] = {  },
    ["@variable.member.luadoc"] = {  },
    ["@variable.parameter.luadoc"] = {  },
}

M.setup = function()
    return M.groups
end

return M