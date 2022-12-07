local util = require('lspconfig.util')
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

return require('packer').startup((function(use)
    -- Packer can manage itself ==============================================
    use 'wbthomason/packer.nvim'

    -- TODO
    -- [ ] Start screen

    -- My plugins start here!!
    -- =======================================================================

    -- Utility ===============================================================
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'romgrk/nvim-treesitter-context'
    use 'tpope/vim-unimpaired'
    -- use 'tpope/vim-obsession'
    use 'tpope/vim-abolish'
    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup {
                fast_wrap = {},
            }
        end
    }
    use {
        'kylechui/nvim-surround',
        config = function() require('nvim-surround').setup() end
    }
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                ignore = '^$'
            })
        end
    }

    use 'ThePrimeagen/vim-be-good'

    use { 'mbbill/undotree' }

    -- Installer
    use {
        'williamboman/mason.nvim',
        requires = {
            'williamboman/mason-lspconfig.nvim',
        },

        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                automatic_installation = true,
            })
        end
    }

    -- Clipboard =============================================================
    use 'svermeulen/vim-yoink'

    -- Outline ===============================================================
    use 'simrat39/symbols-outline.nvim'

    use { 'mg979/vim-visual-multi', branch = 'master' }

    -- Navigation ============================================================
    use 'ThePrimeagen/harpoon'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-telescope/telescope-fzy-native.nvim' }
    }

    -- File tree =============================================================
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons', },
    }

    -- LSP ===================================================================
    use 'neovim/nvim-lspconfig'
    use 'jose-elias-alvarez/null-ls.nvim'

    use 'jose-elias-alvarez/typescript.nvim'

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
    use 'b0o/schemastore.nvim'

    -- Git ===================================================================
    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'tpope/vim-fugitive'
    use 'ThePrimeagen/git-worktree.nvim'

    -- Debugging =============================================================
    use 'mfussenegger/nvim-dap'
    use {
        'microsoft/vscode-js-debug',
        opt = true,
        run = 'npm install --legacy-peer-deps && npm run compile'
    }
    use 'mxsdev/nvim-dap-vscode-js'
    use { 'leoluz/nvim-dap-go',
        config = function()
            require('dap-go').setup({})
        end
    }
    use { 'theHamsta/nvim-dap-virtual-text',
        config = function()
            require('nvim-dap-virtual-text').setup({})
        end
    }
    use 'rcarriga/nvim-dap-ui'
    use { 'Weissle/persistent-breakpoints.nvim',
        config = function()
            require('persistent-breakpoints').setup {
                load_breakpoints_event = { "BufReadPost" }
            }
        end
    }

    -- Testing ===============================================================
    use {
        'nvim-neotest/neotest',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'olimorris/neotest-phpunit',
            'haydenmeade/neotest-jest',
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-phpunit'),
                    require('neotest-jest')({}),
                }
            })
        end
    }
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
    use 'arcticicestudio/nord-vim'
    use 'mhinz/vim-startify'

    -- Statusline ============================================================
    use 'nvim-lualine/lualine.nvim'

    -- Own Plugins ===========================================================
    use '~/plugins/nvim-eslint'
    use '~/plugins/telescope-dap.nvim/master'

    if Packer_bootstrap then
        require('packer').sync()
    end
end))
