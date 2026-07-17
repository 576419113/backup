local M = {}

M.groups = {
    -- qmljs,cpp,xml,lua,python,c,dtd,css,javascript
    ["@attribute"] = { fg = "#2980b9" },
    -- python,zsh
    ["@attribute.builtin"] = { link = "@attribute" },
    -- json5,toml,yaml,qmljs,json,cpp,cmake,xml,lua,python,zsh,c,vim,javascript
    ["@boolean"] = { link = "Boolean" },
    -- cpp,xml,c,dtd
    ["@character"] = { link = "Character" },
    -- qmljs,xml,python,vim,bash,query,make,dtd,markdown_inline,html,css,javascript
    ["@character.special"] = { link = "Character" },
    -- ini,json5,toml,yaml,qmljs,json,cpp,cmake,xml,lua,python,zsh,c,vim,bash,qmldir,query,make,dtd,luadoc,html,css,javascript
    ["@comment"] = { link = "Comment" },
    -- qmljs,cpp,lua,c,javascript
    ["@comment.documentation"] = { link = "Comment" },
    -- vimdoc
    ["@comment.error"] = {  },
    -- vimdoc
    ["@comment.note"] = {  },
    -- vimdoc
    ["@comment.warning"] = {  },
    -- json,markdown_inline
    ["@conceal"] = {  },
    -- json5,qmljs,cpp,cmake,xml,lua,python,zsh,c,vim,bash,dtd,luap,html,css,javascript
    ["@constant"] = { link = "Constant" },
    -- yaml,qmljs,json,cpp,xml,lua,python,zsh,c,vim,dtd,luadoc,javascript
    ["@constant.builtin"] = { fg = "#ed7888" },
    -- cpp,c
    ["@constant.macro"] = { link = "PreProc" },
    -- qmljs,cpp,lua,python,javascript
    ["@constructor"] = { link = "Function" },
    ["@constructor.lua"] = { link = "Operator" },
    -- qmljs,cpp,cmake,lua,python,zsh,c,vim,bash,make,css,javascript
    ["@function"] = { link = "Function" },
    -- qmljs,cpp,cmake,lua,python,zsh,c,bash,make,javascript
    ["@function.builtin"] = { link = "Function" },
    -- qmljs,cpp,lua,python,zsh,c,vim,bash,query,javascript
    ["@function.call"] = { link = "Function" },
    -- cpp,cmake,xml,python,c,vim,dtd,luadoc
    ["@function.macro"] = { fg = "#ed7888" },
    -- qmljs,cpp,lua,python,javascript
    ["@function.method"] = { link = "Function" },
    -- qmljs,cpp,lua,python,javascript
    ["@function.method.call"] = { link = "Function" },
    -- json5,qmljs,cpp,xml,lua,python,zsh,c,vim,bash,qmldir,query,make,dtd,luadoc,css,javascript
    ["@keyword"] = { link = "Keyword" },
    -- qmljs,cpp,cmake,lua,python,zsh,c,vim,bash,make,javascript
    ["@keyword.conditional"] = { link = "Statement" },
    -- qmljs,cpp,zsh,c,vim,bash,javascript
    ["@keyword.conditional.ternary"] = { link = "Operator" },
    -- qmljs,cpp,lua,python,luadoc,javascript
    ["@keyword.coroutine"] = { link = "Statement" },
    -- vimdoc,yaml,qmljs,cpp,cmake,xml,lua,python,zsh,c,bash,qmldir,query,markdown,dtd,css,javascript
    ["@keyword.directive"] = { link = "PreProc" },
    -- cpp,xml,c,dtd
    ["@keyword.directive.define"] = { link = "PreProc" },
    -- qmljs,cpp,python,vim,javascript
    ["@keyword.exception"] = { link = "Statement" },
    -- qmljs,cmake,lua,python,zsh,vim,bash,luadoc,javascript
    ["@keyword.function"] = { link = "Keyword" },
    -- qmljs,cpp,python,zsh,c,bash,query,make,dtd,luadoc,css,javascript
    ["@keyword.import"] = { fg = "#27ae60" },
    -- qmljs,cpp,cmake,xml,c,dtd,luadoc,css
    ["@keyword.modifier"] = { link = "Keyword" },
    -- qmljs,cpp,cmake,lua,python,c,vim,css,javascript
    ["@keyword.operator"] = { link = "Keyword" },
    -- qmljs,cpp,cmake,lua,python,zsh,c,vim,bash,javascript
    ["@keyword.repeat"] = { link = "Statement" },
    -- qmljs,cpp,cmake,lua,python,c,luadoc,javascript
    ["@keyword.return"] = { link = "Statement" },
    -- qmljs,cpp,python,c,javascript
    ["@keyword.type"] = { link = "Keyword" },
    -- vimdoc,yaml,qmljs,cpp,xml,lua,zsh,c,vim,bash,markdown,dtd,javascript
    ["@label"] = { link = "Label" },
    -- ini,markdown,html,javascript
    ["@markup.heading"] = { bold = true, fg = "#8e44ad" },
    -- vimdoc,markdown,html,javascript
    ["@markup.heading.1"] = {  },
    -- vimdoc
    ["@markup.heading.1.delimiter"] = {  },
    -- vimdoc,markdown,html,javascript
    ["@markup.heading.2"] = {  },
    -- vimdoc
    ["@markup.heading.2.delimiter"] = {  },
    -- vimdoc,markdown,html,javascript
    ["@markup.heading.3"] = {  },
    -- vimdoc,markdown,html,javascript
    ["@markup.heading.4"] = {  },
    -- markdown,html,javascript
    ["@markup.heading.5"] = {  },
    -- markdown,html,javascript
    ["@markup.heading.6"] = {  },
    -- markdown_inline,html,javascript
    ["@markup.italic"] = { italic = true },
    -- vimdoc,markdown_inline
    ["@markup.link"] = { fg = "#7a7c7d" },
    -- markdown,markdown_inline,html,javascript
    ["@markup.link.label"] = { underline = true, sp = "#27ae60", fg = "#27ae60" },
    -- markdown,markdown_inline
    ["@markup.link.url"] = { underline = true, sp = "#7a7c7d", fg = "#7a7c7d" },
    -- markdown
    ["@markup.list"] = { fg = "#da4453" },
    -- markdown
    ["@markup.list.checked"] = { fg = "#27aeae" },
    -- markdown
    ["@markup.list.unchecked"] = { fg = "#27aeae" },
    -- markdown
    ["@markup.quote"] = { fg = "#2980b9" },
    -- vimdoc,xml,markdown_inline,html,javascript
    ["@markup.raw"] = { fg = "#c45b00" },
    -- vimdoc,markdown
    ["@markup.raw.block"] = { link = "@markup.raw" },
    -- markdown_inline,html,javascript
    ["@markup.strikethrough"] = { strikethrough = true },
    -- markdown_inline,html,javascript
    ["@markup.strong"] = { bold = true },
    -- html,javascript
    ["@markup.underline"] = { underline = true },
    -- qmljs,cpp,cmake,xml,python,vim,luadoc,css,javascript
    ["@module"] = {  },
    -- qmljs,lua,python,javascript
    ["@module.builtin"] = {  },
    -- qmljs,cmake,xml,python,bash,html,javascript
    ["@none"] = {  },
    -- cmake,python,zsh,bash,query,luadoc,markdown_inline,html
    ["@nospell"] = {  },
    -- json5,toml,yaml,qmljs,json,cpp,xml,lua,python,zsh,c,vim,bash,qmldir,query,dtd,luadoc,css,javascript
    ["@number"] = { link = "Number" },
    -- toml,python,vim,qmldir,css
    ["@number.float"] = { link = "Number" },
    -- ini,toml,qmljs,cpp,xml,lua,python,zsh,c,vim,bash,query,make,dtd,luadoc,luap,html,css,javascript
    ["@operator"] = { link = "Operator" },
    -- ini,toml,yaml,qmljs,json,cpp,lua,c,vim,query,css
    ["@property"] = { fg = "#2980b9" },
    -- ini,toml,yaml,qmljs,json,cpp,cmake,xml,lua,python,zsh,c,vim,bash,query,dtd,luadoc,luap,css,javascript
    ["@punctuation.bracket"] = { link = "Operator" },
    -- toml,yaml,qmljs,json,cpp,xml,lua,python,zsh,c,vim,bash,query,markdown,dtd,luadoc,luap,css,javascript
    ["@punctuation.delimiter"] = { link = "Operator" },
    -- yaml,qmljs,cpp,cmake,python,zsh,c,vim,bash,query,markdown,make,luadoc,javascript
    ["@punctuation.special"] = { link = "Operator" },
    -- ini,json5,toml,yaml,qmljs,json,cpp,cmake,xml,lua,python,zsh,c,vim,bash,qmldir,query,markdown,make,dtd,luadoc,html,css,javascript
    ["@spell"] = {  },
    -- ini,json5,toml,yaml,qmljs,json,cpp,cmake,xml,lua,python,zsh,c,vim,bash,query,make,dtd,luadoc,html,css,javascript
    ["@string"] = { link = "String" },
    -- python
    ["@string.documentation"] = { link = "Documentation" },
    -- toml,yaml,qmljs,json,cpp,cmake,lua,python,c,query,markdown,luap,markdown_inline,javascript
    ["@string.escape"] = { link = "Special" },
    -- qmljs,lua,python,zsh,vim,bash,query,luap,javascript
    ["@string.regexp"] = { fg = "#f67400" },
    -- toml,vimdoc,xml,vim,bash,dtd
    ["@string.special"] = {  },
    -- zsh,vim,bash,make,luadoc
    ["@string.special.path"] = {  },
    -- make
    ["@string.special.symbol"] = {  },
    -- vimdoc,xml,dtd,html,javascript
    ["@string.special.url"] = {  },
    -- xml,dtd,html,css,javascript
    ["@tag"] = { link = "Tag" },
    -- xml,dtd,html,css,javascript
    ["@tag.attribute"] = { fg = "#27ae60" },
    -- javascript
    ["@tag.builtin"] = {  },
    -- xml,dtd,html,javascript
    ["@tag.delimiter"] = { fg = "#2980b9" },
    -- yaml,qmljs,cpp,cmake,python,c,vim,query,luadoc,css,javascript
    ["@type"] = { link = "Type" },
    -- qmljs,cpp,xml,python,c,dtd,luadoc,javascript
    ["@type.builtin"] = { link = "Type" },
    -- cpp,xml,python,c
    ["@type.definition"] = {  },
    -- qmljs,cpp,cmake,lua,python,zsh,c,vim,bash,qmldir,query,luadoc,css,javascript
    ["@variable"] = { fg = "#27aeae" },
    -- qmljs,cpp,lua,python,zsh,c,vim,bash,make,luadoc,luap,javascript
    ["@variable.builtin"] = { fg = "#609ca0" },
    -- qmljs,cpp,lua,python,query,luadoc,javascript
    ["@variable.member"] = { fg = "#d8a624" },
    -- vimdoc,cpp,cmake,lua,python,zsh,c,vim,bash,luadoc,luap,javascript
    ["@variable.parameter"] = { link = "@variable" },
    -- lua
    ["@variable.parameter.builtin"] = { fg = "#bcda90" },
}

M.setup = function()
    return M.groups
end

return M

-- bash: @character.special, @comment, @constant, @function, @function.builtin, @function.call, @keyword, @keyword.conditional, @keyword.conditional.ternary, @keyword.directive, @keyword.function, @keyword.import, @keyword.repeat, @label, @none, @nospell, @number, @operator, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.regexp, @string.special, @string.special.path, @variable, @variable.builtin, @variable.parameter

-- c: @attribute, @boolean, @character, @comment, @comment.documentation, @constant, @constant.builtin, @constant.macro, @function, @function.builtin, @function.call, @function.macro, @keyword, @keyword.conditional, @keyword.conditional.ternary, @keyword.directive, @keyword.directive.define, @keyword.import, @keyword.modifier, @keyword.operator, @keyword.repeat, @keyword.return, @keyword.type, @label, @number, @operator, @property, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.escape, @type, @type.builtin, @type.definition, @variable, @variable.builtin, @variable.parameter

-- cmake: @boolean, @comment, @constant, @function, @function.builtin, @function.macro, @keyword.conditional, @keyword.directive, @keyword.function, @keyword.modifier, @keyword.operator, @keyword.repeat, @keyword.return, @module, @none, @nospell, @punctuation.bracket, @punctuation.special, @spell, @string, @string.escape, @type, @variable, @variable.parameter

-- cpp: @attribute, @boolean, @character, @comment, @comment.documentation, @constant, @constant.builtin, @constant.macro, @constructor, @function, @function.builtin, @function.call, @function.macro, @function.method, @function.method.call, @keyword, @keyword.conditional, @keyword.conditional.ternary, @keyword.coroutine, @keyword.directive, @keyword.directive.define, @keyword.exception, @keyword.import, @keyword.modifier, @keyword.operator, @keyword.repeat, @keyword.return, @keyword.type, @label, @module, @number, @operator, @property, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.escape, @type, @type.builtin, @type.definition, @variable, @variable.builtin, @variable.member, @variable.parameter

-- css: @attribute, @character.special, @comment, @constant, @function, @keyword, @keyword.directive, @keyword.import, @keyword.modifier, @keyword.operator, @module, @number, @number.float, @operator, @property, @punctuation.bracket, @punctuation.delimiter, @spell, @string, @tag, @tag.attribute, @type, @variable

-- dtd: @attribute, @character, @character.special, @comment, @constant, @constant.builtin, @function.macro, @keyword, @keyword.directive, @keyword.directive.define, @keyword.import, @keyword.modifier, @label, @number, @operator, @punctuation.bracket, @punctuation.delimiter, @spell, @string, @string.special, @string.special.url, @tag, @tag.attribute, @tag.delimiter, @type.builtin

-- ecma: 

-- html: @character.special, @comment, @constant, @markup.heading, @markup.heading.1, @markup.heading.2, @markup.heading.3, @markup.heading.4, @markup.heading.5, @markup.heading.6, @markup.italic, @markup.link.label, @markup.raw, @markup.strikethrough, @markup.strong, @markup.underline, @none, @nospell, @operator, @spell, @string, @string.special.url, @tag, @tag.attribute, @tag.delimiter

-- html_tags: 

-- ini: @comment, @markup.heading, @operator, @property, @punctuation.bracket, @spell, @string

-- javascript: @attribute, @boolean, @character.special, @comment, @comment.documentation, @constant, @constant.builtin, @constructor, @function, @function.builtin, @function.call, @function.method, @function.method.call, @keyword, @keyword.conditional, @keyword.conditional.ternary, @keyword.coroutine, @keyword.directive, @keyword.exception, @keyword.function, @keyword.import, @keyword.operator, @keyword.repeat, @keyword.return, @keyword.type, @label, @markup.heading, @markup.heading.1, @markup.heading.2, @markup.heading.3, @markup.heading.4, @markup.heading.5, @markup.heading.6, @markup.italic, @markup.link.label, @markup.raw, @markup.strikethrough, @markup.strong, @markup.underline, @module, @module.builtin, @none, @number, @operator, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.escape, @string.regexp, @string.special.url, @tag, @tag.attribute, @tag.builtin, @tag.delimiter, @type, @type.builtin, @variable, @variable.builtin, @variable.member, @variable.parameter

-- json: @boolean, @comment, @conceal, @constant.builtin, @number, @property, @punctuation.bracket, @punctuation.delimiter, @spell, @string, @string.escape

-- json5: @boolean, @comment, @constant, @keyword, @number, @spell, @string

-- jsx: 

-- lua: @attribute, @boolean, @comment, @comment.documentation, @constant, @constant.builtin, @constructor, @function, @function.builtin, @function.call, @function.method, @function.method.call, @keyword, @keyword.conditional, @keyword.coroutine, @keyword.directive, @keyword.function, @keyword.operator, @keyword.repeat, @keyword.return, @label, @module.builtin, @number, @operator, @property, @punctuation.bracket, @punctuation.delimiter, @spell, @string, @string.escape, @string.regexp, @variable, @variable.builtin, @variable.member, @variable.parameter, @variable.parameter.builtin

-- luadoc: @comment, @constant.builtin, @function.macro, @keyword, @keyword.coroutine, @keyword.function, @keyword.import, @keyword.modifier, @keyword.return, @module, @nospell, @number, @operator, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.special.path, @type, @type.builtin, @variable, @variable.builtin, @variable.member, @variable.parameter

-- luap: @constant, @operator, @punctuation.bracket, @punctuation.delimiter, @string.escape, @string.regexp, @variable.builtin, @variable.parameter

-- make: @character.special, @comment, @function, @function.builtin, @keyword, @keyword.conditional, @keyword.import, @operator, @punctuation.special, @spell, @string, @string.special.path, @string.special.symbol, @variable.builtin

-- markdown: @keyword.directive, @label, @markup.heading, @markup.heading.1, @markup.heading.2, @markup.heading.3, @markup.heading.4, @markup.heading.5, @markup.heading.6, @markup.link.label, @markup.link.url, @markup.list, @markup.list.checked, @markup.list.unchecked, @markup.quote, @markup.raw.block, @punctuation.delimiter, @punctuation.special, @spell, @string.escape

-- markdown_inline: @character.special, @conceal, @markup.italic, @markup.link, @markup.link.label, @markup.link.url, @markup.raw, @markup.strikethrough, @markup.strong, @nospell, @string.escape

-- python: @attribute, @attribute.builtin, @boolean, @character.special, @comment, @constant, @constant.builtin, @constructor, @function, @function.builtin, @function.call, @function.macro, @function.method, @function.method.call, @keyword, @keyword.conditional, @keyword.coroutine, @keyword.directive, @keyword.exception, @keyword.function, @keyword.import, @keyword.operator, @keyword.repeat, @keyword.return, @keyword.type, @module, @module.builtin, @none, @nospell, @number, @number.float, @operator, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.documentation, @string.escape, @string.regexp, @type, @type.builtin, @type.definition, @variable, @variable.builtin, @variable.member, @variable.parameter

-- qmldir: @comment, @keyword, @keyword.directive, @number, @number.float, @spell, @variable

-- qmljs: @attribute, @boolean, @character.special, @comment, @comment.documentation, @constant, @constant.builtin, @constructor, @function, @function.builtin, @function.call, @function.method, @function.method.call, @keyword, @keyword.conditional, @keyword.conditional.ternary, @keyword.coroutine, @keyword.directive, @keyword.exception, @keyword.function, @keyword.import, @keyword.modifier, @keyword.operator, @keyword.repeat, @keyword.return, @keyword.type, @label, @module, @module.builtin, @none, @number, @operator, @property, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.escape, @string.regexp, @type, @type.builtin, @variable, @variable.builtin, @variable.member

-- query: @character.special, @comment, @function.call, @keyword, @keyword.directive, @keyword.import, @nospell, @number, @operator, @property, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.escape, @string.regexp, @type, @variable, @variable.member

-- toml: @boolean, @comment, @number, @number.float, @operator, @property, @punctuation.bracket, @punctuation.delimiter, @spell, @string, @string.escape, @string.special

-- vim: @boolean, @character.special, @comment, @constant, @constant.builtin, @function, @function.call, @function.macro, @keyword, @keyword.conditional, @keyword.conditional.ternary, @keyword.exception, @keyword.function, @keyword.operator, @keyword.repeat, @label, @module, @number, @number.float, @operator, @property, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.regexp, @string.special, @string.special.path, @type, @variable, @variable.builtin, @variable.parameter

-- vimdoc: @comment.error, @comment.note, @comment.warning, @keyword.directive, @label, @markup.heading.1, @markup.heading.1.delimiter, @markup.heading.2, @markup.heading.2.delimiter, @markup.heading.3, @markup.heading.4, @markup.link, @markup.raw, @markup.raw.block, @string.special, @string.special.url, @variable.parameter

-- xml: @attribute, @boolean, @character, @character.special, @comment, @constant, @constant.builtin, @function.macro, @keyword, @keyword.directive, @keyword.directive.define, @keyword.modifier, @label, @markup.raw, @module, @none, @number, @operator, @punctuation.bracket, @punctuation.delimiter, @spell, @string, @string.special, @string.special.url, @tag, @tag.attribute, @tag.delimiter, @type.builtin, @type.definition

-- yaml: @boolean, @comment, @constant.builtin, @keyword.directive, @label, @number, @property, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.escape, @type

-- zsh: @attribute.builtin, @boolean, @comment, @constant, @constant.builtin, @function, @function.builtin, @function.call, @keyword, @keyword.conditional, @keyword.conditional.ternary, @keyword.directive, @keyword.function, @keyword.import, @keyword.repeat, @label, @nospell, @number, @operator, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string, @string.regexp, @string.special.path, @variable, @variable.builtin, @variable.parameter

