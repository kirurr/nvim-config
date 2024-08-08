local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- удалить ошибки диагностики в левом столбце (SignColumn)
vim.diagnostic.config({ signs = false })

-- стандартные горячие клавиши для работы с диагностикой
map('n', '<leader>e', vim.diagnostic.open_float,
	{ noremap = true, silent = true, desc = 'line diagnostic' })
map('n', '[d', vim.diagnostic.goto_prev,
	{ noremap = true, silent = true, desc = 'go to previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next,
	{ noremap = true, silent = true, desc = 'go to next diagnostic' })
map('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- стандартные горячие клавиши для LSP, больше в документации
	-- https://github.com/neovim/nvim-lspconfig
	map('n', 'gD', vim.lsp.buf.declaration, bufopts)
	map('n', 'gd', vim.lsp.buf.definition, bufopts)
	map('n', 'K', vim.lsp.buf.hover, bufopts)
	map('n', 'gi', vim.lsp.buf.implementation, bufopts)
	map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	map('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	map('n', '<leader>r', vim.lsp.buf.rename,
		{ noremap = true, silent = true, buffer = bufnr, desc = "rename" })
	map('n', 'gr', vim.lsp.buf.references, bufopts)
	map('n', '<leader>ca', vim.lsp.buf.code_action,
		{ noremap = true, silent = true, buffer = bufnr, desc = "code action" })
end

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers {
	function(server_name)
		lspconfig[server_name].setup {
			on_attach = on_attach,
			capabilities = capabilities
		}
	end,

	["lua_ls"] = function()
		lspconfig.lua_ls.setup {
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						version = 'LuaJIT',
					},
					diagnostics = {
						globals = { "vim" }
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				}
			},
		}
	end,
}
