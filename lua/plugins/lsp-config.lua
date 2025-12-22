return {
	{
		-- installs and manages language servers
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		-- gives ensure_install property to mason
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pylsp", "ts_ls", "eslint", "emmet_ls"},
			})
		end,
	},
	{
		-- hooks up our nvim to the LSs and establishes the connection back and forth
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			vim.lsp.enable("lua_ls")
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
			})
		end,
	},
}
