return require('packer').startup(function(use)
    -- Packer can manage itself ==============================================
    use 'wbthomason/packer.nvim'

    -- TODO
    -- https://github.com/tpope/vim-commentary
    -- Start screen

    use 'rstacruz/vim-closer'
    use { 'andymass/vim-matchup', event = 'VimEnter' }

    -- My plugins start here!!
    -- =======================================================================

    -- Utils =================================================================
    use 'nvim-lua/plenary.nvim'

    -- Clipboard =============================================================
    use 'svermeulen/vim-yoink'

    -- Outline ===============================================================
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'simrat39/symbols-outline.nvim'

    use { 'mg979/vim-visual-multi', branch = 'master' }

    -- Navigation ============================================================
    use 'ThePrimeagen/harpoon'
    use { 'nvim-telescope/telescope.nvim',
        requires = { 'nvim-telescope/telescope-fzy-native.nvim' }
    }

    -- File tree =============================================================
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons', },
    }

    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'

    -- LSP ===================================================================
    use 'williamboman/nvim-lsp-installer'
    use 'neovim/nvim-lspconfig'
    use 'ThePrimeagen/refactoring.nvim'

    -- Autocompletion ========================================================
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-calc'
    use 'hrsh7th/nvim-cmp'
    --     use 'tzachar/cmp-tabnine', { 'do' = './install.sh' }
    --     use 'github/copilot.vim'
    --     use 'hrsh7th/cmp-copilot'
    use 'nvim-lua/lsp_extensions.nvim'

    -- Git ===================================================================
    use { 'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'tpope/vim-fugitive'
    use 'ThePrimeagen/git-worktree.nvim'

    -- Debugging =============================================================
    -- TODO: Check this
    -- use 'vim-vdebug/vdebug'
    use 'mfussenegger/nvim-dap'
    use { 'Pocco81/dap-buddy.nvim', commit = '24923c3' }
    use 'theHamsta/nvim-dap-virtual-text'

    -- Testing ===============================================================
    use 'vim-test/vim-test'
    use 'tpope/vim-dispatch'

    -- Formatting ============================================================
    use 'gpanders/editorconfig.nvim'
    use 'sbdchd/neoformat'

    -- Linting ===============================================================
    use 'mfussenegger/nvim-lint'

    -- Snippets ==============================================================
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- UI ====================================================================
    use 'RRethy/vim-illuminate'
    use 'gruvbox-community/gruvbox'
    use 'NLKNguyen/papercolor-theme'

    -- Statusline ============================================================
    use 'nvim-lualine/lualine.nvim'

    -- Own Plugins ===========================================================
    use '/home/hendrik/plugins/nvim-eslint'
    use '/home/hendrik/plugins/telescope-dap.nvim/master'

end)