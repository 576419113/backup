require('mini.diff').setup({
    view = {
        style = "sign",
        signs = { add = "▉", change = "▉", delete = "▉" }
    },
    source = require("mini.diff").gen_source.save(),
})
