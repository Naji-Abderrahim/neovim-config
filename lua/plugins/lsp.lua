return {
	'neovim/nvim-lspconfig',
	dependencies = {
		{ "williamboman/mason.nvim",           opts = {} },
		{ "williamboman/mason-lspconfig.nvim", tag = 'v1.32.0' }, -- this is the last version where mason lsp-config supports a generic lsp-Servers config on the next versions it is required to setup each one by yourself
		'hrsh7th/cmp-nvim-lsp',
	},

	config = function()
		local m_lsp = require("mason-lspconfig")
		require("mason").setup()
		local lsp_config = require('lspconfig')

		local init_options = {
			bundles = {}
		}
		-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
		-- 	vim.lsp.handlers.hover,
		-- 	{
		-- 		border = "rounded",     -- "single", "double", "shadow", etc.
		-- 	}
		-- )
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e" })
		-- vim.api.nvim_set_hl(0, "LspMarkdownHeading", { fg = "#f38ba8", bold = true })
		-- vim.api.nvim_set_hl(0, "LspCodeBlock",        { bg = "#313244" })
		-- vim.api.nvim_set_hl(0, "LspInlayHint",        { fg = "#f38ba8" })

		-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#1e1e2e", bg = "#1e1e2e" })
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local opts = { buffer = bufnr}

				vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, opts)
				-- vim.keymap.set("n", "<leader>q", function() vim.lsp.buf.hover() end, opts)
				vim.keymap.set("n", "<leader>q", require("hover").hover, {})
				vim.keymap.set("n", "<leader>cw", function() vim.lsp.buf.workspace_symbol() end, opts)
				vim.keymap.set("n", "<leader>cf", function() vim.diagnostic.open_float() end, opts)
				vim.keymap.set("n", "<leader>cn", function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "<leader>cp", function() vim.diagnostic.goto_prev() end, opts)
				vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
				vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, opts)
				vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
				vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
			end,
		})

		m_lsp.setup_handlers({
			function(server)
				vim.lsp.enable(server)
			end,
		})

	end
}
