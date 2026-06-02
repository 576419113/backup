local M = {}

M.colors = {
    Normal = { fg = "#cfcfc2" },
    Keyword = { fg = "#cfcfc2", bold = true },
    Function = { fg = "#8e44ad" },
    Variable = { fg = "#27aeae" },
    ControlFlow = { fg = "#fdbc4b", bold = true },
    Operator = { fg = "#3f8058" },
    BuiltIn = { fg = "#609ca0" },
    Extension = { fg = "#0099ff", bold = true },
    Preprocessor = { fg = "#27ae60" },
    Attribute = { fg = "#2980b9" },
    Char = { fg = "#3daee9" },
    SpecialChar = { fg = "#3daee9" },
    String = { fg = "#f44f4f" },
    VerbatimString = { fg = "#da4453" },
    SpecialString = { fg = "#da4453" },
    Import = { fg = "#27ae60" },
    DataType = { fg = "#2980b9" },
    Number = { fg = "#f67400" },
    Float = { fg = "#f67400" },
    Constant = { fg = "#27aeae" },
    Comment = { fg = "#7a7c7d" },
    Documentation = { fg = "#a43340" },
    Annotation = { fg = "#3f8058" },
    CommentVar = { fg = "#7f8c8d" },
    RegionMarker = { fg = "#2980b9", bg = "#153042" },
    Information = { fg = "#c45b00" },
    Warning = { fg = "#da4453" },
    Alert = { fg = "#95da4c", bg = "#4d1f24", bold = true },
    Error = { fg = "#da4453", underline = true, sp = "#da4453" },
    Others = { fg = "#27ae60" },
    -- added groups
    MarkHead = { fg ="#714287" },
    MarkLink = { fg = "#7a7c7d", underline = true, sp = "#7a7c7d" },
    MarkLinkInline = { fg = "#7a7c7d" },
    MarkLinkLabel = { fg = "#56a971", underline = true, sp = "#56a971" },
    MarkQuote = { fg = "#487eac" },
    MarkCode = { fg = "#b56340" },
    TagAttribute = { fg = "#56a971" },
    TagDelimiter = { fg = "#487eac" },
    Regex = { fg = "#e37e50" },
    Enum = { fg = "#935673" },
    Boolean = {fg = "#58aaaa"},
}

M.setup = function()
    return M.colors
end

return M
