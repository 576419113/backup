local M = {}

M.groups = {
    ["@comment.ini"] = {  },
    ["@markup.heading.ini"] = {  },
    ["@operator.ini"] = {  },
    ["@property.ini"] = {  },
    ["@punctuation.bracket.ini"] = {  },
    ["@spell.ini"] = {  },
    ["@string.ini"] = {  },
}

M.setup = function()
    return M.groups
end

return M