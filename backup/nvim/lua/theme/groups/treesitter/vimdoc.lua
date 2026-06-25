local M = {}

M.groups = {
    ["@comment.error.vimdoc"] = {  },
    ["@comment.note.vimdoc"] = {  },
    ["@comment.warning.vimdoc"] = {  },
    ["@keyword.directive.vimdoc"] = {  },
    ["@label.vimdoc"] = {  },
    ["@markup.heading.1.vimdoc"] = {  },
    ["@markup.heading.1.delimiter.vimdoc"] = {  },
    ["@markup.heading.2.vimdoc"] = {  },
    ["@markup.heading.2.delimiter.vimdoc"] = {  },
    ["@markup.heading.3.vimdoc"] = {  },
    ["@markup.heading.4.vimdoc"] = {  },
    ["@markup.link.vimdoc"] = {  },
    ["@markup.raw.vimdoc"] = {  },
    ["@markup.raw.block.vimdoc"] = {  },
    ["@string.special.vimdoc"] = {  },
    ["@string.special.url.vimdoc"] = {  },
    ["@variable.parameter.vimdoc"] = {  },
}

M.setup = function()
    return M.groups
end

return M