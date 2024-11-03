return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VimEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/todo-comments.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        {
            "nvim-tree/nvim-web-devicons",
            enabled = vim.g.have_nerd_font
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = {
                    "smart",
                },
                hidden = true,
                layout_config = {
                    prompt_position = "bottom",
                    width = 0.75,
                    height = 0.75,
                },
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
                extensions = {
                    fzf = {
                        override_generic_sorter = true,
                        override_file_sorter = true,
                    },
                },
            },
        })

        -- Load extensions
        telescope.load_extension("fzf")
        telescope.load_extension("todo-comments")

        -- Set keybindings
        local keymap = vim.keymap  -- for convenience

        local builtin = require("telescope.builtin")

        keymap.set("n", "<leader>ff", function()
            builtin.find_files({ hidden = true })
        end, { desc = "[F]ind [F]iles" })
        keymap.set("n", "<leader>fg", function()
            builtin.live_grep()
        end, { desc = "[F]ind [G]rep" })
        keymap.set("n", "<leader>/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "[S]earch within open files" })

        keymap.set("n", "<leader>sf", builtin.git_files, { desc = "[S]earch [F]iles in git" })
        keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch Telescope features" })
        keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume last search" })
        keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch recent files' })
        keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find open buffers" })

        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[F]ind [T]odo comments" })
    end,
}
