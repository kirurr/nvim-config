return {
	"onsails/lspkind-nvim",
	{ "neovim/nvim-lspconfig", lazy = true },
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"css-lsp",
				"emmet-language-server",
				"html-lsp",
				"json-lsp",
				"lua-language-server",
				"typescript-language-server",
				"tailwindcss-language-server",
				"prettier",
				"prettierd",
				"stylua",
			},
			integrations = {
				["mason-lspconfig"] = true,
			},
		},
		cmd = "MasonToolsInstall",
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
}
