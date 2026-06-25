local M = {}

M.groups = {
    ["@boolean.toml"] = {  },
    ["@comment.toml"] = {  },
    ["@number.toml"] = {  },
    ["@number.float.toml"] = {  },
    ["@operator.toml"] = {  },
    ["@property.toml"] = {  },
    ["@punctuation.bracket.toml"] = {  },
    ["@punctuation.delimiter.toml"] = {  },
    ["@spell.toml"] = {  },
    ["@string.toml"] = {  },
    ["@string.escape.toml"] = {  },
    ["@string.special.toml"] = {  },
}

M.setup = function()
    return M.groups
end

return M