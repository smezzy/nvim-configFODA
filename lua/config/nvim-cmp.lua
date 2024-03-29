local cmp = require("cmp")

local luasnip = require("luasnip")

-- local has_words_before = function()
--     unpack = unpack or table.unpack
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

cmp.setup {
    completion = {
        completeopt = 'menu,menuone,noinsert',
        autocomplete = false,
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),


        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "lsp_signature" },
        { name = "codeium" },
    }, {
        { name = 'buffer' }
    })
}
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local auto_complete = false
local function toggle_auto_complete()
    auto_complete = not auto_complete
    if auto_complete then
        cmp.setup({
            completion = {
                autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged }
            }
        })
    else
        cmp.setup({
            completion = {
                autocomplete = false
            }
        })
    end
end

vim.api.nvim_create_user_command("ToggleAutoCmp", toggle_auto_complete, {})
