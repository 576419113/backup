local M = {}

M.groups = {
    ["@attribute.dtd"] = {  },
    ["@character.dtd"] = {  },
    ["@character.special.dtd"] = {  },
    ["@comment.dtd"] = {  },
    ["@constant.dtd"] = {  },
    ["@constant.builtin.dtd"] = {  },
    ["@function.macro.dtd"] = {  },
    ["@keyword.dtd"] = {  },
    ["@keyword.directive.dtd"] = {  },
    ["@keyword.directive.define.dtd"] = {  },
    ["@keyword.import.dtd"] = {  },
    ["@keyword.modifier.dtd"] = {  },
    ["@label.dtd"] = {  },
    ["@number.dtd"] = {  },
    ["@operator.dtd"] = {  },
    ["@punctuation.bracket.dtd"] = {  },
    ["@punctuation.delimiter.dtd"] = {  },
    ["@spell.dtd"] = {  },
    ["@string.dtd"] = {  },
    ["@string.special.dtd"] = {  },
    ["@string.special.url.dtd"] = {  },
    ["@tag.dtd"] = {  },
    ["@tag.attribute.dtd"] = {  },
    ["@tag.delimiter.dtd"] = {  },
    ["@type.builtin.dtd"] = {  },
}

M.setup = function()
    return M.groups
end

return M