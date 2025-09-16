local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- My plugins here

    --colorschemes
    use { 'ellisonleao/gruvbox.nvim' }
    use "blazkowolf/gruber-darker.nvim"
    use 'cocopon/iceberg.vim'
    use 'rose-pine/neovim'


    -- lsp ide stuff
    use { 'neovim/nvim-lspconfig' }
    use { 'hrsh7th/nvim-cmp', config = function() require('config.nvim-cmp') end }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }  -- buffer auto-completion
    use { 'hrsh7th/cmp-path' }    -- path auto-completion
    use { 'hrsh7th/cmp-cmdline' } -- cmdline auto-completion
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use { 'williamboman/mason.nvim', run = ":MasonUpdate" }
    use { 'williamboman/mason-lspconfig.nvim' }
    use { 'onsails/lspkind.nvim' }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        requires = { { "windwp/nvim-ts-autotag" } },
        config = function() require('config.treesitter') end,
    }

    -----------------------------------------------------------------------------------------

    -- telescope
    use { 'voldikss/vim-floaterm', config = function() require("config.floaterm") end }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function() require("config.telescope") end,
    }
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }


    use { 'RRethy/nvim-treesitter-endwise' }

    -- project management
    use 'Shatur/neovim-session-manager'

    -- vscode stuff
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use { 'brenoprata10/nvim-highlight-colors', config = function()
        require('nvim-highlight-colors').setup {}
        require('config.colors')
    end
    }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use "lukas-reineke/indent-blankline.nvim"


    -- idk evenk now what that does i guess it confiigures lsps automaticaly but configuring sumneko is pretty easy but maybe in some future i will find this useful
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },                  -- Required
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
            { 'L3MON4D3/LuaSnip' },                  -- Required
        }
    }



    -- require plugin configs
    require "config"

    -- Requires nvim-treesitter installed
    require('nvim-treesitter.configs').setup {
        endwise = {
            enable = true,
        },
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
