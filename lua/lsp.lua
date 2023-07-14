require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    require "lsp_signature".on_attach({
        bind = true,
        handler_opts = {
            border = "single"
        }
    }, bufnr);
end)


lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

vim.diagnostic.config({
    underline = false,
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

vim.cmd [[hi link LspSignatureActiveParameter @operator]]
