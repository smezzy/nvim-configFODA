local actions = require("telescope.actions")
local telescope = require "telescope"

telescope.setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,

        color_devicons = false,
        file_ignore_patterns = {
            'node_modules',
            "%.png", "%.jpg", "%.jpeg", "%.gif", "%.bmp",
            "%.fnt", "%.ttf", "%.woff2",
            'build', 'builds', 'assets'
        },

        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key",
                ["<esc>"] = actions.close,
            }
        },
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        find_files = {
            theme = 'ivy'
        },
        buffers = {
            theme = 'dropdown'
        }
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        file_browser = {
            theme = "ivy"
        }
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    },
    layout_config = {
        vertical = { height = 32 }
    }
}
telescope.load_extension "file_browser"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>fo', builtin.git_files, {})
vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>fl', builtin.oldfiles, {})
vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})
-- vim.keymap.set("n", "<Leader>fD", , {})
-- vim.keymap.set("n", "<Leader>fd", function() cd() end, {})
