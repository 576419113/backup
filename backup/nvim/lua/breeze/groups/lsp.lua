local M = {}

M.groups = {
    ["@lsp.mod.abstract"] = {  },
    ["@lsp.mod.async"] = {  },
    ["@lsp.mod.declaration"] = { bold = true },
    ["@lsp.mod.defaultLibrary"] = {  },
    ["@lsp.mod.definition"] = { bold = true },
    ["@lsp.mod.deprecated"] = {  },
    ["@lsp.mod.documentation"] = {  },
    ["@lsp.mod.modification"] = {  },
    ["@lsp.mod.readonly"] = { link = "Constant" },
    ["@lsp.mod.static"] = {  },
    ["@lsp.type.class"] = { fg = "#32ae48" },
    ["@lsp.type.comment"] = { link = "Comment" },
    ["@lsp.type.decorator"] = { fg = "#2980b9" },
    ["@lsp.type.enum"] = { fg = "#e26572" },
    ["@lsp.type.enumMember"] = { fg = "#d38089" },
    ["@lsp.type.event"] = {  },
    ["@lsp.type.function"] = { link = "Function" },
    ["@lsp.type.interface"] = { link = "Function" },
    ["@lsp.type.keyword"] = { link = "Keyword" },
    ["@lsp.type.macro"] = { link = "PreProc" },
    ["@lsp.type.method"] = { link = "Function" },
    ["@lsp.type.modifier"] = { link = "Keyword" },
    ["@lsp.type.namespace"] = { fg = "#c97a92" },
    ["@lsp.type.number"] = { link = "Number" },
    ["@lsp.type.operator"] = { link = "Operator" },
    ["@lsp.type.parameter"] = { link = "Variable" },
    ["@lsp.type.property"] = { fg = "#2980b9" },
    ["@lsp.type.regexp"] = { fg = "#f67400" },
    ["@lsp.type.string"] = { link = "String" },
    ["@lsp.type.struct"] = { fg = "#32ae48" },
    ["@lsp.type.type"] = { link = "Type" },
    ["@lsp.type.typeParameter"] = {  },
    ["@lsp.type.variable"] = { link = "Variable" },
}

M.setup = function()
    return M.groups
end

return M
