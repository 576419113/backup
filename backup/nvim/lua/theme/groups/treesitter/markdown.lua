local M = {}

M.groups = {
    ["@keyword.directive.markdown"] = {  },
    ["@label.markdown"] = {  },
    ["@markup.heading.markdown"] = {  },
    ["@markup.heading.1.markdown"] = {  },
    ["@markup.heading.2.markdown"] = {  },
    ["@markup.heading.3.markdown"] = {  },
    ["@markup.heading.4.markdown"] = {  },
    ["@markup.heading.5.markdown"] = {  },
    ["@markup.heading.6.markdown"] = {  },
    ["@markup.link.label.markdown"] = {  },
    ["@markup.link.url.markdown"] = {  },
    ["@markup.list.markdown"] = {  },
    ["@markup.list.checked.markdown"] = {  },
    ["@markup.list.unchecked.markdown"] = {  },
    ["@markup.quote.markdown"] = {  },
    ["@markup.raw.block.markdown"] = {  },
    ["@punctuation.delimiter.markdown"] = {  },
    ["@punctuation.special.markdown"] = {  },
    ["@spell.markdown"] = {  },
    ["@string.escape.markdown"] = {  },
}

M.setup = function()
    return M.groups
end

return M