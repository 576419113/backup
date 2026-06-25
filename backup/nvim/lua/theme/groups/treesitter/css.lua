local M = {}

M.groups = {
    ["@attribute.css"] = {  },
    ["@character.special.css"] = {  },
    ["@comment.css"] = {  },
    ["@constant.css"] = {  },
    ["@function.css"] = {  },
    ["@keyword.css"] = {  },
    ["@keyword.directive.css"] = {  },
    ["@keyword.import.css"] = {  },
    ["@keyword.modifier.css"] = {  },
    ["@keyword.operator.css"] = {  },
    ["@module.css"] = {  },
    ["@number.css"] = {  },
    ["@number.float.css"] = {  },
    ["@operator.css"] = {  },
    ["@property.css"] = {  },
    ["@punctuation.bracket.css"] = {  },
    ["@punctuation.delimiter.css"] = {  },
    ["@spell.css"] = {  },
    ["@string.css"] = {  },
    ["@tag.css"] = {  },
    ["@tag.attribute.css"] = {  },
    ["@type.css"] = {  },
    ["@variable.css"] = {  },
}

M.setup = function()
    return M.groups
end

return M