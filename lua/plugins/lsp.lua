return {
	'neovim/nvim-lspconfig',
	dependencies = {
		{ "williamboman/mason.nvim",           opts = {} },
		{ "williamboman/mason-lspconfig.nvim", tag = 'v1.32.0' }, -- this is the last version where mason lsp-config supports a generic lsp-Servers config on the next versions it is required to setup each one by yourself
		'hrsh7th/cmp-nvim-lsp',
	},

	config = function()
		local lsp = require("mason-lspconfig")
		require("mason").setup()
		local lsp_config = require('lspconfig')

		local init_options = {
			bundles = {}
		}
		local on_attach = function(client, bufnr)
			-- Same keymaps as before
			local opts = { buffer = bufnr, remap = false }
			vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, opts)
			vim.keymap.set("n", "<leader>q", function() vim.lsp.buf.hover() end, opts)
			vim.keymap.set("n", "<leader>cw", function() vim.lsp.buf.workspace_symbol() end, opts)
			vim.keymap.set("n", "<leader>cf", function() vim.diagnostic.open_float() end, opts)
			vim.keymap.set("n", "<leader>cn", function() vim.diagnostic.goto_next() end, opts)
			vim.keymap.set("n", "<leader>cp", function() vim.diagnostic.goto_prev() end, opts)
			vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
			vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, opts)
			vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
			vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
		end

		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- Setup LSP Servers
		lsp.setup_handlers({
			function(server_name)
				lsp_config[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		})
	end
}
