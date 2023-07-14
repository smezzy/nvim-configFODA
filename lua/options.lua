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
opt.cursorline = true
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

vim.g.shell = "pwsh"
vim.g.floaterm_shell = "pwsh"

vim.g.mapleader = ' '
