local M = {}

M.groups = {
    ["@character.special.markdown_inline"] = {  },
    ["@conceal.markdown_inline"] = {  },
    ["@markup.italic.markdown_inline"] = {  },
    ["@markup.link.markdown_inline"] = {  },
    ["@markup.link.label.markdown_inline"] = {  },
    ["@markup.link.url.markdown_inline"] = {  },
    ["@markup.raw.markdown_inline"] = {  },
    ["@markup.strikethrough.markdown_inline"] = {  },
    ["@markup.strong.markdown_inline"] = {  },
    ["@nospell.markdown_inline"] = {  },
    ["@string.escape.markdown_inline"] = {  },
}

M.setup = function()
    return M.groups
end

return M