local M = {}

M.groups = {
    ["@character.special.query"] = {  },
    ["@comment.query"] = {  },
    ["@function.call.query"] = {  },
    ["@keyword.query"] = {  },
    ["@keyword.directive.query"] = {  },
    ["@keyword.import.query"] = {  },
    ["@nospell.query"] = {  },
    ["@number.query"] = {  },
    ["@operator.query"] = {  },
    ["@property.query"] = {  },
    ["@punctuation.bracket.query"] = {  },
    ["@punctuation.delimiter.query"] = {  },
    ["@punctuation.special.query"] = {  },
    ["@spell.query"] = {  },
    ["@string.query"] = {  },
    ["@string.escape.query"] = {  },
    ["@string.regexp.query"] = {  },
    ["@type.query"] = {  },
    ["@variable.query"] = {  },
    ["@variable.member.query"] = {  },
}

M.setup = function()
    return M.groups
end

return M