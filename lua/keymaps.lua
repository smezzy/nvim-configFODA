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


-- launch love TODO: change kitty to something else
if fn.has("win32") or fn.has("win64") then
    -- set('n', '<F5>', ':!cd build/ && start lovec . &<CR><CR>', opts)
    -- set('n', '<A-l>', ':!cd build/ && start lovec . &<CR><CR>', opts)
    set('n', '<F5>', ':w<CR> :!start run_love.bat &<CR><CR>', opts)
    set('n', '<A-l>', ':w<CR> :!start run_love.bat &<CR><CR>', opts)
elseif fn.has("unix") then
    set('n', '<F5>', ':!kitty -e love .&<CR><CR>:wa<CR>', opts)
    set('n', '<A-l>', ':!kitty -e love .&<CR><CR>', opts)
end


-- toggles
local line_numbers = true
local relative_numbers = true


set('n', '<leader>tnr', function()
    relative_numbers = not relative_numbers
    vim.opt.number = not relative_numbers
    vim.opt.relativenumber = relative_numbers
end)

set('n', '<leader>tnn', function()
    line_numbers = not line_numbers
    vim.opt.number = line_numbers and not relative_numbers
    vim.opt.relativenumber = line_numbers and relative_numbers
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
