
vim.cmd([[
  augroup VimwikiTabwidth
    autocmd!
    autocmd FileType vimwiki setlocal tabstop=2 shiftwidth=2
  augroup END
]])

local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<Leader><space>', [[:VimwikiToggleListItem<CR>:normal! A @done `(<C-R>=strftime('%d-%m-%Y %H:%M')<CR>)`<CR>]], opts)

-- Highlight completed todo items
vim.g.vimwiki_hl_cb_checked = 0
vim.g.vimwiki_conceal_pre = 1
vim.g.automatic_nested_syntaxes = 1
