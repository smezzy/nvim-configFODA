local api = vim.api
local fn = vim.fn

local opts = {
    noremap = true,
    silent = true,
}

local set = vim.keymap.set


vim.g.mapleader = ' '
set('', '<Space>', '<Nop>', opts)

-- navigate buffers
set('n', '<C-h>', '<C-w>h', opts)
set('n', '<C-j>', '<C-w>j', opts)
set('n', '<C-k>', '<C-w>k', opts)
set('n', '<C-l>', '<C-w>l', opts)

set('n', '<Leader>ee', ':Ex<CR>', opts)

-- resizing with arrows
set('n', '<C-Up>', ':resize -2<CR>', opts)
set('n', '<C-Down>', ':resize +2<CR>', opts)
set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- dont lose the selected area when identing on visual mode
set('v', '<', '<gv', opts)
set('v', '>', '>gv', opts)

set('n', '<C-s>', ':w<CR>', opts)

set('i', 'ç', ';', opts)
set('i', 'Ç', ':', opts)

-- launch love TODO: change kitty to something else
if fn.has("win32") or fn.has("win64") then
    set('n', '<F5>', ':!start lovec .&<CR><CR>', opts)
    set('n', '<A-l>', ':!start lovec .&<CR><CR>', opts)
elseif fn.has("unix") then
    set('n', '<F5>', ':!kitty -e love .&<CR><CR>', opts)
    set('n', '<A-l>', ':!kitty -e love .&<CR><CR>', opts)
end

