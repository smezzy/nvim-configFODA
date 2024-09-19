local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

-- local has_words_before = function()
--     unpack = unpack or table.unpack
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

vim.cmd [[
  highlight! CmpItemKindFunction guifg=#56B6C2
  highlight! CmpItemKindMethod guifg=#56B6C2
  highlight! CmpItemKindClass guifg=#E5C07B
  highlight! CmpItemKindVariable guifg=#C678DD
  highlight! CmpItemKindKeyword guifg=#D4D4D4
  highlight! CmpItemKindText guifg=#98C379
  highlight! CmpItemKindDefault guifg=#ABB2BF
]]

cmp.setup {
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...',     -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labeldetails = false, -- show labeldetails in menu. disabled by default

            -- the function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (see [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                local kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
                vim_item.abbr = string.format("%s %s", kind, vim_item.abbr)
                vim_item.kind = ""

                return vim_item
            end
        })
    },

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
toggle_auto_complete()

vim.api.nvim_create_user_command("ToggleAutoCmp", toggle_auto_complete, {})
