local M = {}

M.colors = {
    Normal = { fg = "#1f1c1b" },
    Keyword = { fg = "#1f1c1b", bold = true },
    Function = { fg = "#644a9b" },
    Variable = { fg = "#0057ae" },
    ControlFlow = { fg = "#1f1c1b", bold = true },
    Operator = { fg = "#ca60ca" },
    BuiltIn = { fg = "#644a9b", bold = true },
    Extension = { fg = "#0095ff", bold = true },
    Preprocessor = { fg = "#006e28" },
    Attribute = { fg = "#0057ae" },
    Char = { fg = "#924c9d" },
    SpecialChar = { fg = "#3daee9" },
    String = { fg = "#bf0303" },
    VerbatimString = { fg = "#e31616" },
    SpecialString = { fg = "#ff5500" },
    Import = { fg = "#ff5500" },
    DataType = { fg = "#0057ae" },
    Number = { fg = "#b08000" },
    Float = { fg = "#b08000" },
    Constant = { fg = "#aa5500" },
    Comment = { fg = "#898887" },
    Documentation = { fg = "#607880" },
    Annotation = { fg = "#ca60ca" },
    CommentVar = { fg = "#0095ff" },
    RegionMarker = { fg = "#0057ae", bg = "#e0e9f8" },
    Information = { fg = "#b08000" },
    Warning = { fg = "#bf0303" },
    Alert = { fg = "#bf0303", bg = "#f7e6e6", bold = true },
    Error = { fg = "#bf0303", underline = true, sp = "#bf0303" },
    Others = { fg = "#006e28" },
    -- added groups
    MarkHead = { fg ="#614e8e" },
    MarkLink = { fg = "#898887", underline = true, sp = "#898887" },
    MarkLinkInline = { fg = "#898887" },
    MarkLinkLabel = { fg = "#326b3b", underline = true, sp = "#326b3b" },
    MarkQuote = { fg = "#2f579e" },
    MarkCode = { fg = "#a78248" },
    TagAttribute = { fg = "#326b3b" },
    TagDelimiter = { fg = "#2f579e" },
    Regex = { fg = "#a78248" },
    Enum = { fg = "#b57747" },
    Boolean = {fg = "#2f579e"},
}

M.setup = function()
    return M.colors
end

return M
