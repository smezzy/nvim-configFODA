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
end)



lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

vim.diagnostic.config({
    underline = false,
    virtual_text = false,
})

-- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').lua_ls.setup {
    filetypes = { "lua", "yue" },
    single_file_support = false
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if vim.bo[bufnr].filetype == "yue" then
            client.server_capabilities.semanticTokensProvider = nil
        end
        -- if client.server_capabilities.completionProvider then
        --     vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        -- end
        -- if client.server_capabilities.definitionProvider then
        --     vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        -- end
    end
})

require 'lspconfig'.gdscript.setup {
    capabilities = require('cmp_nvim_lsp')
        .default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

lsp.setup()

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

vim.cmd [[hi link LspSignatureActiveParameter @operator]]
