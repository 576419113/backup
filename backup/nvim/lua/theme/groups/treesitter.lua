local M = {}

M.groups = {
    -- python,lua,xml,javascript,c,cpp,dtd,css
    ["@attribute"] = { k = 1, ss = "ssss" },
    -- python
    ["@attribute.builtin"] = {  },
    -- json5,yaml,json,python,lua,vim,xml,javascript,toml,c,cpp,cmake
    ["@boolean"] = {  },
    -- xml,c,cpp,dtd
    ["@character"] = {  },
    -- markdown_inline,bash,html,query,python,vim,xml,javascript,make,dtd,css
    ["@character.special"] = {  },
    -- json5,ini,yaml,json,bash,html,query,python,lua,vim,xml,javascript,make,toml,c,cpp,cmake,dtd,css,luadoc
    ["@comment"] = {  },
    -- lua,javascript,c,cpp
    ["@comment.documentation"] = {  },
    -- vimdoc
    ["@comment.error"] = {  },
    -- vimdoc
    ["@comment.note"] = {  },
    -- vimdoc
    ["@comment.warning"] = {  },
    -- markdown_inline,json
    ["@conceal"] = {  },
    -- json5,bash,html,python,lua,vim,xml,javascript,c,cpp,cmake,dtd,css,luap
    ["@constant"] = {  },
    -- yaml,json,python,lua,vim,xml,javascript,c,cpp,dtd,luadoc
    ["@constant.builtin"] = {  },
    -- c,cpp
    ["@constant.macro"] = {  },
    -- python,lua,javascript,cpp
    ["@constructor"] = {  },
    -- bash,python,lua,vim,javascript,make,c,cpp,cmake,css
    ["@function"] = {  },
    -- bash,python,lua,javascript,make,c,cpp,cmake
    ["@function.builtin"] = {  },
    -- bash,query,python,lua,vim,javascript,c,cpp
    ["@function.call"] = {  },
    -- python,vim,xml,c,cpp,cmake,dtd,luadoc
    ["@function.macro"] = {  },
    -- python,lua,javascript,cpp
    ["@function.method"] = {  },
    -- python,lua,javascript,cpp
    ["@function.method.call"] = {  },
    -- json5,bash,query,python,lua,vim,xml,javascript,make,c,cpp,dtd,css,luadoc
    ["@keyword"] = {  },
    -- bash,python,lua,vim,javascript,make,c,cpp,cmake
    ["@keyword.conditional"] = {  },
    -- bash,vim,javascript,c,cpp
    ["@keyword.conditional.ternary"] = {  },
    -- python,lua,javascript,cpp,luadoc
    ["@keyword.coroutine"] = {  },
    -- yaml,markdown,bash,query,vimdoc,python,lua,xml,javascript,c,cpp,cmake,dtd,css
    ["@keyword.directive"] = {  },
    -- xml,c,cpp,dtd
    ["@keyword.directive.define"] = {  },
    -- python,vim,javascript,cpp
    ["@keyword.exception"] = {  },
    -- bash,python,lua,vim,javascript,cmake,luadoc
    ["@keyword.function"] = {  },
    -- bash,query,python,javascript,make,c,cpp,dtd,css,luadoc
    ["@keyword.import"] = {  },
    -- xml,c,cpp,cmake,dtd,css,luadoc
    ["@keyword.modifier"] = {  },
    -- python,lua,vim,javascript,c,cpp,cmake,css
    ["@keyword.operator"] = {  },
    -- bash,python,lua,vim,javascript,c,cpp,cmake
    ["@keyword.repeat"] = {  },
    -- python,lua,javascript,c,cpp,cmake,luadoc
    ["@keyword.return"] = {  },
    -- python,javascript,c,cpp
    ["@keyword.type"] = {  },
    -- yaml,markdown,bash,vimdoc,lua,vim,xml,javascript,c,cpp,dtd
    ["@label"] = {  },
    -- ini,markdown,html,javascript
    ["@markup.heading"] = {  },
    -- markdown,html,vimdoc,javascript
    ["@markup.heading.1"] = {  },
    -- vimdoc
    ["@markup.heading.1.delimiter"] = {  },
    -- markdown,html,vimdoc,javascript
    ["@markup.heading.2"] = {  },
    -- vimdoc
    ["@markup.heading.2.delimiter"] = {  },
    -- markdown,html,vimdoc,javascript
    ["@markup.heading.3"] = {  },
    -- markdown,html,vimdoc,javascript
    ["@markup.heading.4"] = {  },
    -- markdown,html,javascript
    ["@markup.heading.5"] = {  },
    -- markdown,html,javascript
    ["@markup.heading.6"] = {  },
    -- markdown_inline,html,javascript
    ["@markup.italic"] = {  },
    -- markdown_inline,vimdoc
    ["@markup.link"] = {  },
    -- markdown_inline,markdown,html,javascript
    ["@markup.link.label"] = {  },
    -- markdown_inline,markdown
    ["@markup.link.url"] = {  },
    -- markdown
    ["@markup.list"] = {  },
    -- markdown
    ["@markup.list.checked"] = {  },
    -- markdown
    ["@markup.list.unchecked"] = {  },
    -- markdown
    ["@markup.quote"] = {  },
    -- markdown_inline,html,vimdoc,xml,javascript
    ["@markup.raw"] = {  },
    -- markdown,vimdoc
    ["@markup.raw.block"] = {  },
    -- markdown_inline,html,javascript
    ["@markup.strikethrough"] = {  },
    -- markdown_inline,html,javascript
    ["@markup.strong"] = {  },
    -- html,javascript
    ["@markup.underline"] = {  },
    -- python,vim,xml,javascript,cpp,cmake,css,luadoc
    ["@module"] = {  },
    -- python,lua,javascript
    ["@module.builtin"] = {  },
    -- bash,html,python,xml,javascript,cmake
    ["@none"] = {  },
    -- markdown_inline,bash,html,query,python,cmake,luadoc
    ["@nospell"] = {  },
    -- json5,yaml,json,bash,query,python,lua,vim,xml,javascript,toml,c,cpp,dtd,css,luadoc
    ["@number"] = {  },
    -- python,vim,toml,css
    ["@number.float"] = {  },
    -- ini,bash,html,query,python,lua,vim,xml,javascript,make,toml,c,cpp,dtd,css,luadoc,luap
    ["@operator"] = {  },
    -- ini,yaml,json,query,lua,vim,toml,c,cpp,css
    ["@property"] = {  },
    -- ini,yaml,json,bash,query,python,lua,vim,xml,javascript,toml,c,cpp,cmake,dtd,css,luadoc,luap
    ["@punctuation.bracket"] = {  },
    -- yaml,json,markdown,bash,query,python,lua,vim,xml,javascript,toml,c,cpp,dtd,css,luadoc,luap
    ["@punctuation.delimiter"] = {  },
    -- yaml,markdown,bash,query,python,vim,javascript,make,c,cpp,cmake,luadoc
    ["@punctuation.special"] = {  },
    -- json5,ini,yaml,json,markdown,bash,html,query,python,lua,vim,xml,javascript,make,toml,c,cpp,cmake,dtd,css,luadoc
    ["@spell"] = {  },
    -- json5,ini,yaml,json,bash,html,query,python,lua,vim,xml,javascript,make,toml,c,cpp,cmake,dtd,css,luadoc
    ["@string"] = {  },
    -- python
    ["@string.documentation"] = {  },
    -- yaml,markdown_inline,json,markdown,query,python,lua,javascript,toml,c,cpp,cmake,luap
    ["@string.escape"] = {  },
    -- bash,query,python,lua,vim,javascript,luap
    ["@string.regexp"] = {  },
    -- bash,vimdoc,vim,xml,toml,dtd
    ["@string.special"] = {  },
    -- bash,vim,make,luadoc
    ["@string.special.path"] = {  },
    -- make
    ["@string.special.symbol"] = {  },
    -- html,vimdoc,xml,javascript,dtd
    ["@string.special.url"] = {  },
    -- html,xml,javascript,dtd,css
    ["@tag"] = {  },
    -- html,xml,javascript,dtd,css
    ["@tag.attribute"] = {  },
    -- javascript
    ["@tag.builtin"] = {  },
    -- html,xml,javascript,dtd
    ["@tag.delimiter"] = {  },
    -- yaml,query,python,vim,javascript,c,cpp,cmake,css,luadoc
    ["@type"] = {  },
    -- python,xml,javascript,c,cpp,dtd,luadoc
    ["@type.builtin"] = {  },
    -- python,xml,c,cpp
    ["@type.definition"] = {  },
    -- bash,query,python,lua,vim,javascript,c,cpp,cmake,css,luadoc
    ["@variable"] = {  },
    -- bash,python,lua,vim,javascript,make,c,cpp,luadoc,luap
    ["@variable.builtin"] = {  },
    -- query,python,lua,javascript,cpp,luadoc
    ["@variable.member"] = {  },
    -- bash,vimdoc,python,lua,vim,javascript,c,cpp,cmake,luadoc,luap
    ["@variable.parameter"] = {  },
    -- lua
    ["@variable.parameter.builtin"] = {  },
}

M.setup = function()
    return M.groups
end

return M