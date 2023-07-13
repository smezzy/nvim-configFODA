local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- My plugins here

    use { 'ellisonleao/gruvbox.nvim' }

    use {'neovim/nvim-lspconfig' }
    use { 'hrsh7th/nvim-cmp', config = function() require('config.nvim-cmp') end }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }        -- buffer auto-completion
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }          -- path auto-completion
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }       -- cmdline auto-completion
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim'}

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        requires = { { "windwp/nvim-ts-autotag" } , { "JoosepAlviste/nvim-ts-context-commentstring" } },
        config = function() require('config.treesitter') end,
    }

    use { 'voldikss/vim-floaterm', config = function() require("config.floaterm") end }

    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.2',
      requires = { {'nvim-lua/plenary.nvim'} },
      config = function() require("config.telescope") end,
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use { 'nvim-orgmode/orgmode', config = function()
            require('orgmode').setup{}
            require('config.orgmode')
        end
    }

    use 'wakatime/vim-wakatime'

    use 'brenoprata10/nvim-highlight-colors'

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    require("gruvbox").setup({ transparent_mode = true })

    if packer_bootstrap then
        require('packer').sync()
    end
end)


