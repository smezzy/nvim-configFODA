require("ibl").setup {
    exclude = { filetypes = { 'lua' } },
    scope = {
        show_start = false,
        show_end = false,
    }
}

local hooks = require "ibl.hooks"
hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
)
