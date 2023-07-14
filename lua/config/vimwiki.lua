vim.cmd([[
    augroup VimwikiTabwidth
        autocmd!
        autocmd FileType vimwiki setlocal tabstop=2 shiftwidth=2
    augroup END
]])

-- cool prefixes

-- local prefix = "@done"
-- local prefix = "cu"
-- local prefix = "@at"
local prefix = ""

local function toggleVimwikiListItem()
    vim.cmd('VimwikiToggleListItem')

    local line = vim.fn.getline('.')
    if line:match('.*`'..prefix..' [^`]*') then
        line = line:gsub(' `'..prefix..'[^`]*`', ''):gsub('`%([^)]*%)`', ''):gsub('%s*$', ''):gsub('`$', '')
    else
        line = line:gsub('%s*$', '') .. ' `'..prefix..' (' .. os.date('%d-%m-%Y %H:%M') .. ')`'
    end
    vim.fn.setline('.', line)
end

vim.keymap.set('n', '<Leader><space>', toggleVimwikiListItem, {silent = true, noremap = true})


-- Highlight completed todo items
-- vim.api.nvim_command("highlight link VimwikiCheckBoxDone Todo")
vim.g.vimwiki_hl_cb_checked = 1
vim.g.vimwiki_conceal_pre = 1
vim.g.automatic_nested_syntaxes = 1
