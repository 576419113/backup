local M = {}

M.groups = {
    ["@attribute.xml"] = {  },
    ["@boolean.xml"] = {  },
    ["@character.xml"] = {  },
    ["@character.special.xml"] = {  },
    ["@comment.xml"] = {  },
    ["@constant.xml"] = {  },
    ["@constant.builtin.xml"] = {  },
    ["@function.macro.xml"] = {  },
    ["@keyword.xml"] = {  },
    ["@keyword.directive.xml"] = {  },
    ["@keyword.directive.define.xml"] = {  },
    ["@keyword.modifier.xml"] = {  },
    ["@label.xml"] = {  },
    ["@markup.raw.xml"] = {  },
    ["@module.xml"] = {  },
    ["@none.xml"] = {  },
    ["@number.xml"] = {  },
    ["@operator.xml"] = {  },
    ["@punctuation.bracket.xml"] = {  },
    ["@punctuation.delimiter.xml"] = {  },
    ["@spell.xml"] = {  },
    ["@string.xml"] = {  },
    ["@string.special.xml"] = {  },
    ["@string.special.url.xml"] = {  },
    ["@tag.xml"] = {  },
    ["@tag.attribute.xml"] = {  },
    ["@tag.delimiter.xml"] = {  },
    ["@type.builtin.xml"] = {  },
    ["@type.definition.xml"] = {  },
}

M.setup = function()
    return M.groups
end

return M