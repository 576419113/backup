local M = {}

M.groups = {
    ["@constant.luap"] = {  },
    ["@operator.luap"] = {  },
    ["@punctuation.bracket.luap"] = {  },
    ["@punctuation.delimiter.luap"] = {  },
    ["@string.escape.luap"] = {  },
    ["@string.regexp.luap"] = {  },
    ["@variable.builtin.luap"] = {  },
    ["@variable.parameter.luap"] = {  },
}

M.setup = function()
    return M.groups
end

return M