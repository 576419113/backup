local M = {}

M.groups = {
    ["Added"] = { fg = "#1c8042" },
    ["Boolean"] = { fg = "#58aaaa" },
    ["Changed"] = { fg = "#c04900" },
    ["Character"] = { fg = "#3daee9" },
    ["Comment"] = { fg = "#7a7c7d" },
    ["Conditional"] = { link = "Statement" },
    ["Constant"] = { fg = "#27aeae" },
    ["Debug"] = {  },
    ["Define"] = { link = "PreProc" },
    ["Delimiter"] = { link = "Operator" },
    ["Error"] = {  fg = "#da4453", underline = true, sp = "#da4453" },
    ["Exception"] = { link = "Statement" },
    ["Float"] = { link = "Number" },
    ["Function"] = { fg = "#8e44ad" },
    ["Identifier"] = {  },
    ["Ignore"] = {  },
    ["Include"] = { link = "PreProc" },
    ["Keyword"] = { fg = "#cfcfc2", bold = true },
    ["Label"] = { fg = "#27aeae" },
    ["Macro"] = { link = "PreProc" },
    ["Number"] = { fg = "#f67400" },
    ["Operator"] = { fg = "#3f8058" },
    ["PreCondit"] = { link = "PreProc" },
    ["PreProc"] = { fg = "#27ae60"  },
    ["Removed"] = { fg = "#da4453" },
    ["Repeat"] = { link = "Statement" },
    ["Special"] = { fg = "#3daee9" },
    ["SpecialChar"] = { link = "Special" },
    ["SpecialComment"] = { link = "Special" },
    ["Statement"] = { fg = "#fdbc4b", bold = true },
    ["StorageClass"] = { link = "Class" },
    ["String"] = { fg = "#f44f4f" },
    ["Structure"] = { link = "Keyword" },
    ["Tag"] = { link = "Keyword" },
    ["Todo"] = { fg = "#ca9219", bg = "#451e1a", bold = true },
    ["Type"] = { fg = "#2980b9" },
    ["Typedef"] = { link = "Keyword" },
    ["Underlined"] = { underline = true },
}

M.setup = function()
    return M.groups
end

return M
