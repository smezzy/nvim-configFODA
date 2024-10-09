local api = vim.api
local fn = vim.fn

local opts = {
    noremap = true,
    silent = true,
}

local set = vim.keymap.set

set('', '<Space>', '<Nop>', opts)

-- navigate buffers
set('n', '<C-h>', '<C-w>h', opts)
set('n', '<C-j>', '<C-w>j', opts)
set('n', '<C-k>', '<C-w>k', opts)
set('n', '<C-l>', '<C-w>l', opts)

set('n', '<Leader>ee', ':Explore<CR>', opts)

-- resizing with arrows
set('n', '<C-Up>', ':resize -2<CR>', opts)
set('n', '<C-Down>', ':resize +2<CR>', opts)
set('n', '<C-Left>', ':vertical resize +2<CR>', opts)
set('n', '<C-Right>', ':vertical resize -2<CR>', opts)

-- dont lose the selected area when identing on visual mode
set('v', '<', '<gv', opts)
set('v', '>', '>gv', opts)

-- saving file
set('n', '<C-s>', ':w<CR>', opts)
set('n', '<leader>fs', ':w<CR>', opts)

-- move lines like alt in vscode
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set('i', 'ç', ';', opts)
set('i', 'Ç', ':', opts)

set("n", "<Leader>y", '"+y', opts)
set("n", "<Leader>p", '"+p', opts)
set("v", "<Leader>y", '"+y', opts)

set("n", "<Leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- window managment
set("n", "<Leader>ws", "<C-w>s", opts)
set("n", "<Leader>wv", "<C-w>v", opts)
set("n", "<Leader>wq", "<C-w>q", opts)
set("n", "<Leader>wh", "<C-w>h", opts)
set("n", "<Leader>wl", "<C-w>l", opts)
set("n", "<Leader>wj", "<C-w>j", opts)
set("n", "<Leader>wk", "<C-w>k", opts)

-- -- launch love TODO: change kitty to something else
-- if fn.has("win32") or fn.has("win64") then
--     -- set('n', '<F5>', ':!cd build/ && start lovec . &<CR><CR>', opts)
--     -- set('n', '<A-l>', ':!cd build/ && start lovec . &<CR><CR>', opts)
--     -- set('n', '<F5>', ':w<CR> :!start run_love.bat &<CR><CR>', opts)
--     -- set('n', '<A-l>', ':w<CR> :!start run_love.bat &<CR><CR>', opts)
-- elseif fn.has("unix") then
--     set('n', '<F5>', ':wa<CR> :!blackbox -c love .<CR><CR>', opts)
--     set('n', '<A-l>', ':wa<CR> :!blackbox -c love .<CR><CR>', opts)
-- end
set('n', '<F5>', ':wa<CR> :!kitty -e love .<CR><CR>', opts)
set('n', '<A-l>', ':wa<CR> :!kitty -e love .<CR><CR>', opts)

local ln_idx = 1
local line_numbers = {
    [1] = { true, false },
    [2] = { false, true },
    [3] = { true, true },
    [4] = { false, false },
}

set('n', '<leader>tnn', function()
    vim.opt.number = line_numbers[ln_idx][1]
    vim.opt.relativenumber = line_numbers[ln_idx][2]
    ln_idx = (ln_idx % #line_numbers) + 1
end)

local cmp = require "cmp"

set('n', '<leader>tc', ':ToggleAutoCmp<CR>')

set('i', '<C-Space>', cmp.complete)

-- special clients etc that kind of stuff
if vim.g.neovide then
    set({ 'n', 'v', 'i' }, '<F11>', function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end)
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", ":IncreaseScale<CR>")
    vim.keymap.set("n", "<C-->", ":DecreaseScale<CR>")

    vim.api.nvim_create_user_command("IncreaseScale", function() change_scale_factor(1.25) end, {})
    vim.api.nvim_create_user_command("DecreaseScale", function() change_scale_factor(1 / 1.25) end, {})
end
