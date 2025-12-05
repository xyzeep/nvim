return {
    "andweeb/presence.nvim",
    config = function()
        require("presence").setup({
            neovim_image_text = "Your (respected) mother.",
            show_time = false, -- doesn't work tho

            editing_text = "Writing %s",
            workspace_text = "Inside directory %s"
        })
    end
}
