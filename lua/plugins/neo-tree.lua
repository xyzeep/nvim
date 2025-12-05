return { 
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()

        require("neo-tree").setup({
            window = {
                position = "left",
                width = 30,         -- neotree's split width
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = true,
                },
            },
        })

        -- keymap to toggle Neotree
        vim.keymap.set('n', '<C-n>', function()
            require("neo-tree.command").execute({
                toggle = true,
                dir = vim.loop.cwd(),
                reveal = true,
                position = "left",
                source = "filesystem"
            })
        end, { noremap = true, silent = true })
    end
}
