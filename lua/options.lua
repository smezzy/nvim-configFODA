local fn = vim.fn
local opt = vim.opt

opt.completeopt = { "menu", "menuone", "noselect" }
opt.mouse = "a"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.number = true
opt.relativenumber = true
opt.cursorline = false
opt.splitbelow = true
opt.splitright = true
opt.showmode = true -- show the -- INSERT --  thing on bottom.. its cool i guess
opt.incsearch = true
opt.hlsearch = false
opt.ignorecase = false
opt.smartcase = true
opt.smartindent = true
opt.laststatus = 0
opt.writebackup = false
opt.swapfile = false
opt.visualbell = false
opt.backup = false
opt.undofile = true
opt.undodir = fn.expand('~/.config/nvim/undodir')
opt.scrolloff = 8
opt.signcolumn = "no"
opt.wrap = false
opt.termguicolors = true
opt.fillchars = { eob = " " }

opt.foldmethod = "marker"

vim.g.shell = "pwsh"
vim.g.floaterm_shell = "pwsh"

vim.g.mapleader = ' '
vim.g.skip_ts_context_commentstring_module = true

vim.o.guicursor = 'i:block'

if vim.g.neovide then
    -- vim.o.guifont = "JetBrains Mono:h12:#e-antialias:#h-none"
    vim.g.neovide_scroll_animation_length = 0.15
    vim.g.neovide_theme = 'auto'
    vim.g.neovide_floating_shadow = false
    vim.g.neovide_cursor_animation_length = 0.0
    -- vim.g.neovide_trail_animation_length = 0.1
    vim.g.neovide_cursor_unfocused_outline_width = 0.1
    opt.number = false
    opt.relativenumber = false
end
