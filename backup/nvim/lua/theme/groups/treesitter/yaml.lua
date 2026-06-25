local M = {}

M.groups = {
    ["@boolean.yaml"] = {  },
    ["@comment.yaml"] = {  },
    ["@constant.builtin.yaml"] = {  },
    ["@keyword.directive.yaml"] = {  },
    ["@label.yaml"] = {  },
    ["@number.yaml"] = {  },
    ["@property.yaml"] = {  },
    ["@punctuation.bracket.yaml"] = {  },
    ["@punctuation.delimiter.yaml"] = {  },
    ["@punctuation.special.yaml"] = {  },
    ["@spell.yaml"] = {  },
    ["@string.yaml"] = {  },
    ["@string.escape.yaml"] = {  },
    ["@type.yaml"] = {  },
}

M.setup = function()
    return M.groups
end

return M