return  {
    "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"lua", "c", "vim", "vimdoc", "query", "markdown", "markdown_inline"},
            auto_install = true,
            highlight = {
                enable = true,
            },

            compiler = { "zig", "gcc" },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Leader>ss", -- set to `false` to disable one of the mappings
                    node_incremental = "<Leader>v",
                    scope_incremental = "<Leader>sc",
                    node_decremental = "<Leader>V",
                },
            },

        })
    end
}
