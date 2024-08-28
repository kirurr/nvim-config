return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "catppuccin",
			},
			sections = {
				lualine_a = {
					{
						"buffers",
						symbols = {
							modified = " ●",
							alternate_file = "",
							directory = "",
						},
						use_mode_colors = true,
					},
				},
				lualine_c = {},
				lualine_x = { "filetype" },
				lualine_z = {
					"mode",
				},
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "echasnovski/mini.icons", version = false, opts = {} },

	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		init = function()
			if vim.fn.argc(-1) == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree").setup({
						filesystem = {
							hijack_netrw_behavior = "open_current",
						},
					})
				end
			end
		end,
		opts = {

			use_libuv_file_watcher = true,
			follow_current_file = {
				enabled = true,
			},
			filesystem = {
				filtered_items = {
					hide_gitignored = true,
				},
			},
		},

		keys = { {
			"<F4>",
			":Neotree toggle<cr>",
			desc = "Toggle file tree",
			silent = true,
		} },
	},

	{
		"tpope/vim-commentary",
		cmd = "Commentary",
	},

	"ap/vim-css-color",

	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({
				with_sync = true,
			})()
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					"json",
					"html",
					"css",
					"tsx",
					"javascript",
					"typescript",
				},
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				modules = {},
				auto_install = true,
				ignore_install = {},
			})
		end,
	},

	"nvim-treesitter/nvim-treesitter-context",

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					extensions = {
						fzf = {
							fuzzy = true,
							override_generic_sorter = true,
							override_file_sorter = true,
							case_mode = "smart_case",
						},
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
		keys = {
			{
				"<F2>",
				"<cmd>Telescope find_files<cr>",
				desc = "Open telescope file finder",
			},
			{
				"<F3>",
				"<cmd>Telescope live_grep<cr>",
				desc = "Open telescope live grep",
			},
		},
	},

	-- "powerman/vim-plugin-ruscmd",

	-- {
	-- 	"christoomey/vim-tmux-navigator",
	-- 	cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight", "TmuxNavigatePrevious" },
	-- 	keys = {
	-- 		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
	-- 		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
	-- 		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
	-- 		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
	-- 		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	-- 	},
	-- },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 600
		end,
		opts = {},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "▏",
			},
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},

	{
		"supermaven-inc/supermaven-nvim",
		opts = {
			keymaps = {
				accept_suggestion = "<C-CR>",
				accept_word = "<C-j>",
			},
			log_level = "off",
		},
		event = { "BufRead", "BufNewFile", "BufEnter" },
	},

	{ "brenoprata10/nvim-highlight-colors", opts = {} },
}
