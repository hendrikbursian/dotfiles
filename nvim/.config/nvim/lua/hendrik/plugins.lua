local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup((function(use)
    -- Packer can manage itself ==============================================
    use "wbthomason/packer.nvim"

    -- Utility ===============================================================
    use "nvim-lua/plenary.nvim"

    -- Treesitter
    use { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        run = function()
            pcall(require("nvim-treesitter.install").update { with_sync = true })
        end,
    }
    use { -- Additional text objects via treesitter
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    }
    use { -- Context lines
        "romgrk/nvim-treesitter-context",
        after = "nvim-treesitter",
    }

    -- Better search hightlights
    use "junegunn/vim-slash"

    use "tpope/vim-unimpaired"
    -- use "tpope/vim-obsession"
    use "tpope/vim-abolish"
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup { fast_wrap = {}, }
        end
    }
    use {
        "kylechui/nvim-surround",
    }
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }

    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                ignore = "^$"
            })
        end
    }

    use "ThePrimeagen/vim-be-good"

    use "mbbill/undotree"


    -- Clipboard =============================================================
    use "svermeulen/vim-yoink"

    -- Outline ===============================================================
    use "simrat39/symbols-outline.nvim"

    use { "mg979/vim-visual-multi", branch = "master" }

    -- Navigation ============================================================
    use "ThePrimeagen/harpoon"
    use {
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-telescope/telescope-fzy-native.nvim" }
    }

    -- File tree =============================================================
    use {
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons", },
    }

    -- LSP ===================================================================
    use {
        "neovim/nvim-lspconfig",
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            "j-hui/fidget.nvim",

            -- Additional lua configuration, makes nvim stuff amazing
            "folke/neodev.nvim",

            -- Usage for Linting Actions
            "jose-elias-alvarez/null-ls.nvim",

            -- Extended Typescript Tools
            "jose-elias-alvarez/typescript.nvim",

            -- Extended Rust Tools
            "simrat39/rust-tools.nvim",

            -- Autocompletion for jsonls/yamls
            "b0o/schemastore.nvim"
        },
    }

    -- Debugging =============================================================

    use {
        "mfussenegger/nvim-dap",
        requires = {
            -- Automatic Dap Configuration
            "jayp0521/mason-nvim-dap.nvim",
            "rcarriga/nvim-dap-ui",
            {
                "theHamsta/nvim-dap-virtual-text",
                config = function()
                    require("nvim-dap-virtual-text").setup({})
                end
            },

            {
                "Weissle/persistent-breakpoints.nvim",
                config = function()
                    require("persistent-breakpoints").setup {
                        load_breakpoints_event = { "BufReadPost" }
                    }
                end
            },

            "mxsdev/nvim-dap-vscode-js",

            {
                "leoluz/nvim-dap-go",
                config = function()
                    require("dap-go").setup()
                end
            },

            -- {
            --     "microsoft/vscode-js-debug",
            --     opt = true,
            --     run = "npm install --legacy-peer-deps && npm run compile"
            -- }
        }
    }

    -- Autocompletion ========================================================

    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-calc",

            -- AI
            -- { "tzachar/cmp-tabnine",  run = "./install.sh"  },
            -- { "hrsh7th/cmp-copilot", requires = { "github/copilot.vim" } },

            -- Snippets
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    }

    -- Git ===================================================================
    use "tpope/vim-fugitive"
    use "lewis6991/gitsigns.nvim"
    use "ThePrimeagen/git-worktree.nvim"

    -- Testing ===============================================================
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "olimorris/neotest-phpunit",
            "haydenmeade/neotest-jest",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-phpunit"),
                    require("neotest-jest")({}),
                }
            })
        end
    }
    use "tpope/vim-dispatch"

    -- Formatting ============================================================
    use "gpanders/editorconfig.nvim"
    use "mhartington/formatter.nvim"

    -- Linting ===============================================================
    use "mfussenegger/nvim-lint"

    -- UI ====================================================================
    use "RRethy/vim-illuminate"
    use "gruvbox-community/gruvbox"
    use "NLKNguyen/papercolor-theme"
    use "arcticicestudio/nord-vim"
    use "navarasu/onedark.nvim"
    use "mhinz/vim-startify"

    -- Statusline ============================================================
    use "nvim-lualine/lualine.nvim"

    -- Own Plugins ===========================================================
    use "~/plugins/nvim-eslint"
    use "~/plugins/telescope-dap.nvim/master"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end))

-- When we are bootstrapping a configuration, it doesn"t
-- make sense to execute the rest of the init.lua.
--
-- You"ll need to restart nvim, and then it will work.
if packer_bootstrap then
    print "=================================="
    print "    Plugins are being installed"
    print "    Wait until Packer completes,"
    print "       then restart nvim"
    print "=================================="
    return
end
