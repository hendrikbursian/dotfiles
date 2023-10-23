return {

    {
        "antosha417/nvim-lsp-file-operations",
        event = "LspAttach",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim",
        },
        config = true,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<C-b>",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.fn.expand("%:p:h") })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
            { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
            {
                "<leader>ge",
                function()
                    require("neo-tree.command").execute({ source = "git_status", toggle = true })
                end,
                desc = "Git explorer",
            },
            {
                "<leader>be",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer explorer",
            },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            if vim.fn.argc(-1) == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = function()
            local function getTelescopeOpts(state, path)
                return {
                    cwd = path,
                    search_dirs = { path },
                    attach_mappings = function(prompt_bufnr, map)
                        local actions = require "telescope.actions"
                        actions.select_default:replace(function()
                            actions.close(prompt_bufnr)
                            local action_state = require "telescope.actions.state"
                            local selection = action_state.get_selected_entry()
                            local filename = selection.filename
                            if (filename == nil) then
                                filename = selection[1]
                            end
                            -- any way to open the file without triggering auto-close event of neo-tree?
                            require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
                        end)
                        return true
                    end
                }
            end

            return {
                sources = { "filesystem", "buffers", "git_status", "document_symbols" },
                open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
                filesystem = {
                    bind_to_cwd = false,
                    follow_current_file = {
                        enabled = false
                    },
                    use_libuv_file_watcher = true,
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },
                window = {
                    mappings = {
                        ["<space>"] = "none",
                        ["w"] = "none",
                        ["S"] = "none",
                        ["/"] = "none",

                        ["s"] = "system_open",
                        ["<C-x>"] = "open_split",
                        ["<C-v>"] = "open_vsplit",
                        ["ff"] = "telescope_find",
                        ["fg"] = "telescope_grep",
                    },
                },
                commands = {
                    system_open = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()

                        vim.ui.open(path)
                    end,
                    telescope_find = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        require('telescope.builtin').find_files(getTelescopeOpts(state, path))
                    end,
                    telescope_grep = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        require('telescope.builtin').live_grep(getTelescopeOpts(state, path))
                    end,
                },
                default_component_configs = {
                    indent = {
                        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                },
            }
        end,
        config = function(_, opts)
            require("neo-tree").setup(opts)

            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    }
}
