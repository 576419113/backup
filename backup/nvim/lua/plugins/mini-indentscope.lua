require('mini.indentscope').setup({
    draw = {
        delay = 100,
        animation = require('mini.indentscope').gen_animation.quadratic({
            duration = 20
        })
    },
})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
