require("gruvbox").setup({
    transparent_mode = not vim.g.neovide,
    underline = false,
    bold = false,
    undercurl = false,
    italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
    },
})


vim.cmd [[
    highlight! NormalFloat guibg=#3c3836
]]
